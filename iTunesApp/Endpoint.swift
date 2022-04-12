//
//  Endpoint.swift
//  iTunesApp
//
//  Created by 林奕儒 on 2022/4/11.
//

import Foundation

protocol  Endpoint {
    
    /**https*/
    var scheme: String { get }
    
    /*api.facebook.**/
    var baseUrl: String { get }
    
    /*"/product/apple"**/
    var path: String { get }
    
    /**apikey=abc*/
    var parameters:[URLQueryItem] { get }
    
    /**GET*/
    var method: String { get }
}
