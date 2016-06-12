//
//  Create2Controller.swift
//  Chirp
//
//  Created by Chen Ping Tsai on 2016/6/12.
//  Copyright © 2016年 NsysuDopp. All rights reserved.
//

import UIKit
import Material
class Create2Controller: UIViewController
{
    @IBOutlet weak var event_input: TextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        event_input.textAlignment = NSTextAlignment.Center
        event_input.font = RobotoFont.mediumWithSize(20)
    }
    
    @IBAction func openleft(sender: AnyObject) {
        self.slideMenuController()?.openLeft()
        
    }
}
