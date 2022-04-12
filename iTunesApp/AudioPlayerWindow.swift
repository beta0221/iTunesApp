//
//  AudioPlayerWindow.swift
//  iTunesApp
//
//  Created by 林奕儒 on 2022/4/11.
//

import UIKit

class AudioPlayerWindow: UIWindow {

    weak var audioPlayerVC:AudioPlayerVC!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
