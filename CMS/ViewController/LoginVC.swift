//
//  ViewController.swift
//  CMS
//
//  Created by MacBook on 9/10/2021.
//

import UIKit
import SwiftyJSON

class LoginVC: BaseViewController {
    
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var rememberSW: UISwitch!
    @IBOutlet weak var logInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInBtn.backgroundColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }
    @IBAction func usernameEndEditing(_ sender: Any) {
        validateLogIn()
    }
    
    @IBAction func passwordEndEditing(_ sender: Any) {
        validateLogIn()
    }
    
    
    func validateLogIn(){
        
        if(!(usernameTF.text?.isEmpty ?? true) && !(passwordTF.text?.isEmpty ?? true)){
            if ( (passwordTF.text?.count ?? 0) >= 6) {
                logInBtn.isEnabled = true
                logInBtn.backgroundColor = UIColor.systemBlue
            }else {
                logInBtn.isEnabled = false
                logInBtn.backgroundColor = UIColor.lightGray
            }
        }else {
            logInBtn.isEnabled = false
            logInBtn.backgroundColor = UIColor.lightGray
        }
        
    }
    
    
    @IBAction func logInBtnAction(_ sender: Any) {
        var param: [String : AnyObject] = [:]
        param ["password"] = passwordTF.text as AnyObject
        param ["username"] = usernameTF.text as AnyObject
        apiRequest(.post, url: Constants.loginEndPoint, params: param ) { (status, response) in
            if status {
                do {
                    let resp = try JSONDecoder().decode(LogInModel.self, from: JSON(response!).rawData())
                    
                    if resp.accessToken.isEmpty {
                        
 //     let error = try JSONDecoder().decode(ErrorModel.self, from: JSON(response!).rawData())
                        
                        print( "***********************Token null*************************")
                        
                    } else {
                        
                        print( "***********************jawik behiii*************************")
                        DataBaseHelper.sharedInstance.setUsername(value: resp.username)
                        DataBaseHelper.sharedInstance.setaccessToken(value: resp.accessToken)
                        let dashboardVC = self.storyboard!.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
                        self.navigationController?.pushViewController(dashboardVC, animated: true)
                    }
                    
                } catch {
                    
                    print( "***********************Erreur parsing json*************************")

                }
            }
        }
    }
    
    
    
}

