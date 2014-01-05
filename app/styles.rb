Teacup::Stylesheet.new :pick_video_mode do

  style :scroll_view,
    frame: NSMakeRect(0, 0, 480, 300),
    autoresizingMask: autoresize.fill,
    hasVerticalScroller: true

  style :table_view,
    autoresizingMask: autoresize.fill


  style :container_view,
    constraints: [
      constrain_top(0),
      constrain_left(0),
      constrain_bottom(0),
      constrain_right(0),
    ]
    
  style :box,
    constraints: [
      constrain_top(8),
      constrain_left(8),
      constrain(:right).equals(:superview, :right).minus(8),
      constrain(:height).at_least(80),
      constrain(:width).at_least(400),
    ]


  style :label,
    selectable: false,
    editable: false,
    bezeled: false,
    drawsBackground: false

  style :make_a, extends: :label,
    constraints: [
      constrain_top(8),
      constrain(:left).equals(:superview, :left).plus(8),
      constrain_width(45),
    ]

  style :formats,
    constraints: [
      constrain(:center_y).equals(:make_a, :center_y),
      constrain_to_right(:make_a),
      constrain(:width).at_most(200)
    ]    

  style :from, extends: :label,
    constraints: [
      constrain_below(:make_a, 8),
      constrain(:left).equals(:superview, :left).plus(8),
      constrain(:right).equals(:filepath, :left),
      constrain_width(45),
    ]

  style :filepath,
    selectable: false,
    constraints: [
      constrain(:center_y).equals(:from, :center_y),
      constrain_to_right(:from),
      constrain(:right).equals(:filepath_button, :left).minus(8),
      constrain(:width).at_most(350),
      constrain_height(22)
    ]

  style NSButton, width: 110, height: 24, bezelStyle: NSRoundedBezelStyle

  style :filepath_button,
    constraints: [
      constrain(:center_y).equals(:from, :center_y),
      constrain_right(-8),
      constrain_size(100,22)
    ],
    title: "Choose File"


end


Teacup::Stylesheet.new :main_window do
	style :dragarea,
      frame: [[10, 10], [160, 160]],
      image: NSImage.imageNamed('dragarea')

  style NSTextField, height: 22, width: 300

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