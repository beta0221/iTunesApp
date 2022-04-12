//
//  ITunesModels.swift
//  iTunesApp
//
//  Created by 林奕儒 on 2022/4/11.
//

import Foundation

struct ITunesResponse:Codable{
    let resultCount:Int?
    let results:[Track]
}

struct Track: Codable {
    var artistName: String?
    var collectionName: String?
    var trackName: String?
    var artworkUrl100: URL?
    var releaseDate: String?
    var collectionPrice: Double?
    var trackPrice: Double?
    var country: String?
    var currency: String?
    var previewUrl: URL?
}
