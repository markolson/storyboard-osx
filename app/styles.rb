Teacup::Stylesheet.new :main_window do
	style :dragarea,
      frame: [[10, 10], [160, 160]],
      image: NSImage.imageNamed('dragarea')

  style NSTextField, height: 22, width: 300, enabled: false, selectable: false

  style :filepath, 
  	origin: [180, 135]

  style :subpath, 
  	origin: [180, 105]

  style NSButton, width: 110, height: 24, bezelStyle: NSRoundedBezelStyle

  style :filepath_button,
  	origin: [490, 132],
  	title: "Pick Video"

  style :subpath_button, 
  	origin: [490, 102],
  	title: "Pick Subtitles"
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