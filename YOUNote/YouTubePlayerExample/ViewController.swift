//
//  ViewController.swift
//  YOUNote
//
//  Created by Bram van Gemert on 1/10/2015.
//  Copyright (c) 2015 Bram van Gemert. All rights reserved.
//

import UIKit
import YouTubePlayer

class ViewController: UIViewController {
    var first   : Bool=true;
    var started : Bool=false;
    @IBOutlet weak var VideoUrl: UITextField!
    @IBOutlet weak var PlayListUrl: UITextField!
    @IBOutlet weak var Notes: UITextView!
    
    @IBAction func clearData(sender: AnyObject) {
        let deleteAlert = UIAlertController(title: "Delete all data", message: "All data will be lost. Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
        
        deleteAlert.addAction(UIAlertAction(title: "Yes", style:.Default){ _ in
            print("data deleted")
            SharingManager.sharedInstance.NotesArray.removeAll()
            let defaults = NSUserDefaults.standardUserDefaults()
            let noteObject = NSKeyedArchiver.archivedDataWithRootObject(SharingManager.sharedInstance.NotesArray)
            defaults.setObject(noteObject, forKey: "notes")
            defaults.synchronize()

            })
        deleteAlert.addAction(UIAlertAction(title: "No", style:.Default){ _ in
            print("Data unchanged")
            })
        self.presentViewController(deleteAlert, animated:true, completion:nil)
    }
    
    @IBOutlet weak var playerView: YouTubePlayerView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var Url: UITextField!
    @IBAction func startTakingNotes(sender: AnyObject) {
        
        SharingManager.sharedInstance.videoUrl = Url.text!
        print(SharingManager.sharedInstance.videoUrl)
    }
    @IBAction func saveClose(sender: AnyObject) {
     self.dismissViewControllerAnimated(true,completion:{})
    
    }
    @IBAction func settings_back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true,completion:{})
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(playerView != nil)
        {
        playerView.playerVars = [
            "playsinline": "1",
            "controls": "1",
            "showinfo": "0"
        ]
        playerView.loadVideoURL(NSURL(fileURLWithPath: SharingManager.sharedInstance.videoUrl))
        Notes.text = SharingManager.sharedInstance.text
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func AddNote(sender: AnyObject) {
        
        let time = String(round((playerView.getPlayTime() as NSString).doubleValue).description.characters.dropLast().dropLast())
        if(first){
            SharingManager.sharedInstance.NotesArray.append(video())
            
            Notes.text!+=time+" ";
            first = false
        }
        else
        {
        Notes.text!+="\n"+time+" ";
        }
        save()
            playerView.pause()
        playButton.setTitle("Play", forState: .Normal)

    }
    @IBAction func PlayButton(sender: AnyObject) {
      save()
       if playerView.ready {
            if playerView.playerState != YouTubePlayerState.Playing {
                playerView.play()
                playButton.setTitle("Pause", forState: .Normal)
            } else {
                playerView.pause()
                playButton.setTitle("Play ", forState: .Normal)
            }
        }
    }
    func save()
    {
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        SharingManager.sharedInstance.NotesArray[
            SharingManager.sharedInstance.NotesArray.count-1].text = Notes.text
        SharingManager.sharedInstance.NotesArray[
            SharingManager.sharedInstance.NotesArray.count-1].videoUrl = SharingManager.sharedInstance.videoUrl
        SharingManager.sharedInstance.NotesArray[SharingManager.sharedInstance.NotesArray.count-1].timeStamp = timestamp
        SharingManager.sharedInstance.NotesArray[SharingManager.sharedInstance.NotesArray.count-1].title = playerView.getTitle()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
}

