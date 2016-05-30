//
//  WelcomeViewController.swift
//  Chirp
//
//  Created by Chen Ping Tsai on 2016/5/30.
//  Copyright © 2016年 NsysuDopp. All rights reserved.
//

import UIKit
class WelcomeViewController: UIViewController
{
    //FB SDK
    let loginbtn : FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()
    
    @IBOutlet weak var APP_Name: UILabel!
    @IBOutlet weak var slogan: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APP_Name.text = "Chirp".localized()
        slogan.text = "Login page slogan".localized()
        view.addSubview(loginbtn)
        loginbtn.center = view.center
        
        
    }
    

}