class AppDelegate
  attr_accessor :controller, :mainWindow
  def applicationDidFinishLaunching(notification)
    buildMenu

    @controller = StoryboardController.new
    @mainWindow = @controller.window

    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.orderFrontRegardless
  end

  def applicationShouldTerminateAfterLastWindowClosed(sender)
    true
  end
end