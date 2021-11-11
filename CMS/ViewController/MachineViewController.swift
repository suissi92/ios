//
//  MachineViewController.swift
//  CMS
//
//  Created by MacBook on 31/10/2021.
//

import UIKit
import SwiftyJSON


class MachineViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, addMachineProtocol {
    
    func addDissmiss() {
        apiRequest(.get, url: Constants.machinesList, params: [:] ) { (status, response) in
            if status {
                do {
                    let resp = try JSONDecoder().decode(Machines.self, from: JSON(response!).rawData())
                        print( "***********************jawik behiii List *************************")
                    self.datasource = resp
                    self.table.reloadData()
                } catch {
                    print( "***********************Erreur parsing json List*************************")
                }
            }
        }
        
    }

    

    
    @IBOutlet weak var table: UITableView!
    
    var datasource: Machines = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        apiRequest(.get, url: Constants.machinesList, params: [:] ) { (status, response) in
            if status {
                do {
                    let resp = try JSONDecoder().decode(Machines.self, from: JSON(response!).rawData())
                        print( "***********************jawik behiii List *************************")
                    self.datasource = resp
                    self.table.reloadData()
                } catch {
                    print( "***********************Erreur parsing json List*************************")
                }
            }
        }
        
    }
    @IBAction func AddMachineBtnAction(_ sender: Any) {
        let addMachineVC = self.storyboard!.instantiateViewController(withIdentifier: "AddMachineViewController") as! AddMachineViewController
        addMachineVC.delegate = self
        self.present(addMachineVC, animated: true)
    }
    
    func deleteMachine(id: Int, indexPath: IndexPath){
        apiRequest(.delete, url: Constants.deleteMachine + "\(id)", params: [:]) { (status, response) in
            if status {
                do {
                    let resp = try JSONDecoder().decode(DeleteUserModel.self, from: JSON(response!).rawData())
                    if (resp.deleted) {
                        print( "***********************jawik behiii Delete *************************")
                        self.datasource.remove(at: indexPath.row)
                        self.table.deleteRows(at: [indexPath], with: .automatic)
                    }else {
                        print( "***********************jawik Mouch behiii Delete *************************")
                    }
                    self.table.reloadData()
                } catch {
                    print( "***********************Erreur parsing json Delete*************************")
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: MachineCell.nibname, for: indexPath) as! MachineCell
        let machine = datasource[indexPath.row]
        cell.initCell(name: machine.name, desc: machine.machineDescription, type: machine.mtype, status: machine.status, fese: machine.fese)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction  = UITableViewRowAction(style: .destructive, title: "Delete") { action, indexPath in
            self.deleteMachine(id: self.datasource[indexPath.row].id
                               , indexPath: indexPath)
        }
        let modifAction  = UITableViewRowAction(style: .normal, title: "Edit") { action, indexPath in

        }
        return [deleteAction,modifAction]
    }

}
