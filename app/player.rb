class PlayerController < TeacupWindowController
	attr_accessor :progress, :videoView

	stylesheet :main_window


	layout do |view|
		@screen = subview(NSView, :screen)

    status = subview(NSTextField, :duration)
    status.selectable = false
    status.editable = false
    status.bezeled = false
    status.drawsBackground = false

    @progress = subview(NSProgressIndicator, :scrobber)
    @progress.indeterminate = false
    @progress.displayedWhenStopped = false
    @progress.controlTint = NSGraphiteControlTint
    @progress.style = NSProgressIndicatorBarStyle
    @progress.maxValue = 1.0
  	@progress.doubleValue = 0.0
    @progress.startAnimation(self)

    p @progress
  end

  def viewDidAppear(animated)
    p "LOADED"
    exit
  end

 def playVideo(path)
  	rect = NSMakeRect(0, 0, 0, 0);
  	rect.size = @screen.frame.size;

  	@videoView = VLCVideoView.alloc.initWithFrame(rect)
  	@screen.addSubview(@videoView);
  	@videoView.autoresizingMask = NSViewHeightSizable|NSViewWidthSizable;
  	#@videoView.fillScreen = true
  	VLCLibrary.sharedLibrary

  	@s = VLCMediaPlayer.alloc.initWithVideoView(@videoView)
  	@s.delegate = self
    @s.media = VLCMedia.mediaWithPath(path)
  	@s.play
  end

  def mediaPlayerTimeChanged(notification)
  	@progress.doubleValue = notification.object.position.to_f
  end
end