//
//  UIViewControllerExtension.swift
//  CMS
//
//  Created by MacBook on 9/10/2021.
//

import Foundation
import UIKit

extension   UIViewController{
    
     func showActivityIndicatoryInSuperview() {
        
        
        
        let window = UIApplication.shared.keyWindow!
        
        let loadingView = LoadingView(frame: CGRect(x: window.frame.origin.x,
                                                    
                                                    y: window.frame.origin.y,
                                                    
                                                    width: window.frame.width,
                                                    
                                                    height: window.frame.height))
        
        loadingView.tag = 99
        
        //        loadingView.
        
        window.subviews.filter({$0.tag == 99}).forEach { mView in
            
            mView.removeFromSuperview()
            
        }
        
        window.addSubview(loadingView)
        
        objc_setAssociatedObject(UIApplication.shared.keyWindow?.rootViewController! as Any,
                                 "_UIViewActivityIndicatorViewInSuperviewAssociatedObjectKey",
                                 
                                 loadingView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
    }
    
    /*
     
     Hide Loading View from SuperView
     
     */
    
    func hideActivityIndicatoryInSuperview() {
        
        
        
        if let activityIndicatory = objc_getAssociatedObject(UIApplication.shared.keyWindow?.rootViewController as Any,
                                    "_UIViewActivityIndicatorViewInSuperviewAssociatedObjectKey") {
            (activityIndicatory as AnyObject).removeFromSuperview()
            
        }
        
        
        
    }
}
