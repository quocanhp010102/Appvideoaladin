//
//  MusicCLVC.swift
//  halodemoAladin
//
//  Created by quocanhppp on 17/07/2024.
//

import UIKit
import Kingfisher
class MusicCLVC: UICollectionViewCell {

    @IBOutlet weak var nameMusic: UILabel!
    @IBOutlet weak var ImageMusic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindData(text: String,image:String) {
        nameMusic.text = text
        
        let url = URL(string: image)
        let processor = DownsamplingImageProcessor(size: ImageMusic.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        ImageMusic.kf.indicatorType = .activity
        ImageMusic.kf.setImage(
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
