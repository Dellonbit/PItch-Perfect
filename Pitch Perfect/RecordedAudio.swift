//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by arianne on 2015-06-19.
//  Copyright (c) 2015 della. All rights reserved.
//

import Foundation
class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl:NSURL, title:String) {
        //initial instance variables
        self.filePathUrl = filePathUrl
        self.title = title
    }
}