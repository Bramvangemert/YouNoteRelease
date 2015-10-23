//
//  History.swift
//  YOUNote
//
//  Created by bj gemert on 21/10/15.
//  Copyright (c) 2015 Bram van Gemert. All rights reserved.
//

import UIKit

class History: UITableViewController{
    @IBOutlet var table: UITableView!
    var first: Bool = true;
   override func viewDidLoad() {
        super.viewDidLoad()
    
    table.dataSource = self
    table.delegate = self
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(first)
        {
            let defaults = NSUserDefaults.standardUserDefaults()
            let notes = defaults.objectForKey("notes") as? NSData
            if let notes = notes {
                let notesArray = NSKeyedUnarchiver.unarchiveObjectWithData(notes) as? [video]
                if let notesArray = notesArray {
                SharingManager.sharedInstance.NotesArray = notesArray
            }
            }
            first = false;
        }
        else
        {
            let defaults = NSUserDefaults.standardUserDefaults()
            let noteObject = NSKeyedArchiver.archivedDataWithRootObject(SharingManager.sharedInstance.NotesArray)
            defaults.setObject(noteObject, forKey: "notes")
            defaults.synchronize()
        }
       let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        if(SharingManager.sharedInstance.NotesArray.count >  indexPath.row)
        {
            label.text = SharingManager.sharedInstance.NotesArray[indexPath.row].timeStamp+"-"+SharingManager.sharedInstance.NotesArray[indexPath.row].title
        }
        else
        {
            label.text = ""
        }
        cell.addSubview(label)
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row < SharingManager.sharedInstance.NotesArray.count)
        {
            SharingManager.sharedInstance.text = SharingManager.sharedInstance.NotesArray[indexPath.row].text
            SharingManager.sharedInstance.videoUrl = SharingManager.sharedInstance.NotesArray[indexPath.row].videoUrl
            self.performSegueWithIdentifier("Note", sender: self)
        }
    }
    func tableView(tableView: UITableView, heightForRawAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
}