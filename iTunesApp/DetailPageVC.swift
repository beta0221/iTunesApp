//
//  DetailPageVC.swift
//  iTunesApp
//
//  Created by 林奕儒 on 2022/4/11.
//

import UIKit
import AVFoundation

class DetailPageVC: UIViewController{
    
    
    var track:Track?
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = track?.artworkUrl100{
            previewImageView.loadImage(url: url)
        }
        artistLabel.text = track?.artistName
        trackNameLabel.text = track?.trackName
        collectionLabel.text = track?.collectionName
        
    }
    
    
    @IBAction func playAction(_ sender: Any) {
        
        if let previewUrl = track?.previewUrl,let trackName = track?.trackName{
            NotificationCenter.default.post(name:NSNotification.Name("PlayAudio"), object: nil,userInfo: ["previewUrl":previewUrl,"trackName":trackName])
        }
        
    }
    
    
}
