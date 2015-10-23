//
//  video.swift
//  YOUNote
//
//  Created by bj gemert on 21/10/15.
//  Copyright (c) 2015 Bram van Gemert. All rights reserved.
//
import UIKit
class video: NSObject, NSCoding{
    var videoUrl:String!// = "default URL"
    var text:String!// = ""
    var title:String!// = ""
    var timeStamp:String!// = ""
    required convenience init(coder decoder: NSCoder){
        self.init()
        self.videoUrl = decoder.decodeObjectForKey("videoUrl") as! String
        self.text = decoder.decodeObjectForKey("text") as! String
        self.title = decoder.decodeObjectForKey("title") as! String
        self.timeStamp = decoder.decodeObjectForKey("timeStamp") as! String
    }
    convenience init(videoUrl: String)
    {
        self.init()
    }
    func encodeWithCoder(aCoder: NSCoder) {
        if let videoUrl = videoUrl { aCoder.encodeObject(videoUrl, forKey: "videoUrl")}
        if let text = text { aCoder.encodeObject(text, forKey: "text")}
        if let title = title { aCoder.encodeObject(title, forKey: "title")}
        if let timeStamp = timeStamp { aCoder.encodeObject(timeStamp, forKey: "timeStamp")}
        
    }
}