class StoryboardController < TeacupWindowController
  attr_accessor :dragarea
  stylesheet :main_window



  def loadWindow
    self.window = NSWindow.alloc.initWithContentRect([[400, 400], [600, 170]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
  end

  def open(sender)
    p "whhhhaaat"
    p sender
  end


	layout do |view|
    @dragarea = subview(DragView,
      frame: [[10, 10], [150, 150]],
      image: NSImage.imageNamed('dragarea'),
      target: self,
      action: 'open:',
    )

  end
end