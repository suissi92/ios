//
//  AddUserViewController.swift
//  CMS
//
//  Created by MacBook on 19/10/2021.
//

import UIKit

protocol addUserProtocol {
    func addDissmiss()
}

class AddUserViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var rolePickerView: UIPickerView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var addUserBtn: UIButton!
    
    let roles = ["ADMIN","LigneManager","Machinist"]
    var delegate: addUserProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        rolePickerView.delegate = self
        rolePickerView.dataSource = self
        addUserBtn.isEnabled = false
        addUserBtn.setTitleColor(UIColor.lightGray, for: .normal)
        addUserBtn.borderColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nameEndEdit(_ sender: Any) {
        validate()
    }
    
    @IBAction func emailEndEdit(_ sender: Any) {
        validate()
    }
    @IBAction func userNameEndEditing(_ sender: Any) {
        validate()
    }
    
    @IBAction func passwordEndEdit(_ sender: Any) {
        validate()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roles.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  roles[row]
    }
    
    @IBAction func addActionBtn(_ sender: Any) {
        var param: [String : AnyObject] = [:]
        param ["password"] = passwordTF.text as AnyObject
        param ["username"] = userNameTF.text as AnyObject
        param ["name"] = nameTF.text as AnyObject
        param ["email"] = emailTF.text as AnyObject
        let index = rolePickerView.selectedRow(inComponent: 0)
        param ["role"] =  [roles[index]] as AnyObject
        apiRequest(.post, url: Constants.userAdd, params: param ) { (status, response) in
            if status {
                self.dismiss(animated: true, completion: nil)
                print("***********************jawik behiii Add *************************")
            } else {
                print("***********************jawik mouch behiii Add *************************")
                self.dismiss(animated: true, completion: nil)
            }
            self.delegate?.addDissmiss()
        }
    }
    
    func validate(){
        
        if(!(userNameTF.text?.isEmpty ?? true) && !(passwordTF.text?.isEmpty ?? true) && !(nameTF.text?.isEmpty ?? true) && !(emailTF.text?.isEmpty ?? true)){
            if ( (passwordTF.text?.count ?? 0) >= 6) {
                addUserBtn.isEnabled = true
                addUserBtn.setTitleColor(UIColor.systemBlue, for: .normal)
                addUserBtn.borderColor = UIColor.systemBlue
               
            }else {
                addUserBtn.isEnabled = false
                addUserBtn.setTitleColor(UIColor.lightGray, for: .normal)
                addUserBtn.borderColor = UIColor.lightGray
            }
        }else {
            addUserBtn.isEnabled = false
            addUserBtn.setTitleColor(UIColor.lightGray, for: .normal)
            addUserBtn.borderColor = UIColor.lightGray
        }
        
    }
    
    
}
