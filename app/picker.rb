class DragView < NSImageView
  attr_accessor :types, :notification

  def initWithFrame(frameRect)
    if super
    	registerForDraggedTypes [NSPDFPboardType, NSFilenamesPboardType]
      @types = [".mov", ".mkv", ".avi", ".mp4"]
      @notification = 'StoryboardFileSelected'
      self
    end
  end

  def mouseDown(event)
    openDialog(event)
  end

  def openDialog(event)
    dialog = NSOpenPanel.openPanel
    dialog.delegate = self
    dialog.canChooseFiles = true
    dialog.canChooseDirectories = false
    dialog.allowsMultipleSelection = false
   
    if dialog.runModalForDirectory(nil, file:nil) == NSOKButton
      App.notification_center.post(notification, self, dialog.filenames.first)
    end
  end

  def panel(panel, shouldShowFilename: filename)
    return (types.include? File.extname(filename)) || File.directory?(filename)
  end

	def draggingEntered(sender)
		pboard = sender.draggingPasteboard
 		files = []
    if (pboard.types.containsObject(NSFilenamesPboardType))
        files = pboard.propertyListForType(NSFilenamesPboardType);
    end

    if files.count == 1 && types.include?(File.extname(files.first))
    	self.image = NSImage.imageNamed('dragarea_ok')
      App.notification_center.post(notification, self, files.first)
 			return NSDragOperationCopy
    end

 		self.image = NSImage.imageNamed('dragarea_no')
 		return false
	end

	def draggingEnded(sender)
		self.image = NSImage.imageNamed('dragarea')
	end

	def draggingExited(sender)
		self.image = NSImage.imageNamed('dragarea')
	end
end