//
//  ViewController.swift
//  Chirp
//
//  Created by Chen Ping Tsai on 2016/5/28.
//  Copyright © 2016年 NsysuDopp. All rights reserved.
//

import UIKit

class ViewController: SlideMenuController{
    
    
// 這裡複寫awakeFromeNib
    override func awakeFromNib() {
        

// load Main
        if let mainController = self.storyboard?.instantiateViewControllerWithIdentifier("create")
        {
            self.mainViewController = mainController
        }
        // load left silde
        if let leftController = self.storyboard?.instantiateViewControllerWithIdentifier("left")
        {
            self.leftViewController = leftController
        }
        //load right silde
       /* if let rightController = self.storyboard?.instantiateViewControllerWithIdentifier("calendar")
        {
            self.rightViewController = rightController
        }*/
        
        debugPrint("awake Main slide menu")
        super.awakeFromNib()
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        // 檢查註冊狀態
        super.viewDidAppear(animated)
      
    }

}

