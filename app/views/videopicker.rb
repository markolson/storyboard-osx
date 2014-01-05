class VideoPicker < NSViewController

  stylesheet :pick_video_mode
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
    end
  end
end