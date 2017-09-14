//
//  Document.swift
//  VocalTextEdit
//
//  Created by Gertjan on 06/09/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import Cocoa

class Document: NSDocument
{
	
	var contents : String = "";
	
	enum Error : Swift.Error, LocalizedError
	{
		case UTF8Encoding
		var failureReason : String?
		{
			switch self
			{
				case .UTF8Encoding: return "File cannot be encoded in UTF-8";
			}
		}
	}
	
	
	override class func autosavesInPlace() -> Bool {
		return true
	}

	override func makeWindowControllers() {
		// Returns the Storyboard that contains your Document window.
		let storyboard = NSStoryboard(name: "Main", bundle: nil)
		let windowController = storyboard.instantiateController(withIdentifier: "Document Window Controller") as! NSWindowController
		
		(windowController.contentViewController as! ViewController).contents = contents;
		
		self.addWindowController(windowController)
	}

	override func data(ofType typeName: String) throws -> Data
	{
		let contents = getController().contents ?? "";
		guard let data = contents.data(using: .utf8) else { throw Document.Error.UTF8Encoding }
		return data;
	}
	
	func getController() -> ViewController
	{
		let wController = windowControllers.first!;
		let vController = wController.contentViewController as! ViewController;
		return vController;
	}

	override func read(from data: Data, ofType typeName: String) throws {
		// Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
		// You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
		// If you override either of these, you should also override -isEntireFileLoaded to return false if the contents are lazily loaded.
		//throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
		
		guard let contents = String(data: data, encoding: .utf8) else { throw Document.Error.UTF8Encoding; }
		self.contents = contents;
		
	}


}

