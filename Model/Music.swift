//
//  Music.swift
//  halodemoAladin
//
//  Created by quocanhppp on 17/07/2024.
//

import Foundation

struct Music : Codable {
    var id:Int?
    var name:String?
    var image_path:String?
    var listen_number:String?
    var duration:String?
   
    mutating func initLoad(_ json:[String:Any]) ->Music{
        if let temp = json["id"] as? Int {id = temp}
        if let temp = json["name"] as? String {name = temp}
        if let temp = json["image_path"] as? String {image_path = temp}
        if let temp = json["listen_number"] as? String {listen_number = temp}
        if let temp = json["duration"] as? String {duration = temp}
        
        return self
    }
}
