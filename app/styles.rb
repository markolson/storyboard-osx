Teacup::Stylesheet.new :main_window do
  style :screen,
    autoresizingMask: autoresize.fill,
    constraints: [
      constrain(:top).equals(:superview, :top),
      constrain(:left).equals(:superview, :left),
      constrain(:bottom).equals(:superview, :bottom),
      constrain(:right).equals(:superview, :right),
    ]
end