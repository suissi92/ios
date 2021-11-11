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


protocol WSDelegate {
    func actionBegin()
    func actionEnd()
    func testCnx()
}

class APIManager:NSObject {
   
    var delegate:WSDelegate?
    var reachability:Reachability?

    
    func post<T:Codable>(endpoint:EndPoint, withParam param:NSDictionary,withJSONFormat:Bool? = false, completion: @escaping (AlamoResult<T>) -> Void) {
        
            
            let encoding:ParameterEncoding = withJSONFormat! ? Alamofire.URLEncoding.default:Alamofire.JSONEncoding.default
            delegate?.actionBegin()
            guard let url = URL(string:"\(Constants.BaseURL)\(endpoint.rawValue)") else {
                completion(.failure(APIError.invalidURL))
                delegate?.actionEnd()
                return
            }
            
            let params = param as? Parameters
            var headers = Alamofire.SessionManager.defaultHTTPHeaders
//            headers["Authorization"] = UserDefaults.standard.string(forKey: "token") ?? ""
            headers["Authorization"] = KeychainWrapper.standard.string(forKey: "token") ?? ""
            //headers["Authorization"] = Constants.apiKey
            headers["Accept"] = "application/json;version=\(Constants.appVersion ?? "1.0")"
            headers["Accept-Language"] = UserDefaults.standard.string(forKey: "CurrentLanguage")
            headers["User-Agent"] = "iOS \(Constants.osVersion)"
            
            Alamofire.request(url,
                              method: .post,
                              parameters:params,
                              encoding:encoding,
                              headers: headers
                )
                .validate()
                .responseJSON { [weak self] response in
                    
                    if let data = response.data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        print("Response: \(json)")
                    }
                    
                    guard response.result.isSuccess else {
                        print("Error while fetching remote ")
                        completion(.failure(APIError.responseUnsuccessful))
                        self!.delegate?.actionEnd()
                        return
                    }
                    
                    var resultResponse: T
                    if let jsonData = response.data {
                        do {
                            resultResponse = try JSONDecoder().decode(T.self, from: jsonData)
                            self!.delegate?.actionEnd()
                            completion(.success(resultResponse))
                        } catch let error {
                            print(error)
                            self!.delegate?.actionEnd()
                            completion(.failure(APIError.unableToDecode))
                        }
                    } else {
                        self!.delegate?.actionEnd()
                        completion(.failure(APIError.unableToDecode))
                    }
                    
            }

    }
    
    func get<T:Codable>(endpoint:EndPoint, withParam param:NSDictionary, completion: @escaping (AlamoResult<T>) -> Void) {
        
        
        if(reachability?.connection != .none) {
            
            let encoding:ParameterEncoding = Alamofire.URLEncoding.default
            
            var stringUrl:String = "\(Constants.BaseURL)\(endpoint.rawValue)?"
            for item in param {
                stringUrl = "\(stringUrl)\(item.key)=\(item.value)&"
            }
            
            delegate?.actionBegin()
            guard let url = URL(string:stringUrl) else {
                completion(.failure(APIError.invalidURL))
                delegate?.actionEnd()
                return
            }
            
            var headers = Alamofire.SessionManager.defaultHTTPHeaders
//            headers["Authorization"] = UserDefaults.standard.string(forKey: "token") ?? ""
            headers["Authorization"] = KeychainWrapper.standard.string(forKey: "token") ?? ""
            headers["Accept"] = "application/json;version=\(Constants.appVersion ?? "1.0")"
            headers["Accept-Language"] = UserDefaults.standard.string(forKey: "CurrentLanguage")
            headers["User-Agent"] = "iOS \(Constants.osVersion)"
            
            Alamofire.request(url,
                              method: .get,
                              encoding:encoding,
                              headers: headers
                )
                .validate()
                .responseJSON { [weak self] response in
                    guard response.result.isSuccess else {
                        print("Error while fetching remote ")
                        completion(.failure(APIError.responseUnsuccessful))
                        self!.delegate?.actionEnd()
                        return
                    }
                    
                    var resultResponse: T
                    if let jsonData = response.data {
                        do {
                            resultResponse = try JSONDecoder().decode(T.self, from: jsonData)
                            self!.delegate?.actionEnd()
                            completion(.success(resultResponse))
                        } catch let error {
                            print(error)
                            self!.delegate?.actionEnd()
                            completion(.failure(APIError.unableToDecode))
                        }
                    } else {
                        self!.delegate?.actionEnd()
                        completion(.failure(APIError.unableToDecode))
                    }
            }
        
    }
    
    func upload(endpoint:EndPoint, withParam param:NSDictionary,image:UIImage,withJSONFormat:Bool? = false, completion: @escaping (_ value: String,_ success: Bool) -> Void) {
        
        do{
            self.reachability = try Reachability()
        } catch {
            print ("error reachability")
        }
        
        if(reachability?.connection != .none) {
            
            delegate?.actionBegin()
            guard let url = URL(string:"\(Constants.BaseURL)\(endpoint.rawValue)") else {
                completion("nil",false)
                delegate?.actionEnd()
                return
            }
            
            let params = (param as? Parameters)!
            var headers = Alamofire.SessionManager.defaultHTTPHeaders
//            headers["Authorization"] = UserDefaults.standard.string(forKey: "token") ?? ""
            headers["Authorization"] = KeychainWrapper.standard.string(forKey: "token") ?? ""
            //headers["Authorization"] = Constants.apiKey
            headers["Accept"] = "application/json;version=\(Constants.appVersion ?? "1.0")"
            headers["Accept-Language"] = UserDefaults.standard.string(forKey: "CurrentLanguage")
            headers["User-Agent"] = "iOS \(Constants.osVersion)"
            
            
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    if let data:Data = image.jpegData(compressionQuality: 0.5) {
                        multipartFormData.append(data, withName: "file" ,fileName:"image.jpg",mimeType: "image/jpg")
                    }
                    
                    for (key, val) in params {
                        multipartFormData.append((val as! String).data(using: .utf8)!,withName: key)
                    }
            }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: headers) { (result: SessionManager.MultipartFormDataEncodingResult) in
                
                switch result {
                case .failure(let error):
                    print(error)
                    completion("Upload Failed", false)
                    
                case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    
                    upload.uploadProgress(closure: { (progress: Progress) in
                        print(progress)
                    })
                    upload.responseJSON { response in
                        
                        switch response.result
                        {
                        case .failure(let error):
                            print(error)
                            completion("Upload Failed", false)
                            self.delegate?.actionEnd()
                            
                        case .success(let value):
                            self.delegate?.actionEnd()
                            print(value)
                            let dict :NSDictionary = response.result.value! as! NSDictionary
                            if(dict.value(forKey: "error") != nil ){
                                let dictMessage:NSDictionary = dict.value(forKey: "error") as! NSDictionary
                                completion(dictMessage.value(forKey: "message") as! String , false)
                                print("Upload Failed")
                            }else{
                                let dictMessage:NSDictionary = dict.value(forKey: "header") as! NSDictionary
                                let code = dictMessage.value(forKey: "code") as! NSInteger
                                if(code !=  200 ){
                                    completion(dictMessage.value(forKey: "message") as! String , false)
                                    print("Upload Failed")
                                }else{
                                    completion(dictMessage.value(forKey: "message") as! String , true)
                                    print("Upload Success")
                                }
                            }
                            self.delegate?.actionEnd()
                            
                        }
                    }
                }
            }
            
        }else {
            
            let popupView = InfoPopup.instanceFromNib() as! InfoPopup
            popupView.frame = UIScreen.main.bounds
            popupView.type = .lostCnx
            popupView.alpha = 0
            popupView.tag = 101
            popupView.setBoldTitle()
            let currentWindow: UIWindow? = UIApplication.shared.keyWindow
            currentWindow!.addSubview(popupView)
            UIView.animate(withDuration: 0.3, animations: {
                popupView.alpha = 1
            })
            
            return
        }
        

    }
}

