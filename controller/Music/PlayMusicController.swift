//
//  PlayMusicController.swift
//  halodemoAladin
//
//  Created by quocanhppp on 18/07/2024.
//

import UIKit

import UIKit
import AVFAudio
import AVFoundation
import Kingfisher
class PlayMusicController: UIViewController {
   
    @IBOutlet weak var AvatarImage: UIImageView!
    @IBOutlet weak var SongLable: UILabel!
    @IBOutlet weak var SingLable: UILabel!
    @IBOutlet weak var nextSongBTN: UIButton!
    @IBOutlet weak var nextBTN: UIButton!
    @IBOutlet weak var preSongBTN: UIButton!
    @IBOutlet weak var preBTN: UIButton!
    @IBOutlet weak var pauseBTN: UIButton!
    @IBOutlet weak var PlayBTN: UIButton!
    @IBOutlet weak var TimeLable: UILabel!
    @IBOutlet weak var slideTime: UISlider!
    var time : Timer?
    var time2 : Timer?
    var audioPlayer :AVAudioPlayer?
    var nameMusic:String?
    var music:[String]?
    var avatar:[String]?
    var indexMusc:Int?
    var sing:String?
    var song:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        playMusic(nameMusicip: nameMusic!)
        setUpBTN()
        SongLable.text = song
        SingLable.text = sing
        setAvatar()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func setAvatar(){
        time2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(nextAuto), userInfo: nil, repeats: true)
        let url = URL(string: avatar![indexMusc!])
        let processor = DownsamplingImageProcessor(size: AvatarImage?.bounds.size ?? CGSize(width: 0, height: 0))
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        AvatarImage?.kf.indicatorType = .activity
        AvatarImage?.kf.setImage(
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
    func setupName(sings:String,songs:String){
        SongLable.text = songs
        SingLable.text = sings
    }
    func setUpBTN(){
        PlayBTN.setTitle("", for: .normal)
        pauseBTN.setTitle("", for: .normal)
        preBTN.setTitle("", for: .normal)
        preSongBTN.setTitle("", for: .normal)
        nextBTN.setTitle("", for: .normal)
        nextSongBTN.setTitle("", for: .normal)
        slideTime.value = 0
        if ((audioPlayer?.isPlaying) != nil) {
            PlayBTN.isHidden = false
            pauseBTN.isHidden = true
        }else{
            PlayBTN.isHidden = true
            pauseBTN.isHidden = false
        }
        
    }
    func formatTimeInterval(_ timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional // 00:00:00
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: timeInterval) ?? "00:00:00"
    }
    func playMusic(nameMusicip:String){
      
        guard let url = Bundle.main.url(forResource: nameMusicip, withExtension: "mp3") else {
            print("fdas")
            return }

          
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url , fileTypeHint: AVFileType.mp3.rawValue)
                if let duration = audioPlayer?.duration {
                    let formattedDuration = formatTimeInterval(duration)
                    TimeLable.text = formattedDuration
                } else {
                    print("Unable to retrieve audio duration")
                }
            } catch {
                print("Error initializing audio player: \(error.localizedDescription)")
            }
    }

    @IBAction func updateSlideSong(_ sender: Any) {
        guard let slider = sender as? UISlider,
              let player = self.audioPlayer else {
                return
            }
      
            player.currentTime = Double(slider.value / slider.maximumValue) * player.duration
     
       
        
    }
   
    @IBAction func playaction(_ sender: Any) {
        audioPlayer?.play()
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        PlayBTN.isHidden = true
        pauseBTN.isHidden = false
        
    }
    @objc func updateTime(){
        if let duration = audioPlayer?.duration {
            var currentTime = audioPlayer?.currentTime
            let formattedDuration = formatTimeInterval(duration - currentTime!)
            TimeLable.text = formattedDuration
            slideTime.maximumValue = Float(duration)
            slideTime.value = Float(Double(currentTime!))
        } else {
            print("Unable to retrieve audio duration")
        }
    }
    @objc func nextAuto(){
        if Int(self.slideTime.value) >= Int(self.slideTime.maximumValue - 1) && self.slideTime.maximumValue > 2 {
            print(Int(slideTime.maximumValue))
            print(slideTime.value)
            if indexMusc! == music!.count - 1 {
                indexMusc! = 0
            }else{
                indexMusc! += 1
               
            }
            self.slideTime.value = 0
            var tenbai:String = music![indexMusc!]
           
            playMusic(nameMusicip: tenbai)
            setupName(sings: "quoc anh", songs: tenbai)
            setAvatar()
            audioPlayer?.play()
            PlayBTN.isHidden = true
            pauseBTN.isHidden = false
        }else{
            return
        }
       
    }
    
    @IBAction func pauseAction(_ sender: Any) {
        audioPlayer?.pause()
        pauseBTN.isHidden = true
        PlayBTN.isHidden = false
    }
    @IBAction func pre10s(_ sender: Any) {
        self.audioPlayer?.currentTime -= 10
    }
    
    @IBAction func next10s(_ sender: Any) {
        if self.slideTime.value < self.slideTime.maximumValue - 10{
            self.audioPlayer?.currentTime += 10
        }else {
            self.slideTime.value = self.slideTime.maximumValue
        }
       
    }
    @IBAction func preSong(_ sender: Any) {
        
        if indexMusc! == 0 {
           
            indexMusc! = music!.count - 1
           
        }else{
            indexMusc! -= 1
        }
       
        var tenbai:String = music![indexMusc!]
       
        playMusic(nameMusicip: tenbai)
        setupName(sings: "quoc anh", songs: tenbai)
        setAvatar()
        audioPlayer?.play()
        
        
    }
    
    @IBAction func nextSong(_ sender: Any) {
        if indexMusc! == music!.count - 1 {
            indexMusc! = 0
        }else{
            indexMusc! += 1
           
        }
       
        var tenbai:String = music![indexMusc!]
       
        playMusic(nameMusicip: tenbai)
        setupName(sings: "quoc anh", songs: tenbai)
        setAvatar()
        audioPlayer?.play()
    }
}

