class StoryboardController < TeacupWindowController
  attr_accessor :dragarea, :filepath, :file_button, :subpath, :subpath_button

  attr_reader :filefound

  stylesheet :main_window

  def loadWindow

    @filefound = App.notification_center.observe 'StoryboardFileSelected' do |notification|
      pickVideo(notification.userInfo)
    end

    self.window = NSWindow.alloc.initWithContentRect([[400, 400], [600, 180]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
  end

  def pickVideo(path)
    @filepath.stringValue = path
  end

	layout do |view|
    @dragarea = subview(DragView, :dragarea)

    @filepath = subview(NSTextField, :filepath)
    @filepath.cell.lineBreakMode = NSLineBreakByTruncatingHead
    @subpath = subview(NSTextField, :subpath)

    @file_button = subview(NSButton, :filepath_button)
    @file_button.target = @dragarea
    @file_button.action = 'openDialog:'
    @subpath_button = subview(NSButton, :subpath_button)
  end
end