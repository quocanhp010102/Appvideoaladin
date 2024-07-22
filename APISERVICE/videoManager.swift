//
//  videoManager.swift
//  halodemoAladin
//
//  Created by quocanhppp on 11/07/2024.
//

import UIKit

struct VideoManager {
    
    //let listVideoUrl = "http://apigw.haloplay.co.tz/api/v1/new-songs?page=\()&type=video"
    typealias ApiCompletion = (_ data: Any?, _ error: Error?) -> ()
    private func convertToJson(_ byData: Data?) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: byData!, options: [])
        } catch {
            //            self.debug("convert to json error: \(error)")
        }
        return nil
    }
    func fetchVideo(listVideoUrl : String,page:Int, completion: @escaping ApiCompletion) {
        // Tạo URL
        
        if let url = URL(string: listVideoUrl + String(page) + "&type=video") {
            print(url)
            let session = URLSession(configuration: .default)
            
            // Tạo data task với closure trực tiếp thay vì gọi hàm handle
            let task = session.dataTask(with: url) { data, response, error in
                // Gọi handle để xử lý phản hồi
                DispatchQueue.main.async {
                    self.handle(data: data, response: response, error: error,completion: completion)
                }
            }
            task.resume()
        }
    }
    func fetchMusic(musicUrl: String,page:Int,completion: @escaping ApiCompletion){
        if let url = URL(string: musicUrl + String(page)) {
            print(url)
            let session = URLSession(configuration: .default)
            
            // Tạo data task với closure trực tiếp thay vì gọi hàm handle
            let task = session.dataTask(with: url) { data, response, error in
                // Gọi handle để xử lý phản hồi
                DispatchQueue.main.async {
                    self.handle(data: data, response: response, error: error,completion: completion)
                }
            }
            task.resume()
        }
    }
    func handle(data: Data?, response: URLResponse?, error: Error?,completion: @escaping ApiCompletion) {
        if let error = error {
            print(error)
            return
        }

        if let resJson = self.convertToJson(data) {
            completion(resJson, nil)
        }
        else if let resString = String(data: data!, encoding: .utf8) {
            completion(resString, error)
        }
        else {
            completion(nil, error)
        }

    }
}
