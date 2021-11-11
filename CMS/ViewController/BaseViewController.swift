//
//  BaseViewController.swift
//  CMS
//
//  Created by MacBook on 9/10/2021.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        endEditingOnTap()
    }
    
    // onTapGesture action
    func endEditingOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /*
          Static function to Show Loader
       */

     func showLoader() {
        self.showActivityIndicatoryInSuperview()
      }

      /*

          Static function to Hide Loader

       */

     func hideLoader() {

          self.hideActivityIndicatoryInSuperview()

      }

}
