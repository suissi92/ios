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
}
