//
//  DetailMusicViewController.swift
//  halodemoAladin
//
//  Created by quocanhppp on 18/07/2024.
//

import UIKit
import AVFAudio
import Kingfisher
class DetailMusicViewController: UIViewController {

    @IBOutlet weak var titleAlbum: UILabel!
    @IBOutlet weak var imageALbum: UIImageView!
    @IBOutlet weak var MusicListCLV: UICollectionView!
    var tittle: String?
    var image:String?
    var music:[String] = ["music","music3","music4","music5","music6","music7","music8","music9","music10","music11"]
    var avatarMusic:[String] = ["https://firebasestorage.googleapis.com:443/v0/b/tiktokproject-b81c3.appspot.com/o/profile%2F7adEGPPmOZSCDWMKuVZi9S4LQKb2?alt=media&token=236a4f6e-a412-491f-80ab-3aeb24e90298","https://firebasestorage.googleapis.com:443/v0/b/tiktokproject-b81c3.appspot.com/o/post_images%2FCC46A5D8-196D-4665-973C-5402DBFFC7F7?alt=media&token=b0bc7941-6733-436e-b62f-561a2cafe029","https://firebasestorage.googleapis.com:443/v0/b/tiktokproject-b81c3.appspot.com/o/post_images%2F8F9308E7-683E-47EA-B83F-B5F711931735?alt=media&token=67b5d08c-110d-4fd4-8169-4aaa895f67b5","https://firebasestorage.googleapis.com:443/v0/b/tiktokproject-b81c3.appspot.com/o/post_images%2F9845FB12-4037-463B-B690-835ABCED1D67?alt=media&token=42a13dc2-2061-4ab6-98c8-4f95402cbe54","https://firebasestorage.googleapis.com:443/v0/b/tiktokproject-b81c3.appspot.com/o/post_images%2FB6DBF6A6-A874-43B1-BBCD-2F6E8BED1069?alt=media&token=72e1c7f3-d755-4d57-a02b-2878f19dbd39","https://firebasestorage.googleapis.com:443/v0/b/tiktokproject-b81c3.appspot.com/o/post_images%2FC1A52D2A-E6F5-4D37-95FE-CD2952A0BF2A?alt=media&token=e4e89967-84fc-4df9-ab68-395154087400","https://firebasestorage.googleapis.com:443/v0/b/tiktokproject-b81c3.appspot.com/o/post_images%2FC29C1EDB-E0C6-401C-BC23-F63C8320FA51?alt=media&token=2d00ebf5-65fb-4756-a3a3-bbe3901ff283","https://firebasestorage.googleapis.com:443/v0/b/tiktokproject-b81c3.appspot.com/o/post_images%2FD8F5E7D1-670C-4E13-9232-FD98DA6D432E?alt=media&token=9afdcf18-ea34-49b6-aca8-8f41baf2a6df","https://firebasestorage.googleapis.com:443/v0/b/tiktokproject-b81c3.appspot.com/o/post_images%2F785806D1-BCD0-404F-A36B-4498354655DA?alt=media&token=33f90bf7-294b-40e5-af9f-63c74824ae5c","https://firebasestorage.googleapis.com:443/v0/b/tiktokproject-b81c3.appspot.com/o/post_images%2F8EAD5B3C-BE4C-4F02-99B8-E23F2BC3F7D8?alt=media&token=27f61440-3362-42ab-8a27-d4907dd0e9fc"]
    override func viewDidLoad() {
        super.viewDidLoad()

        titleAlbum?.text = self.tittle!
       
        let url = URL(string: self.image!)
        let processor = DownsamplingImageProcessor(size: imageALbum?.bounds.size ?? CGSize(width: 0, height: 0))
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        imageALbum?.kf.indicatorType = .activity
        imageALbum?.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        MusicListCLV.register(UINib(nibName: "DetailMusicCell", bundle: nil), forCellWithReuseIdentifier: "DetailMusicCell")
    }
   
    
    func bindData(tittle: String,image:String) {
        self.tittle! = tittle
        self.image! = image
    }

    
    @IBAction func backBTN(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
extension DetailMusicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.music.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "mhchinh", bundle: nil)
              let vc = PlayMusicController()
                vc.nameMusic = self.music[indexPath.row]
                vc.music = self.music
                vc.avatar = self.avatarMusic
                vc.indexMusc = indexPath.row
                vc.sing = "quoc anh"
                vc.song = self.music[indexPath.row]
        
              self.present(vc, animated: true, completion: nil)
       
   
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let image = self.avatarMusic[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailMusicCell", for: indexPath) as! DetailMusicCell
        cell.bindData(nghesi: "quocanh", image: image, name: self.music[indexPath.row])
       // cell.nameMusic.text = self.listItem[indexPath.row].name
            return cell
           
        
     
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
    

        return UICollectionReusableView()
    }
    
}

extension DetailMusicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: 200)
            }
            return CGSize(width: (UIScreen.main.bounds.width)-100, height: 70)
       
    }
}
