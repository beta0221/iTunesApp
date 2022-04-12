//
//  Spinner.swift
//  iTunesApp
//
//  Created by 林奕儒 on 2022/4/11.
//

import UIKit

open class Spinner{
    internal static var spinner:UIActivityIndicatorView?
    
    static var topVC:UIViewController?{
        get{
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                return topController
            }
            return nil
        }
    }
    
    public static func start() {
        if spinner == nil, let topVC = topVC {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner!.style = .large
            spinner!.color = .gray

            topVC.view.addSubview(spinner!)
            spinner!.startAnimating()
        }
    }
    
    
    public static func stop() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
    
}
