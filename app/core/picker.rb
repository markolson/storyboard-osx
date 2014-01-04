class Picker
  attr_reader :types
  def initialize(types, target=nil, action=nil)
    @types = types
  end

  def valid?(path)
    return types.include?(File.extname(path))
  end

  def openDialog(event)
    dialog = NSOpenPanel.openPanel
    dialog.delegate = self
    dialog.canChooseFiles = true
    dialog.canChooseDirectories = false
    dialog.allowsMultipleSelection = false
   
    if dialog.runModalForDirectory(nil, file:nil) == NSOKButton
      target.call(action, dialog.filenames.first)
    end
  end

  def panel(panel, shouldShowFilename: filename)
    return valid?(filename) || File.directory?(filename)
  end
end