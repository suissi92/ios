//
//  LoadingView.swift
//  CMS
//
//  Created by MacBook on 9/10/2021.
//

import UIKit

/*
 
 Temporary Loading View While we don't have design for Loader, to give impression for loading
 
 */

class LoadingView: UIView {
    
    /*
     
     Init Loading View with frame and add it to Subview
     
     */
    
    override init(frame: CGRect) {
        
        
        
        super.init(frame: frame)
        
        
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        
        /*
         
         Create Uiview and Setup UI
         
         */
        
        let loadingView: UIView = UIView()
        
        
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        
        
        
        loadingView.center = self.center
        
        
        
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        
        
        loadingView.clipsToBounds = true
        
        
        
        loadingView.layer.cornerRadius = 10
        
        
        
        loadingView.tintColor =   UIColor.systemBlue
        
        /*
         
         Add Activity Indicator
         
         */
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        
        
        
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        
        
        
        actInd.style = UIActivityIndicatorView.Style.whiteLarge
        
        
        
        actInd.color = UIColor.white
        
        
        
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
        
        
        
        actInd.startAnimating()
        
        
        
        loadingView.addSubview(actInd)
        
        
        
        self.addSubview(loadingView)
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("AppErrorData")
        
    }
    
    
    
}
