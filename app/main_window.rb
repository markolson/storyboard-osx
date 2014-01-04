class StoryboardController < TeacupWindowController
  attr_accessor :dragarea, :filepath, :file_button, :subpath, :subpath_button

  attr_reader :filefound

  stylesheet :main_window

  def loadWindow

    @filefound = App.notification_center.observe 'StoryboardFileSelected' do |notification|
      pickVideo(notification.userInfo)
      findSubs(notification.userInfo)
    end

    self.window = NSWindow.alloc.initWithContentRect([[400, 400], [600, 180]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
  end

  def findSubs(path)
    subtitle_extension = %w(srt sub ssa ass).detect{ |ext| ext = ".#{ext}"; File.exist?(path.gsub(File.extname(path), ext)) }
    return unless subtitle_extension
    subtitle_path = path.gsub(File.extname(path), ".#{subtitle_extension}")
    @subpath.stringValue = subtitle_path
  end

  def pickVideo(path)
    @filepath.stringValue = path
  end

	layout do |view|
    subview(NSBox, :box) do |box|

    end
    
    @dragarea = subview(DragView, :dragarea)

    @filepath = subview(NSTextField, :filepath)
    @filepath.cell.lineBreakMode = NSLineBreakByTruncatingHead

    @file_button = subview(NSButton, :filepath_button)
    @file_button.target = @dragarea
    @file_button.action = 'openDialog:'
  end
end