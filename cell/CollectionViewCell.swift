//
//  CollectionViewCell.swift
//  halodemoAladin
//
//  Created by quocanhppp on 11/07/2024.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playertimeLable: UILabel!
    @IBOutlet weak var avatarClip: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func bindData(text: String,image:String) {
        playertimeLable.text = text
        
        let url = URL(string: image)
        let processor = DownsamplingImageProcessor(size: avatarClip.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        avatarClip.kf.indicatorType = .activity
        avatarClip.kf.setImage(
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
