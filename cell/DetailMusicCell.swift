//
//  DetailMusicCell.swift
//  halodemoAladin
//
//  Created by quocanhppp on 18/07/2024.
//

import UIKit
import Kingfisher

class DetailMusicCell: UICollectionViewCell {

    @IBOutlet weak var Viewww: UIView!
    @IBOutlet weak var nghisi: UILabel!
    @IBOutlet weak var nameMusic: UILabel!
    @IBOutlet weak var imageDetailMS: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        Viewww.layer.cornerRadius = 30
        Viewww.layer.masksToBounds = true
        imageDetailMS.layer.cornerRadius = 30
        imageDetailMS.layer.masksToBounds = true
    }
    //https://firebasestorage.googleapis.com:443/v0/b/tiktokproject-b81c3.appspot.com/o/profile%2FffvgYz0Cxsfc2UMrcWagjvbWoKd2?alt=media&token=ed9c9083-05ed-4389-a0fe-6bfa8c17aae2
    func bindData(nghesi: String,image:String,name:String) {
        nghisi.text = nghesi
        nameMusic.text = name
        let url = URL(string: image)
        let processor = DownsamplingImageProcessor(size: imageDetailMS.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        imageDetailMS.kf.indicatorType = .activity
        imageDetailMS.kf.setImage(
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
    }
}
