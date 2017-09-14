//
//  ViewController.swift
//  VocalTextEdit
//
//  Created by Gertjan on 06/09/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSSpeechSynthesizerDelegate
{
	let speechSynth = NSSpeechSynthesizer();
	@IBOutlet var textView : NSTextView!; //Why is there an exlamation mark here?
	@IBOutlet var btnSpeak : NSButton!;
	@IBOutlet var btnStop: NSButton!;
	
	@IBAction func byebye(_ sender: Any)
	{
		
	}
	
	var contents : String?
	{
		get { return textView.string; }
		set { textView.string = newValue; }
	}
	
	@IBAction func speakButtonClicked(_ sender: NSButton)
	{
		var speakText: String = textView.string ?? "No text input...";
		print("The speak button was clicked, trying to speak: \(speakText)");
		
		speechSynth.delegate = self;
		speechSynth.startSpeaking(speakText);
		
		toggleButtons(isSpeaking: true);
	}
	
	func speechSynthesizer(_ sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool)
	{
		print("Synth finished? \(finishedSpeaking)");
		toggleButtons(isSpeaking: !finishedSpeaking); //This is only called when speaking
	}
	
	func toggleButtons(isSpeaking: Bool)
	{
		btnSpeak.isEnabled = !isSpeaking;
		btnStop.isEnabled = isSpeaking;
	}
	
	@IBAction func stopButtonClicked(_ sender: NSButton)
	{
		print("The stop button was clicked");
		speechSynth.stopSpeaking();
		toggleButtons(isSpeaking: false);
	}
	

}

