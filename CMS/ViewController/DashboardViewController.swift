//
//  DashboardViewController.swift
//  CMS
//
//  Created by MacBook on 9/10/2021.
//

import UIKit
import SwiftyJSON


class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, addUserProtocol {
    
    
    func addDissmiss() {
        apiRequest(.get, url: Constants.usersList, params: [:] ) { (status, response) in
            if status {
                do {
                    let resp = try JSONDecoder().decode(UsersModel.self, from: JSON(response!).rawData())
                        print( "***********************jawik behiii List *************************")
                    self.users = resp
                    self.table.reloadData()
                } catch {
                    print( "***********************Erreur parsing json List*************************")
                }
            }
        }
        
    }
    
    func deleteUser(id: Int, indexPath: IndexPath){
        apiRequest(.delete, url: Constants.deleteUser + "\(id)", params: [:]) { (status, response) in
            if status {
                do {
                    let resp = try JSONDecoder().decode(DeleteUserModel.self, from: JSON(response!).rawData())
                    if (resp.deleted) {
                        print( "***********************jawik behiii Delete *************************")
                        self.users.remove(at: indexPath.row)
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
    
    
    @IBOutlet weak var table: UITableView!
    
    var users: UsersModel = []
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
    }

    @IBAction func addUserAction(_ sender: Any) {
        let dashboardVC = self.storyboard!.instantiateViewController(withIdentifier: "AddUserViewController") as! AddUserViewController
        dashboardVC.delegate = self
        self.present(dashboardVC, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        apiRequest(.get, url: Constants.usersList, params: [:] ) { (status, response) in
            if status {
                do {
                    let resp = try JSONDecoder().decode(UsersModel.self, from: JSON(response!).rawData())
                        print( "***********************jawik behiii List *************************")
                    self.users = resp
                    self.table.reloadData()
                } catch {
                    print( "***********************Erreur parsing json List*************************")
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction  = UITableViewRowAction(style: .destructive, title: "Delete") { action, indexPath in
            self.deleteUser(id: self.users[indexPath.row].id, indexPath: indexPath)
        }
        let modifAction  = UITableViewRowAction(style: .normal, title: "Edit") { action, indexPath in

        }
        return [deleteAction,modifAction]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.imageView?.tintColor = .systemBlue
        switch users[indexPath.row].roles[0].id {
        case 1:
            cell.imageView?.image = UIImage(systemName: "book")
        case 2:
            cell.imageView?.image = UIImage(systemName: "rectangle.and.pencil.and.ellipsis")
        case 3:
            cell.imageView?.image = UIImage(systemName: "externaldrive")
        default:
            cell.imageView?.image = UIImage(systemName: "book")
        }
        cell.textLabel?.text = users[indexPath.row].username
        return cell
    }
    
}
