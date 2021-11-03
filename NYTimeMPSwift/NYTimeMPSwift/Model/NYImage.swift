//
//  NYImage.swift
//  NYTimeMPSwift
//
//  Created by Atif on 03/11/2021.
//  Copyright © 2021 Atif. All rights reserved.
//

import UIKit

struct NYImage: DataArray {
    let url: String
    let format: String
    let height: Int
    let width: Int
    init(url:String,format:String,height:Int,width:Int) {
        self.url = url
        self.format = format
        self.height = height
        self.width = width
    }
    init?(json: JsonDictionay) {
        let url = json["url"] as? String ?? ""
        let format = json["format"] as? String ?? ""
        let height = json["height"] as? Int ?? 0
        let width = json["width"] as? Int ?? 0
        
        self.init(url:url,format:format,height:height,width:width)
    }
}
