import UIKit
import TrailerPlayer

class detailVideoViewController: UIViewController {

    @IBOutlet weak var pre10s: UIButton!
    @IBOutlet weak var next10s: UIButton!
    @AutoLayout
    private var playerView: TrailerPlayerView = {
        let view = TrailerPlayerView()
        view.enablePictureInPicture = true
        return view
    }()
    
    @AutoLayout
    private var controlPanel: ControlPanel = {
        let view = ControlPanel()
        return view
    }()
    
    @AutoLayout
    private var replayPanel: ReplayPanel = {
        let view = ReplayPanel()
        return view
    }()
    
    private let autoPlay = false
    private let autoReplay = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(playerView)
        playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 0.65).isActive = true
        if #available(iOS 11.0, *) {
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            playerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        
        controlPanel.delegate = self
        playerView.addControlPanel(controlPanel)
        
        if !autoReplay {
            replayPanel.delegate = self
            playerView.addReplayPanel(replayPanel)
        }
        
        if !autoPlay {
            let button = UIButton()
            button.tintColor = .white
            button.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysTemplate), for: .normal)
            playerView.manualPlayButton = button
        }
        
        let item = TrailerPlayerItem(
            url: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/tiktokproject-b81c3.appspot.com/o/posts%2F3F87A597-8327-4416-BB3C-94FEA99E6900.mp4?alt=media&token=688cb81a-8b97-4cfc-b453-2e4dbcb6c5a8"),
            thumbnailUrl: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/tiktokproject-b81c3.appspot.com/o/post_images%2F793F3DBF-1A4F-46FF-BD23-88F7DA35570C?alt=media&token=a56502ef-af5f-4598-beef-51c86b582e8e"),
            autoPlay: autoPlay,
            autoReplay: autoReplay)
        playerView.playbackDelegate = self
        playerView.set(item: item)
        
        // Thêm hành động cho các nút tua
        pre10s.addTarget(self, action: #selector(didTapPre10s), for: .touchUpInside)
        next10s.addTarget(self, action: #selector(didTapNext10s), for: .touchUpInside)
    }
    
    @objc func didTapPre10s() {
        let currentTime = playerView.currentTime
        let newTime = max(currentTime - 3, 0)
        print(playerView.currentTime)
        playerView.seek(to: newTime)
    }
    
    @objc func didTapNext10s() {
        let currentTime = playerView.currentTime
        let newTime = min(currentTime + 3, playerView.duration)
        print(playerView.currentTime)
        playerView.seek(to: newTime)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let enableFullscreen = UIDevice.current.orientation.isLandscape
        controlPanel.fullscreenButton.isSelected = enableFullscreen
        playerView.fullscreen(enabled: enableFullscreen)
    }
}

extension detailVideoViewController: TrailerPlayerPlaybackDelegate {
    
    func trailerPlayer(_ player: TrailerPlayer, didUpdatePlaybackTime time: TimeInterval) {
        controlPanel.setProgress(withValue: time, duration: playerView.duration)
    }
    
    func trailerPlayer(_ player: TrailerPlayer, didChangePlaybackStatus status: TrailerPlayerPlaybackStatus) {
        controlPanel.setPlaybackStatus(status)
    }
}

extension detailVideoViewController: ControlPanelDelegate {
    
    func controlPanel(_ panel: ControlPanel, didTapMuteButton button: UIButton) {
        playerView.toggleMute()
        playerView.autoFadeOutControlPanelWithAnimation()
    }
    
    func controlPanel(_ panel: ControlPanel, didTapPlayPauseButton button: UIButton) {
        if playerView.status == .playing {
            playerView.pause()
        } else {
            playerView.play()
        }
        playerView.autoFadeOutControlPanelWithAnimation()
    }
    
    func controlPanel(_ panel: ControlPanel, didTapFullscreenButton button: UIButton) {
        playerView.fullscreen(enabled: button.isSelected,
                              rotateTo: button.isSelected ? .landscapeRight: .portrait)
        playerView.autoFadeOutControlPanelWithAnimation()
    }
    
    func controlPanel(_ panel: ControlPanel, didTouchDownProgressSlider slider: UISlider) {
        playerView.pause()
        playerView.cancelAutoFadeOutAnimation()
    }
    
    func controlPanel(_ panel: ControlPanel, didChangeProgressSliderValue slider: UISlider) {
        playerView.seek(to: TimeInterval(slider.value))
        playerView.play()
        playerView.autoFadeOutControlPanelWithAnimation()
    }
    
    func controlPanel(_ panel: ControlPanel, didTapRewindButton button: UIButton) {
        
        let currentTime = playerView.currentTime
        let newTime = max(currentTime - 3, 0)
        print(playerView.currentTime)
        playerView.seek(to: newTime)
    }
    
    func controlPanel(_ panel: ControlPanel, didTapFastForwardButton button: UIButton) {
        let currentTime = playerView.currentTime
        let newTime = min(currentTime + 3, playerView.duration)
        playerView.seek(to: newTime)
    }
}


extension detailVideoViewController: ReplayPanelDelegate {
    
    func replayPanel(_ panel: ReplayPanel, didTapReplayButton: UIButton) {
        playerView.replay()
    }
}
