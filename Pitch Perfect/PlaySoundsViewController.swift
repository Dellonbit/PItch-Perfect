//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by arianne on 2015-06-19.
//  Copyright (c) 2015 della. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    //declare audio variables
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioPlayer2: AVAudioPlayer!
    
    
    //Declared globally within PlaySoundsViewController
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var error: NSError?
        audioPlayer  = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: &error)
        audioPlayer.enableRate = true
        
        audioPlayer2  = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: &error)
        audioPlayer2.enableRate = true

        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func PlaySlowAudio(sender: AnyObject) {
        // call slow player effect
        fastOrSlow(0.5)
        
    }
    
    @IBAction func PlayFastAudio(sender: AnyObject) {
        // call fast player effect
        fastOrSlow(1.5)
        
    }
    
    func fastOrSlow (speed:Float ) {
        //stop all audio before playing effect
        audioPlayer2.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playChipMunkAudio(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
        
    }
    
    @IBAction func playDarthVarderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
        
    }
    //
    func playAudioWithVariablePitch(pitch: Float){
        //stop all audio before playing effect
        audioPlayer.stop()
        audioPlayer2.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playEchoSound(sender: AnyObject) {
        //stop all audio before playing effect
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer2.stop()
        audioPlayer.stop()
        audioPlayer.currentTime = 0;
        audioPlayer.play()
        
        let delay:NSTimeInterval = 0.1//100ms
        var playtime:NSTimeInterval
        playtime = audioPlayer2.deviceCurrentTime + delay
        audioPlayer2.stop()
        audioPlayer2.currentTime = 0
        audioPlayer2.volume = 0.8;
        audioPlayer2.playAtTime(playtime)
        
    }
    
    
    @IBAction func stopAllAudio(sender: AnyObject) {
        //stop all audio 
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer2.stop()
    }
    

}
