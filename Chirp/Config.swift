//
//  Config.swift
//  Chirp
//
//  Created by Chen Ping Tsai on 2016/5/30.
//  Copyright © 2016年 NsysuDopp. All rights reserved.
//

import Foundation
class Config
{
    var eh: ErrorHandle!
    init()
    {
        eh = ErrorHandle(class_name: "Config")
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.URLByAppendingPathComponent("config").path!
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(filePath)
        {
            
            let file = "config" //this is the file. we will write to and read from it
            
            let text = "" //just a text
            
            if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
                let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(file)
                
                //writing
                do {
                    try text.writeToURL(path, atomically: false, encoding: NSUTF8StringEncoding)
                }
                catch { eh.normal("file create error")}
            }
        }
    }
func main_config_read() -> JSON
    {
        let file = "config" //this is the file. we will write to and read from it
        
        
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(file)

            do
            {
                let text = try NSString(contentsOfURL: path, encoding: NSUTF8StringEncoding)
                let data = text.dataUsingEncoding(NSUTF8StringEncoding)
                let json = JSON(data: data!)
                return json
            }
            catch
            {
                eh.normal("file read error")
                return nil
            }
        }
        else
        {
            eh.normal("file not exit")
            return nil
        }
      
    }
    func main_config_write(text: String)
    {
        let file = "config" //this is the file. we will write to and read from it
   
        
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(file)
            
            //writing
            do {
                try text.writeToURL(path, atomically: false, encoding: NSUTF8StringEncoding)
            }
            catch { eh.normal("file create error")}
        }

    }
   
}