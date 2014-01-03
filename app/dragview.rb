class DragView < NSImageView
  def initWithFrame(frameRect)
    if super
    	registerForDraggedTypes [NSPDFPboardType, NSFilenamesPboardType]
      self
    end
  end

  def mouseDown(event)
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
    return ([".mov", ".mkv", ".avi", ".mp4"].include? File.extname(filename)) || File.directory?(filename)
  end

	def draggingEntered(sender)
		pboard = sender.draggingPasteboard
 		files = []
    if (pboard.types.containsObject(NSFilenamesPboardType))
        files = pboard.propertyListForType(NSFilenamesPboardType);
    end

    if files.count == 1 && [".avi", ".mkv", ".mov", ".mp4"].include?(File.extname(files.first))
    	self.image = NSImage.imageNamed('dragarea_ok')
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