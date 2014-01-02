class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildMenu
  end

  def openFile
    dialog = NSOpenPanel.openPanel
    dialog.delegate = self
    dialog.canChooseFiles = true
    dialog.canChooseDirectories = false
    dialog.allowsMultipleSelection = false
   
    if dialog.runModalForDirectory(nil, file:nil) == NSOKButton
       p dialog.filenames.first
    end
  end

  def panel(panel, shouldShowFilename: filename)
    return [".mkv", ".avi", ".mp4"].include? File.extname(filename)
  end
end