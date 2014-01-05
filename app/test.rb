class TestController < TeacupWindowController
  attr_accessor :container, :scroll_view, :items
  stylesheet :pick_video_mode

  def loadWindow
  	@items = []
    self.window = NSWindow.alloc.initWithContentRect([[400, 400], [600, 96]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)

    self.window.setContentMaxSize([600,150])
    self.window
  end

  def addPanel(name)
    constraints = [
      Teacup::Constraint.new(:self, :top).equals(@items.last || :superview, :bottom).plus(8),
      Teacup::Constraint.new(:self, :left).equals(:superview, :left).plus(8),
      Teacup::Constraint.new(:self, :right).equals(:superview, :right).minus(8),
      Teacup::Constraint.new(:self, :height).equals(80)
    ]

    layout(container) do
      instance = subview(NSBox, constraints: constraints)
      self.window.top_level_view.apply_constraints
      instance.title = name
      @items << instance
    end
  end


  layout do |view|

    @container = NSView.new
    @container.translatesAutoresizingMaskIntoConstraints = false;

    @scroll_view = subview(NSScrollView, :scroll_view)

    @scroll_view.setDocumentView(@container)
    @scroll_view.hasVerticalScroller = true

    addPanel "test"
  end
end