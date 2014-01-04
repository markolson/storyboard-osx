class StartController < TeacupWindowController
  attr_accessor :filepath, :file_button, :video_types
  stylesheet :pick_video_mode

  def loadWindow
		@video_types = [".mov", ".mkv", ".avi", ".mp4"]
    @filefound_notification_handler = App.notification_center.observe 'StoryboardFileSelected' do |notification|
      @filepath.stringValue = notification.userInfo
    end

    self.window = NSWindow.alloc.initWithContentRect([[400, 400], [600, 180]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
  end

	def openDialog(event)
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

	layout do |view|
		subview(NSBox, :box) do |box|
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
end