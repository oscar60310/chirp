//
//  WelcomeViewController.swift
//  Chirp
//
//  Created by Chen Ping Tsai on 2016/5/30.
//  Copyright © 2016年 NsysuDopp. All rights reserved.
//

import UIKit
import Material


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
    @IBOutlet weak var email_label1: UILabel!
    @IBOutlet weak var email_label2: UILabel!
    @IBOutlet weak var display_view: UIView!
    @IBOutlet weak var email_input: TextField!
    var token = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APP_Name.text = "Chirp".localized()
        slogan.text = "Login page slogan".localized()
        display_view.hidden = true
        
        email_input.textColor = MaterialColor.white
        email_input.textAlignment = NSTextAlignment.Center
        email_input.font = UIFont.systemFontOfSize(20.0)
        
        eh = ErrorHandle(class_name: "WelcomeViewController",view: self)
        config = Config(views: self)
        view.addSubview(loginbtn)
  
        loginbtn.center = CGPointMake(view.bounds.size.width / 2 , view.bounds.size.height / 2 + loginbtn.bounds.size.height)
        
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
        // Remove facebook button
       
        self.token = token
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large), id, name"]
        FBSDKGraphRequest(graphPath: "me",parameters: parameters).startWithCompletionHandler{ (connection, result, error) -> Void in
            
            if error != nil
            {
                //Error
                self.eh.normal(error)
                return
            }
            
            // 檢查是不是會員
            let se = Server()
            se.Login(token,view: self){ (result_login) -> () in
                self.busy = false
                self.button_label.setTitle("submit".localized(), forState:  UIControlState.Normal)
                self.button_label.enabled = true
                if result_login == "200"
                {
                    let Main: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
                    let vc = Main.instantiateViewControllerWithIdentifier("MainPage") as! ViewController
                    self.presentViewController(vc, animated: true, completion: nil)
                    
                    let js = JSON(result)
                    
                    TSMessage.showNotificationInViewController(vc, title: "welcome back".localized(), subtitle: "HI " + js["first_name"].string! + "grade to see you again".localized(), type: TSMessageNotificationType.Success)
                    
                }
                else if result_login == "403"
                {
                    let js = JSON(result)
                    self.loginbtn.hidden = true
                    self.display_view.hidden = false
                    self.email_label1.text = "Hi ".localized() +  js["first_name"].string! + "，" + "nice to see you".localized()
                    self.email_label2.text = "we need email confirm".localized()

                }
                else
                {
                    self.eh.alert("login errror", text: "network error")
                }
                
            }
            
            
            
          
            /*
            let loginStorg: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
            let vc = loginStorg.instantiateViewControllerWithIdentifier("MainPage") as! ViewController
            self.presentViewController(vc, animated: true, completion: nil)*/
            
        }
        
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("login")
        let token = FBSDKAccessToken.currentAccessToken()
        if token == nil
        {
            return
        }
        getFBdata(token.tokenString)
    }
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    var busy = false
    var statu = 1
    var email = ""
 
    @IBOutlet weak var button_label: UIButton!
    @IBAction func email_send(sender: AnyObject) {
       
        if self.busy
        {
         
            return
        }
        self.button_label.setTitle("busy".localized(), forState:  UIControlState.Normal)
        self.button_label.enabled = false
        if statu == 1
        {
            self.busy = true
            let email: String = email_input.text!
            self.email = email
            let se = Server()
            se.register_email_request(email, token: self.token){ (boolValue) -> () in
                self.busy = false
                self.button_label.setTitle("submit".localized(), forState:  UIControlState.Normal)
                self.button_label.enabled = true
                if boolValue
                {
               
                    TSMessage.showNotificationInViewController(self, title: "email ok".localized(), subtitle: "email sended".localized(), type: TSMessageNotificationType.Success)
                    self.email_label2.text = "please enter code".localized()
                    self.email_input.placeholder = "code with five char".localized()
                    self.email_input.text = ""
                    self.statu = 2
                

                }
                else{
                    
                    TSMessage.showNotificationInViewController(self, title: "email fail".localized(), subtitle: "email not allow".localized(), type: TSMessageNotificationType.Error)
       
                }
            }
        }
        else if statu == 2
        {
            self.busy = true
            
            let code: String = email_input.text!
            let se = Server()
            se.register_email_comfirm(self.email,code: code,token: self.token){ (boolValue) -> () in
              
                if boolValue
                {
                    //self.eh.alert("OK", text: "OK")
                    self.goLogin(self.token)

                }
                else
                {
                    self.busy = false
                    self.button_label.setTitle("submit".localized(), forState:  UIControlState.Normal)
                    self.button_label.enabled = true
                    TSMessage.showNotificationInViewController(self, title: "code fail".localized(), subtitle: "code not currect".localized(), type: TSMessageNotificationType.Error)

             	
                }
                
            }
            
        }
        
       
        
    }
    func goLogin(token: String)
    {
        let se = Server()
        se.Login(token,view: self){ (result) -> () in
            self.busy = false
            self.button_label.setTitle("submit".localized(), forState:  UIControlState.Normal)
            self.button_label.enabled = true
            if result == "200"
            {
                let Main: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
                let vc = Main.instantiateViewControllerWithIdentifier("MainPage") as! ViewController
                self.presentViewController(vc, animated: true, completion: nil)
                
            }
            else
            {
                self.eh.alert("code fail", text: result)
                
            }
            
        }

    }
   
   
}