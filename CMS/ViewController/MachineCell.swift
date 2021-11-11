//
//  MachineCell.swift
//  CMS
//
//  Created by MacBook on 31/10/2021.
//

import UIKit

class MachineCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var statusSwt: UISwitch!
    @IBOutlet weak var feseSwt: UISwitch!
    
    static let nibname = "MachineCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func initCell(name: String, desc: String, type: String, status: Bool, fese: Bool) {
        nameLbl.text = "\(name) (\(type))"
        descriptionLbl.text = desc
        statusSwt.setOn(status, animated: true)
        feseSwt.setOn(fese, animated: true)
    }


}
