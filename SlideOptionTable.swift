//
//  SlideOptionTable.swift
//  Chirp
//
//  Created by Chen Ping Tsai on 2016/5/29.
//  Copyright © 2016年 NsysuDopp. All rights reserved.
//

import UIKit

class SlideOptionTable: UITableViewController  {
    
    
    var s_option = [SlideOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.s_option = [SlideOption(name: "12s3"),SlideOption(name: "12s4"),SlideOption(name: "12s5")]
        
        
        
    }

    
    //回傳選單數量
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.s_option.count
    }
     
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
     
        var option : SlideOption
        option = s_option[indexPath.row]
        //cell.textLabel?.text = option.name
        return cell
     }

}
