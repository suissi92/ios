//
//  Constant.swift
//  CMS
//
//  Created by MacBook on 9/10/2021.
//

import Foundation
import UIKit

/*
 
 This class contains application's constants
 
 */

class Constants {
    
    /*
     WS URLS
     */
    static let baseURL              =  "http://localhost:8080/"
    
    /*
     endpoint
     */
    static let loginEndPoint           =  baseURL + "api/auth/login"
    static let usersList               = baseURL + "admin/list"
    static let userAdd                 =   baseURL + "api/auth/register"
    static let deleteUser               = baseURL + "admin/delete/"
    static let machinesList             = baseURL + "admin/machine/list"
    static let deleteMachine           = baseURL + "admin/machine/delete/"
    static let machineAdd           = baseURL + "admin/machine/add"

    
    /*
     key constant
     */
    
    static let usernameKey = "USERNAME"
    static let accessTokenkey = "TOKEN"
    
    
    /*
     HardCoded Models
     */
    
    static let roleAdmin = Role(id: 1, name: "Admin")
    static let roleMachiniste = Role(id: 2, name: "Machiniste")
    static let roleLineManager = Role(id: 3, name: "LineManager")
    static let user1 = UsersModelElement(id: 0, name: "Haithem", username: "Haithem", email: "haithem@gmaill.com", password: "252805", roles: [roleAdmin])
    static let user2 = UsersModelElement(id: 2, name: "Houssem", username: "Houssem", email: "houssem@gmaill.com", password: "252805", roles: [roleLineManager])
    static let user3 = UsersModelElement(id: 3, name: "Dibou", username: "Dibou", email: "dibou@gmaill.com", password: "252805", roles: [roleMachiniste])
    static let users: UsersModel = [user1, user2, user3]
    static let machine1 = Machine(id: 0, name: "Machine 1", machineDescription: "Description test 1", status: true, mtype: "ALA", fese: false)
    static let machine2 = Machine(id: 1, name: "Machine 2", machineDescription: "Description text 2", status: false, mtype: "NAQQA", fese: true)
    static let machine3 = Machine(id: 2, name: "Machine 3", machineDescription: "Description text 3", status: true, mtype: "FSEA", fese: true)
    static let machine4 = Machine(id: 3, name: "Machine 4", machineDescription: "Description text 4", status: false, mtype: "4LPFA", fese: false)
    static let machines: Machines = [machine1,machine2,machine3,machine4]
    static let line1 = Line(id: 0, name: "Lines 1", Description: "Description test 1", machines: [machine1,machine3,machine4])
    static let line2 = Line(id: 1, name: "Lines 2", Description: "Description test 2", machines: [machine2,machine4])
    static let line3 = Line(id: 2, name: "Lines 3", Description: "Description test 3", machines: [])
    static let line4 = Line(id: 3, name: "Lines 4", Description: "Description test 4", machines: [machine3])
    static let lines: LinesModel = [line1,line2,line3,line4]
}
