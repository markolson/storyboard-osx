Teacup::Stylesheet.new :main_window do
	
end


Teacup::Stylesheet.new :player do
		style :screen,
  	backgroundColor: NSColor.blackColor,
  	height: 320,
  	width: 480,
	  constraints: [
	    constrain(:top).equals(:superview, :top),
	    constrain(:left).equals(:superview, :left),
	    constrain(:right).equals(:superview, :right),
	    constrain(:bottom).equals(:scrobber, :top),
	  ]

  style :scrobber,
    top: 100,
    height: 30,
	  constraints: [
	    constrain_left(50),
	    constrain(:right).equals(:superview, :right),
	    constrain(:bottom).equals(:superview, :bottom),
	  ]

	 style :duration,
	  top: 100,
    height: 30,
    backgroundColor: NSColor.redColor,
	  constraints: [
	    constrain(:left).equals(:superview, :left),
	    constrain(:right).equals(:scrobber, :left),
	    constrain(:bottom).equals(:superview, :bottom),
	  ]

  style :player,
    backgroundColor: NSColor.blackColor

end