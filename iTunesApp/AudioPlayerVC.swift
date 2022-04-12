//
//  AudioPlayerVC.swift
//  iTunesApp
//
//  Created by 林奕儒 on 2022/4/11.
//

import UIKit
import AVFoundation

enum PlayStatus{
    case play
    case pause
    case stop
}

class AudioPlayerVC: UIViewController {
    
    var audioPlayer:AVPlayer?
    var audioPlayerLayer:AVPlayerLayer?
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var playingTrackLabel: UILabel!
    
    var previewUrlString:String = ""
    
    var playStatus:PlayStatus = .stop{
        didSet{
            switch playStatus {
                case .play:
                    playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                    break
                case .pause,.stop:
                    playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,selector: #selector(play),name: NSNotification.Name("PlayAudio"),object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: audioPlayer?.currentItem)
    }
    
    @IBAction func playPauseAction(_ sender: Any) {
        
        
        switch playStatus {
            case .play:
                audioPlayer?.pause()
                playStatus = .pause
            case .pause:
                audioPlayer?.play()
                playStatus = .play
                break
            default:
                break
        }
    }
    
    @objc private func play(notification: Notification){
        
        print("play !!!")
        guard let previewUrl = notification.userInfo?["previewUrl"] as? URL,
              let trackName = notification.userInfo?["trackName"] as? String else { return }
        
        if(previewUrlString == previewUrl.absoluteString){
            audioPlayer?.play()
            playStatus = .play
            return
        }
        
        
        stopAction("")
        playingTrackLabel.text = trackName
        previewUrlString = previewUrl.absoluteString
        audioPlayer = AVPlayer(url: previewUrl)
        let audioPlayerLayer = AVPlayerLayer(player: audioPlayer)
        self.view.layer.addSublayer(audioPlayerLayer)
        self.audioPlayerLayer = audioPlayerLayer
        audioPlayer?.play()
        playStatus = .play
        
    }
    
    @objc func finishedPlaying( _ myNotification:NSNotification) {
        print("finished Playing")
        playStatus = .pause
        audioPlayer?.seek(to: .zero)
    }
    
    @IBAction func stopAction(_ sender: Any) {
        playingTrackLabel.text = "-"
        audioPlayer?.pause()
        audioPlayerLayer?.removeFromSuperlayer()
        audioPlayer = nil
        playStatus = .stop
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
