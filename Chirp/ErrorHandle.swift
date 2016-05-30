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
    init(class_name: String)
    {
        self.class_name = class_name
    }
    func normal(error_text: Any)
    {
        debugPrint("Error in \(self.class_name) detail")
        debugPrint(error_text)
    }
}