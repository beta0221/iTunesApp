//
//  UIImageViewExtension.swift
//  iTunesApp
//
//  Created by 林奕儒 on 2022/4/11.
//

import UIKit


let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    
    func loadImage(url:URL){
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        let urlRequest = URLRequest(url: url as URL)
        URLSession.shared.dataTask(with: urlRequest){(data,response,error) in
            if error != nil || data == nil{
                print(error!)
                return
            }
            
            let _imageToCache = UIImage(data: data!)
            
            guard let imageToCache = _imageToCache else { return }
            imageCache.setObject(imageToCache, forKey: url as AnyObject)
            DispatchQueue.main.async {
                self.image = imageToCache
            }
        }.resume()
        
    }
    
}
