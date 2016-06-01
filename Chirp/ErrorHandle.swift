//
//  ErrorHandle.swift
//  Chirp
//
//  Created by Chen Ping Tsai on 2016/5/30.
//  Copyright © 2016年 NsysuDopp. All rights reserved.
//

import Foundation
class ErrorHandle
{
    var class_name: String
    var view: UIViewController
    init(class_name: String,view: UIViewController)
    {
        self.class_name = class_name
        self.view = view
    }
    func normal(error_text: Any)
    {
        debugPrint("Error in \(self.class_name) detail")
        debugPrint(error_text)
    }
    func alert(title: String,text: String)
    {
        let refreshAlert = UIAlertController(title: title.localized(), message: text.localized(), preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        
        
        view.presentViewController(refreshAlert, animated: true, completion: nil)

    }
   
}