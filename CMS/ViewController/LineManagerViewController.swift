//
//  LineManagerViewController.swift
//  CMS
//
//  Created by Haithem Rekik on 13/11/2021.
//

import UIKit

class LineManagerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var selectedSection: Int = -1
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    
    var selectedpicker = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellLineMachine")
        table.delegate = self
        table.dataSource = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.lines.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let name = UILabel(frame: .init(x: 10, y: 0, width: 120, height: 50))
        name.text = Constants.lines[section].name
        header.addSubview(name)
        header.backgroundColor = .white
        header.tag = section
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickSection(_:)))
        header.addGestureRecognizer(tap)
        let pos = UIScreen.main.bounds.width - 80
        let buttonAdd = UIButton(frame: .init(x: pos, y: 5, width: 60, height: 40))
//        buttonAdd.setTitle("Ajout", for: .normal)
//        buttonAdd.setTitleColor(.black, for: .normal)
        buttonAdd.setImage(UIImage(systemName: "plus"), for: .normal)
        buttonAdd.backgroundColor = .clear
        header.addSubview(buttonAdd)
//        buttonAdd.addGestureRecognizer(tap)
        buttonAdd.tag = section
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(onClickAddMachineSection(_:)))
        buttonAdd.addGestureRecognizer(tap2)
        
        header.isUserInteractionEnabled = true
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let machines = Constants.lines[section].machines
        if self.selectedSection == section {
            return machines.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = Constants.lines[indexPath.section].machines[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cellLineMachine", for: indexPath)
        
        cell.textLabel?.text = model.name
        return cell
    }
    
    @objc func onClickSection(_ tap: UITapGestureRecognizer) {
        self.selectSectionByIndex(section: tap.view?.tag ?? -1)
    }
    
    @objc func onClickAddMachineSection(_ tap: UITapGestureRecognizer) {
        let tag = tap.view?.tag ?? -1
        print("add machine for section : \(tag)")
        selectSectionByIndex(section: tag)
        showSelectMachine()
    }
    
    func selectSectionByIndex(section: Int) {
        self.selectedSection = section
        self.table.reloadData()

    }
    
    func showSelectMachine() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        picker.delegate = self
        picker.dataSource = self
        
        picker.selectRow(selectedpicker, inComponent: 0, animated: true)
        vc.view.addSubview(picker)
        picker.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        picker.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        
        let alert = UIAlertController(title: "Select Machine", message: "", preferredStyle: .actionSheet)
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { UIAlertAction in
            
        }))
        alert.addAction(UIAlertAction(title: "select", style: .default, handler: { UIAlertAction in
            self.selectedpicker = picker.selectedRow(inComponent: 0)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension LineManagerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = Constants.machines[row].name
        label.sizeToFit()
        return label
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.machines.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
}
