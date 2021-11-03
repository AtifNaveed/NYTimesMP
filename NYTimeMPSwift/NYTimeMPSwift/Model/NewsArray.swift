//
//  NewsArray.swift
//  NYTimeMPSwift
//
//  Created by Atif on 03/11/2021.
//  Copyright © 2021 Atif. All rights reserved.
//

import Foundation

typealias JsonDictionay = [String : Any]
struct NewsArray {
    let status    : String
    let copyright  : String
    let total_results  : Int
    var results        : [NYModel]
    init(status:String, copyright: String, total_results:Int, results:[NYModel]){
        self.status    = status
        self.copyright  = copyright
        self.total_results  = total_results
        self.results        = results
    }
    init?(json: JsonDictionay) {
        guard let status      = json["status"] as? String else { return nil }
        guard let copyright     = json["copyright"] as? String else { return nil }
        guard let total_results   = json["num_results"] as? Int else { return nil }
        guard let results         = NYModel.createRequiredInstances(from: json , key: "results") else { return nil }
        self.init(status:status,copyright:copyright,total_results:total_results,results:results)
    }
}
