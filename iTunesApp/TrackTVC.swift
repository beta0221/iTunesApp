//
//  TrackTVC.swift
//  iTunesApp
//
//  Created by 林奕儒 on 2022/4/11.
//

import UIKit

class TrackTVC: UITableViewCell{
    
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackLabel: UILabel!
    
    func setTVC(track:Track){
        artistLabel.text = track.artistName
        trackLabel.text = track.trackName
        if let url = track.artworkUrl100{
            trackImageView.loadImage(url: url)
        }
        
        
    }
    
    
}
