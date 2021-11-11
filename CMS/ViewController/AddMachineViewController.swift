//
//  AddMachineViewController.swift
//  CMS
//
//  Created by MacBook on 4/11/2021.
//

import UIKit

protocol addMachineProtocol {
    func addDissmiss()
}

class AddMachineViewController: UIViewController  ,UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var descriptionTf: UITextField!
    @IBOutlet weak var statusSwt: UISwitch!
    @IBOutlet weak var fefsSwt: UISwitch!
    @IBOutlet weak var typePck: UIPickerView!
    @IBOutlet weak var addBtn: UIButton!
    
    let types = ["AOI","SPI"]
    var delegate : addMachineProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addBtn.isEnabled = false
        addBtn.setTitleColor(UIColor.lightGray, for: .normal)
        addBtn.borderColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    @IBAction func nameEditingChange(_ sender: Any) {
        validate()
    }
    
    @IBAction func descriptionEditingChange(_ sender: Any) {
        validate()
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        var param: [String : AnyObject] = [:]
        param ["name"] = nameTf.text as AnyObject
        param ["description"] = descriptionTf.text as AnyObject
        param ["status"] = statusSwt.isOn as AnyObject
        param ["fese"] = fefsSwt.isOn as AnyObject
        let index = typePck.selectedRow(inComponent: 0)
        param ["mtype"] =  types[index] as AnyObject
        apiRequest(.post, url: Constants.machineAdd, params: param ) { (status, response) in
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func validate(){
        
        if(!(nameTf.text?.isEmpty ?? true) && !(descriptionTf.text?.isEmpty ?? true))
        {
            addBtn.isEnabled = true
            addBtn.setTitleColor(UIColor.systemBlue, for: .normal)
            addBtn.borderColor = UIColor.systemBlue
 
        }else {
            addBtn.isEnabled = false
            addBtn.setTitleColor(UIColor.lightGray, for: .normal)
            addBtn.borderColor = UIColor.lightGray
        }
        
    }

}
