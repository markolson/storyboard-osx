class PlayerController < TeacupWindowController
  stylesheet :main_window

  layout do
    @screen = subview(NSView, :screen)
  end

  def playVideo(path)
  	rect = NSMakeRect(0, 0, 0, 0);
  	rect.size = @screen.frame.size;

  	@videoView = VLCVideoView.alloc.initWithFrame(rect)
  	@screen.addSubview(@videoView);
  	@videoView.autoresizingMask = NSViewHeightSizable|NSViewWidthSizable;
  	@videoView.fillScreen = true
  	VLCLibrary.sharedLibrary

  	@s = VLCMediaPlayer.alloc.initWithVideoView(@videoView)
  	@s.delegate = self
    @s.media = VLCMedia.mediaWithPath(path)
  	@s.play
  end
end