//
//  NetworkEngine.swift
//  iTunesApp
//
//  Created by 林奕儒 on 2022/4/11.
//

import Foundation

class NetworkEngine{
    
    
    class func request<T:Codable>(endpoint:Endpoint,completion:@escaping(Result<T,Error>)->Void){
        
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseUrl
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        
        guard let url = components.url else { return }
        print(url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        URLSession.shared.dataTask(with: urlRequest){ data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            
            guard response != nil,let data = data else { return }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            DispatchQueue.main.async {
                if let responseObject = try? decoder.decode(T.self, from: data){
                    
                    completion(.success(responseObject))
                }else{
                    
                    completion(.failure(NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey:"decode error"])))
                }
            }
        }.resume()
        
    }
    
}
