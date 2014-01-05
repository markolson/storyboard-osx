class TestController < TeacupWindowController
  attr_accessor :mainWindow,:containerView, :scrollView, :items

  def init
    super
    loadWindow
    self
  end

  def loadWindow
    @items = []
    self.window = NSWindow.alloc.initWithContentRect([[400, 400], [600, 96]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)

    self.window.delegate = self
    self.window.maxSize = [600,700]
    self.window.minSize = [600,108]
    self.window.orderFrontRegardless

    @scrollView = NSScrollView.alloc.initWithFrame(self.window.contentView.bounds)
    scrollView.hasVerticalScroller = true
    scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable
    scrollView.translatesAutoresizingMaskIntoConstraints = true
    self.window.contentView.addSubview(scrollView)

    @containerView = NSView.alloc.initWithFrame(scrollView.bounds)
    containerView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable
    containerView.translatesAutoresizingMaskIntoConstraints  = true
    scrollView.documentView = @containerView

    addBox("Test One")
    addBox("Test Two")

    self.window

  end

  def redrawBoxes
    max = [96*@items.count,window.frame.size.height].max
    @containerView.frame = [[0,0],[600,max]]

    @items.each_with_index {|box,i|
      box.frame = [[8,max-(96*(i+1))],[584,80]]
    }
  end

  def windowDidResize(e)
    redrawBoxes
  end

  def addBox(named)

    box = NSBox.alloc.initWithFrame([[8,8],[584,80]])
    @containerView.addSubview(box)
    box.title = named
    @items << box
    redrawBoxes
    @scrollView.verticalScroller.floatValue = @items.last.frame.origin.y

  end
end