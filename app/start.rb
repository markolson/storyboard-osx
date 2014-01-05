class StartController < TeacupWindowController
  attr_accessor :filepath, :file_button, :video_types

  attr_accessor :container, :scroll_view
  stylesheet :pick_video_mode

  def loadWindow
    @height = 100
    @items = []

    @video_types = [".mov", ".mkv", ".avi", ".mp4"]
    @filefound_notification_handler = App.notification_center.observe 'StoryboardFileSelected' do |notification|
      @filepath.stringValue = notification.userInfo
    end

    self.window = NSWindow.alloc.initWithContentRect([[400, 400], [600, 96]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)

    self.window.setContentMaxSize([600,250])
    self.window
  end

  def openDialog(event)
    addProgressbar('Scanning File')
    return
    dialog = NSOpenPanel.openPanel
    dialog.delegate = self
    dialog.canChooseFiles = true
    dialog.canChooseDirectories = false
    dialog.allowsMultipleSelection = false
   
    if dialog.runModalForDirectory(nil, file:nil) == NSOKButton
      App.notification_center.post('StoryboardFileSelected', self, dialog.filenames.first)
    end
  end

  def panel(panel, shouldShowFilename: filename)
    return (video_types.include? File.extname(filename)) || File.directory?(filename)
  end

  def addProgressbar(named)

    constraints = [
      Teacup::Constraint.new(:self, :top).equals(@items.last, :bottom).plus(8),
      Teacup::Constraint.new(:self, :left).equals(:superview, :left).plus(8),
      Teacup::Constraint.new(:self, :right).equals(:superview, :right).minus(8),
      Teacup::Constraint.new(:self, :height).equals(80)
    ]

    layout(container) do
      instance = subview(NSBox, left: 0, top: @items.count * 2, height: 80, autoresizingMask: NSViewWidthSizable)
      self.window.top_level_view.apply_constraints

      @items << instance
    end

    windowFrame = self.window.frame
    windowFrame.size.height += 88;

    if windowFrame.size.height <= window.maxSize.height
      windowFrame.origin.y -= 88;
    else
      windowFrame.size.height = window.maxSize.height
      windowFrame.origin.y -= (window.maxSize.height - self.window.frame.size.height)
    end
    window.setFrame(windowFrame, display:true, animate:true)

    if container
      p container.bounds
    end
    if scroll_view
      p scroll_view.contentSize
      p scroll_view.contentView.bounds
      p scroll_view.documentView.bounds
      p scroll_view.bounds
    end
  end


  layout do |view|

    @container = subview(NSView, :container_view) do 
      @items << subview(NSBox, :box) do |box|
        box.title = "Pick Video and Mode"

        subview(NSTextField, :make_a).setStringValue('Make a')
        subview(NSTextField, :from).setStringValue('From')

        @selector = subview(NSPopUpButton, :formats).addItemsWithTitles(["Book with Storyboard", "GIF with some text", "30 second recap GIF"])

        @filepath = subview(NSTextField, :filepath)
        @filepath.cell.lineBreakMode = NSLineBreakByTruncatingHead
        @filepath.cell.placeholderString = "Choose a file..."

        @file_button = subview(NSButton, :filepath_button)
        @file_button.target = @dragarea
        @file_button.action = 'openDialog:'
      end
    end


    @container.removeFromSuperview
    @container.translatesAutoresizingMaskIntoConstraints = false;

    @scroll_view = subview(NSScrollView, :scroll_view)


    @scroll_view.setDocumentView(@container)
    @scroll_view.hasVerticalScroller = true

    addProgressbar("test")
  end
end