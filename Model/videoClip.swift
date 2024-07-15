//
//  videoClip.swift
//  halodemoAladin
//
//  Created by quocanhppp on 11/07/2024.
//

import UIKit


struct video : Codable {
    var id:Int?
    var name:String?
    var descriptio:String?
    var cover_path:String?
    var play_times:String?
    var duration:String?
    var in_library:Bool?
    var published_time:String?
    var wap_link:String?
    mutating func initLoad(_ json:[String:Any]) ->video{
        if let temp = json["id"] as? Int {id = temp}
        if let temp = json["name"] as? String {name = temp}
        if let temp = json["descriptio"] as? String {descriptio = temp}
        if let temp = json["cover_path"] as? String {cover_path = temp}
        
        if let temp = json["play_times"] as? String {play_times = temp}
        if let temp = json["duration"] as? String {duration = temp}
        if let temp = json["in_library"] as? Bool {in_library = temp}
        if let temp = json["published_time"] as? String {published_time = temp}
        if let temp = json["wap_link"] as? String {wap_link = temp}
        return self
    }
}
