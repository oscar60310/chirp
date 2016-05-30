//
//  WelcomeViewController.swift
//  Chirp
//
//  Created by Chen Ping Tsai on 2016/5/30.
//  Copyright © 2016年 NsysuDopp. All rights reserved.
//

import UIKit
class WelcomeViewController: UIViewController , FBSDKLoginButtonDelegate
{
    //FB SDK
    let loginbtn : FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
       
        return button
    }()
    var eh: ErrorHandle!
    var config: Config!
    @IBOutlet weak var APP_Name: UILabel!
    @IBOutlet weak var slogan: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APP_Name.text = "Chirp".localized()
        slogan.text = "Login page slogan".localized()
        
        eh = ErrorHandle(class_name: "WelcomeViewController")
        config = Config()
        view.addSubview(loginbtn)
        loginbtn.center = view.center
        loginbtn.delegate = self
        loginbtn.setTitle("Logging via facebook", forState: UIControlState.Normal)
        
        //若已經登入，強制登出
        if FBSDKAccessToken.currentAccessToken() != nil
        {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
    }
    func getFBdata(token: String)
    {
        print("get facebook auth")
        let parameters = ["fields": "email, first_name, last_name, picture.type(large), id"]
        FBSDKGraphRequest(graphPath: "me",parameters: parameters).startWithCompletionHandler{ (connection, result, error) -> Void in
            
            if error != nil
            {
                //Error
                self.eh.normal(error)
                return
            }
            let js = JSON(result)
            self.config.main_config_write(js.description)
            print(self.config.main_config_read())
            let loginStorg: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
            let vc = loginStorg.instantiateViewControllerWithIdentifier("MainPage") as! ViewController
            self.presentViewController(vc, animated: true, completion: nil)
            
        }
        
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("login")
        let token = FBSDKAccessToken.currentAccessToken()

        getFBdata(token.tokenString)
    }
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }

}