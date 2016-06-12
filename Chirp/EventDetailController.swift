//
//  EventDetailController.swift
//  Chirp
//
//  Created by Chen Ping Tsai on 2016/6/12.
//  Copyright © 2016年 NsysuDopp. All rights reserved.
//

import UIKit
import Material
class EventDetailController: UIViewController
{
    let event_time = ["05:30","10:30","11:30","12:30","13:00","16:00","18:00","20:00","22:00","23:00"]
    let event_name = ["高雄火車站集合：某個姓黃的不要坐錯車  地理標籤：高雄火車站附近",
                      "到花蓮租車：在火車站附近租車，請準備好駕照",
                      "check in",
                      "花蓮創意文創園區",
                      "七星潭打水漂",
                      "自強夜市",
                      "回民宿休息",
                      "北濱公園看夜景",
                      "吃宵公正包子",
                      "客棧休息"]
  
    @IBOutlet weak var postion_set: UIStackView!
    
    override func viewDidLoad() {
        
        var frame = postion_set.frame
        frame.origin.y = frame.origin.y - 210
        frame.origin.x = frame.origin.x - 10
        
        let timelineview = TimeLineViewControl(timeArray: event_time, andTimeDescriptionArray: event_name, andCurrentStatus: 5, andFrame: frame)
        time_line.addSubview(timelineview)
    
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var time_line: TimeLineViewControl!
    @IBOutlet weak var content: UIView!
    @IBAction func openleft(sender: AnyObject) {
        self.slideMenuController()?.openLeft()
        
    }
}

