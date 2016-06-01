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
}
