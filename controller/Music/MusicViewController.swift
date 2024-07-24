//
//  MusicViewController.swift
//  halodemoAladin
//
//  Created by quocanhppp on 17/07/2024.
//

import UIKit
import Kingfisher

class MusicViewController: UIViewController {

    var videoManager = VideoManager()
    var listItem:[Music] = [Music]()
    @IBOutlet weak var MusicCLV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        videoManager.fetchMusic(musicUrl: "http://apigw.haloplay.co.tz/api/v1/playlists?page=", page: 1) { data, error in
            if let d = data as? [String : Any]{
                
                if let item = d["data"] as? [String : Any]{
                    if let contItem = item["contents"] as? [[String:Any]]{
                        
                        for item1 in contItem {
                            // print(item1)
                            var clip:Music = Music()
                            clip = clip.initLoad(item1)
                            self.listItem.append(clip)
                        }
                        
                    }
                    
                    
                }else{
                    print("dSADADS")
                }
            }
            
        self.MusicCLV.reloadData()
            print(self.listItem.count)
        }
        MusicCLV.register(UINib(nibName: "MusicCLVC", bundle: nil), forCellWithReuseIdentifier: "MusicCLVC")
    }
    

    

}
extension MusicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.listItem.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "mhchinh", bundle: nil)
              let vc = DetailMusicViewController()
//        vc.bindData(tittle: self.listItem[indexPath.row].name ?? "", image: self.listItem[indexPath.row].image_path ?? "")
        vc.modalPresentationStyle = .fullScreen
        vc.tittle = self.listItem[indexPath.row].name ?? ""
        vc.image = self.listItem[indexPath.row].image_path ?? ""
              self.present(vc, animated: true, completion: nil)
       
        
   
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCLVC", for: indexPath) as! MusicCLVC
        cell.bindData(text: self.listItem[indexPath.row].name ?? "",image: self.listItem[indexPath.row].image_path ?? "")
       // cell.nameMusic.text = self.listItem[indexPath.row].name
            return cell
           
        
     
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
    

        return UICollectionReusableView()
    }
    
}

extension MusicViewController: UICollectionViewDelegateFlowLayout {
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
            return CGSize(width: (UIScreen.main.bounds.width)/2 - 30, height: 200)
       
    }
}

