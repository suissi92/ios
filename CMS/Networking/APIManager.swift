//
//  NetworkLayer.swift
//  Networking
//
//  Created by mobiblanc on 02/11/2018.
//  Copyright © 2018 mobiblanc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


/*
 Function for API's communication and retrieving results
 Args:
 - method as HTTPMethod (get/Post...)
 - url as String
 - Parameters as key and value
 - completion : define code to execute after getting result : - finished as bool for status
 - response as anyobject
 */
func apiRequest(_ method: HTTPMethod, url: String, params: [String: Any],
                completion:@escaping(_ finished: Bool,
                                     _ response: AnyObject?) -> Void) {
    /*
     Definition Of Headers `
     */
    var headers = HTTPHeaders()
    
    /*
     Add Headers
     */
    headers.add(name: "token", value: DataBaseHelper.sharedInstance.getaccessToken())
    var encoding: ParameterEncoding = JSONEncoding.default
    
    if method == .get {
        encoding = URLEncoding.default
    }
    /*
     Returns a new string made from the receiver by replacing all characters,
     not in the specified set with percent-encoded characters.
     */
    
    let urlWithAllowedCharacters = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    /*
     Do Request to API, with needed parametres like (url, method (Get/Post...), encoding and headers)
     */
    AF.request(urlWithAllowedCharacters,
               method: method,
               parameters: params,
               encoding: encoding,
               headers: headers,
               interceptor: nil,
               requestModifier: nil).validate(statusCode: 200..<600).responseJSON { (response) in
        /* Check if Request is Succes Or Failure */
        switch response.result {
        case .success(let succes):
            print(succes)
            /* If Case is Succes, we can get data, and send it to VM */
            if let data = response.data {
                completion(true, data as AnyObject?)
            }
        case .failure(let error):
            print(error)
            /* If Case is failure, we can send it to VM to goal to tell user */
            completion(false, response.error as AnyObject?)
        }
        
    }
}

