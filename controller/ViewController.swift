//
//  ViewController.swift
//  halodemoAladin
//
//  Created by quocanhppp on 11/07/2024.
//

import UIKit
import ProgressHUD
import AVFoundation


    class ViewController: UIViewController {

        var videoManager = VideoManager()
        var listItem:[video] = [video]()
        
        @IBOutlet weak var chontrang: UIButton!
        @IBOutlet weak var clssviewlist: UICollectionView!
        override func viewDidLoad() {
         
            super.viewDidLoad()
            print(5)
            
           
            videoManager.fetchVideo(listVideoUrl: "http://apigw.haloplay.co.tz/api/v1/new-songs?page=", page: 1) { data, error in
                if let d = data as? [String : Any]{
                    
                    if let item = d["data"] as? [String : Any]{
                        if let contItem = item["contents"] as? [[String:Any]]{
                            
                            for item1 in contItem {
                                // print(item1)
                                var clip:video = video()
                                clip = clip.initLoad(item1)
                                self.listItem.append(clip)
                            }
                            
                        }
                        
                        
                    }else{
                        print("dSADADS")
                    }
                }
                
            self.clssviewlist.reloadData()
                print(self.listItem.count)
            }
            clssviewlist.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        }

        @IBAction func chonTrangaction(_ sender: Any) {
            let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)

                   // add the actions (buttons)
            for i in 1...100 {
                alert.addAction(UIAlertAction(title: String(i), style: UIAlertAction.Style.default, handler: {action in
                    ProgressHUD.progress("Loading...",1)
                    
                    self.listItem.removeAll()
                    self.videoManager.fetchVideo(listVideoUrl: "http://apigw.haloplay.co.tz/api/v1/new-songs?page=", page: i) { data, error in
                        if let d = data as? [String : Any]{
                            
                            if let item = d["data"] as? [String : Any]{
                                if let contItem = item["contents"] as? [[String:Any]]{
                                    
                                    for item1 in contItem {
                                        // print(item1)
                                        var clip:video = video()
                                        clip = clip.initLoad(item1)
                                        self.listItem.append(clip)
                                    }
                                    
                                }
                                
                                
                            }else{
                                print("dSADADS")
                            }
                        }
                        
                        ProgressHUD.remove()
                    self.clssviewlist.reloadData()
                       
                    }
                }))
            }

            
          
                   alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                  

                   // show the alert
                   self.present(alert, animated: true, completion: nil)
        }
        
    }

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.listItem.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "mhchinh", bundle: nil)
              let vc = detailVideoViewController()
              self.present(vc, animated: true, completion: nil)
       
   
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.bindData(text: self.listItem[indexPath.row].name ?? "",image: self.listItem[indexPath.row].cover_path ?? "")
       // cell.playertimeLable.text = self.listItem[indexPath.row].play_times
            return cell
           
        
     
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
    

        return UICollectionReusableView()
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: 200)
            }
            return CGSize(width: (UIScreen.main.bounds.width)/2 - 10, height: 200)
       
    }
}
