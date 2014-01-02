class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildMenu

    @controller = PlayerController.new
    @mainWindow = @controller.window

    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.orderFrontRegardless
  end

  def openFile
    dialog = NSOpenPanel.openPanel
    dialog.delegate = self
    dialog.canChooseFiles = true
    dialog.canChooseDirectories = false
    dialog.allowsMultipleSelection = false
   
    if dialog.runModalForDirectory(nil, file:nil) == NSOKButton
       @controller.playVideo(dialog.filenames.first)
    end
  end

  def panel(panel, shouldShowFilename: filename)
    return [".mkv", ".avi", ".mp4"].include? File.extname(filename)
  end
end