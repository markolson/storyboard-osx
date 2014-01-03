class StoryboardController < TeacupWindowController
  attr_accessor :dragarea, :filepath, :file_button, :subpath, :subpath_button
  stylesheet :main_window

  def loadWindow
    self.window = NSWindow.alloc.initWithContentRect([[400, 400], [600, 180]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
  end

  def pickVideo(path)
    @filepath.stringValue = "butts"
  end

	layout do |view|
    @dragarea = subview(DragView, :dragarea)

    @filepath = subview(NSTextField, :filepath)
    @subpath = subview(NSTextField, :subpath)

    @file_button = subview(NSButton, :filepath_button)
    @subpath_button = subview(NSButton, :subpath_button)
  end
end