//
//  Server.swift
//  Chirp
//
//  Created by Chen Ping Tsai on 2016/6/1.
//  Copyright © 2016年 NsysuDopp. All rights reserved.
//

import Foundation
import Alamofire

class Server
{
    // 註冊帳號，電子郵件認證要求
    func register_email_request(email: String,token: String,completion: (result: Bool)->())
    {
        Alamofire.request(.GET, "https://chirp-api.appspot.com/register", parameters: ["email": email,"token": token])
            .responseString { response in
               /* print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization*/
                let re = response.result.value
                if re == nil
                {
                    completion(result: false)
                }
                else
                {
                    let da = response.result.value
                    
                    
                    let data = da!.dataUsingEncoding(NSUTF8StringEncoding)
                    let json = JSON(data: data!)
                    //print(json)
                    if json["Statu"] == "200"
                    {
                        completion(result: true)
                    }
                    else
                    {
                        completion(result: false)
                    }

                }
               
        }

        
    }
    
    // 驗證碼確認
    func register_email_comfirm(email: String,code: String,token: String,completion: (result: Bool)->())
    {
        Alamofire.request(.GET, "https://chirp-api.appspot.com/EmailComfirm", parameters: ["email": email,"code": code,"token": token])
            .responseString { response in
                /* print(response.request)  // original URL request
                 print(response.response) // URL response
                 print(response.data)     // server data
                 print(response.result)   // result of response serialization*/
                let re = response.result.value
                if re == nil
                {
                    completion(result: false)
                }
                else
                {
                    let da = response.result.value
                    
                    
                    let data = da!.dataUsingEncoding(NSUTF8StringEncoding)
                    let json = JSON(data: data!)
                    //print(json)
                    if json["Statu"] == "200"
                    {
                        completion(result: true)
                    }
                    else
                    {
                        completion(result: false)
                    }
                    
                }
                
        }
        
        
    }
    
    
    //登入
    func Login(token: String,view: UIViewController, completion: (result: String)->())
    {
        Alamofire.request(.GET, "https://chirp-api.appspot.com/Login", parameters: ["token": token])
            .responseString { response in
                /* print(response.request)  // original URL request
                 print(response.response) // URL response
                 print(response.data)     // server data
                 print(response.result)   // result of response serialization*/
                let re = response.result.value
                if re == nil
                {
                    completion(result: "500")
                }
                else
                {
                    let da = response.result.value
                    
                    
                    let data = da!.dataUsingEncoding(NSUTF8StringEncoding)
                    let json = JSON(data: data!)
                    //print(json)
                    if json["Statu"] == "200"
                    {
                        let con = Config(views: view)
                        con.token_config_write(json["access_token"].string!)
                        completion(result: "200")
                        
                    }
                    else
                    {
                        completion(result: json["Statu"].stringValue)
                    }
                    
                }
                
        }
        
        
    }

    // 取得使用者資料
    func get_profile(token: String,view: UIViewController, completion: (result: String)->())
    {
        Alamofire.request(.GET, "https://chirp-api.appspot.com/GetProfile", parameters: ["token": token])
            .responseString { response in
                /* print(response.request)  // original URL request
                 print(response.response) // URL response
                 print(response.data)     // server data
                 print(response.result)   // result of response serialization*/
                let re = response.result.value
                if re == nil
                {
                    completion(result: "500")
                }
                else
                {
                    let da = response.result.value
                    
                    
                    let data = da!.dataUsingEncoding(NSUTF8StringEncoding)
                    let json = JSON(data: data!)
                    print(da)
                    if json["Statu"] == "200"
                    {
                        let con = Config(views: view)
                        con.main_config_write(json["data"])
                        completion(result: "200")
                        
                    }
                    else
                    {
                        print(json["Statu"].stringValue+"e04")
                        completion(result: json["Statu"].stringValue)
                    }
                    
                }
                
        }
        
        
    }

}
