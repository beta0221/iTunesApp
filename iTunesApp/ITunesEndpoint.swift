//
//  ITunesEndpoint.swift
//  iTunesApp
//
//  Created by 林奕儒 on 2022/4/11.
//

import Foundation


enum ITunesEndpoint:Endpoint{
    
    case search(term:String,page:Int)
    
    var scheme: String {
        switch self{
            default:
                return "https"
        }
    }
    
    var baseUrl: String{
        switch self{
            default:
                return "itunes.apple.com"
        }
        
    }
    
    
    
    var path: String{
        switch self{
        case .search:
            return "/search"
        }
    }
    
    var parameters: [URLQueryItem]{
        
        
        
        switch self{
        case .search(let term,let page):
            var offset:Int = 0
            let limit:Int = 10
            offset = limit * page - limit
            return [
                URLQueryItem(name: "term", value: term),
                URLQueryItem(name: "offset", value: offset.description),
                URLQueryItem(name: "limit", value: limit.description)
            ]
        }
    }
    
    var method: String{
        switch self{
        case .search:
            return "GET"
        }
    }
    
    
}
