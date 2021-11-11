//
//  DataHelper.swift
//  CMS
//
//  Created by MacBook on 9/10/2021.
//

import Foundation
import KeychainSwift
/*

    This class contains the shared Keychain

 */

class DataBaseHelper: NSObject {

     static let sharedInstance = DataBaseHelper()
     let sharedKeychain = KeychainSwift()

    /*
     this func verifie if key is present or not in Keychain
        params: - Key: String
        return: Bool
    */

    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return self.sharedKeychain.allKeys.contains(key)
    }

    /*
        Clear all keys
     */

    func clearData() {
        self.sharedKeychain.clear()
    }

    /*
     this func set username in Keychain
        params: - value: String
    */

    func setUsername(value: String) {
        self.sharedKeychain.set(value, forKey: Constants.usernameKey)
    }

    /*
     this func get username from Keychain
        return: String
    */

    func getUsername() -> String {

        if isKeyPresentInUserDefaults(key: Constants.usernameKey) {
            return self.sharedKeychain.get(Constants.usernameKey)!
        }

        return ""

    }

    /*

     this func set access token in Keychain

        params: - value: String

    */

    func setaccessToken(value: String) {
        self.sharedKeychain.set(value, forKey: Constants.accessTokenkey)
    }

    

    /*

     this func get access Token from Keychain

        return: String

    */

    func getaccessToken() -> String {
        if isKeyPresentInUserDefaults(key: Constants.accessTokenkey) {
            return self.sharedKeychain.get(Constants.accessTokenkey)!

        }
        return ""

    }
}
