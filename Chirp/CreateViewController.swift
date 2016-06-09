import UIKit
import Material

class CreateViewController : UIViewController,UITableViewDelegate,UITableViewDataSource{
    
     // 上方標題
    

    @IBOutlet weak var label_day: UILabel!
    
    @IBOutlet weak var label_location: UILabel!
    @IBOutlet weak var location_input: TextField!
    
    @IBOutlet weak var label_event_name: UILabel!
    @IBOutlet weak var event_name_input: TextField!
    @IBOutlet weak var NavBar: UINavigationBar!
    @IBAction func openSlide(sender: AnyObject) {
        self.slideMenuController()?.openLeft()
    }
    override func viewDidLoad() {
        Localize.setCurrentLanguage("zh-Hant")
        //NavBar.topItem?.title = "create event".localized()
   
        super.viewDidLoad()
        tabletime.delegate = self
        tabletime.dataSource = self
        /// TEMP DEBUG Change language to chinese
        //print(Localize.availableLanguages())
 
        ///
      
        
    }
    @IBAction func check_name(sender: TextField) {
      check_title()
        
    }
    
    @IBOutlet weak var note_input: TextField!
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        event_name_input.font = RobotoFont.mediumWithSize(20)
        label_event_name.text = "event name".localized()
        event_name_input.textAlignment = NSTextAlignment.Center
        
        location_input.font = RobotoFont.mediumWithSize(20)
        label_location.text = "event location".localized()
        location_input.textAlignment = NSTextAlignment.Center
        note_input.font = RobotoFont.mediumWithSize(20)
        note_input.textAlignment = NSTextAlignment.Center
        
        
       
     
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // 開啟側邊選單
    
    @IBAction func openleft(sender: AnyObject) {
        self.slideMenuController()?.openLeft()
    }

    func check_title() -> Bool
    {
        
        let num = NSString(string: event_name_input.text!).length
        if num < 3 || num > 20
        {
            event_name_input.textColor = MaterialColor.red.base
            return false
        }
        else
        {
            event_name_input.textColor = MaterialColor.black

             return true
        }
       

    }
    var start_date = NSDate()
    var end_date = NSDate()
    var date_play = [NSDate]()
    @IBOutlet weak var label_set_date: FlatButton!
    
    @IBAction func select_date(sender: AnyObject) {
        DatePickerDialog().show("設定開始日期", doneButtonTitle: "確定", cancelButtonTitle: "取消", datePickerMode: .Date) {
            (date) -> Void in
            
            
            let date_for = NSDateFormatter()
            date_for.dateFormat = "y/M/d"
            
            self.start_date = date
            DatePickerDialog().show("設定結束日期", doneButtonTitle: "確定", cancelButtonTitle: "取消", datePickerMode: .Date) {
                (date2) -> Void in
                self.end_date = date2
                //print(self.start_date,self.end_date)
              
                self.date_play = []
                if self.end_date.timeIntervalSince1970 - self.start_date.timeIntervalSince1970 < 0
                {
                    TSMessage.showNotificationInViewController(self, title: "time set error".localized(), subtitle: "your time set is error".localized(), type: TSMessageNotificationType.Warning)
                    return
                }
                else if date_for.stringFromDate(self.end_date) == date_for.stringFromDate(self.start_date)
                {
                    self.date_play.append(date)
                    self.label_set_date.setTitle(" " + date_for.stringFromDate(self.start_date), forState: UIControlState.Normal)
                }
                else
                {
                    var datetemp = self.start_date
                    while date_for.stringFromDate(self.end_date) != date_for.stringFromDate(datetemp)
                    {
                        print(datetemp)
                        datetemp = datetemp.dateByAddingTimeInterval(60 * 60 * 24)
                        self.date_play.append(datetemp)
                        
                    }
                    
                    self.date_play.append(self.end_date)
                    
                    self.label_set_date.setTitle(" " + date_for.stringFromDate(self.start_date) + " → " + date_for.stringFromDate(self.end_date), forState: UIControlState.Normal)

                }
                
                TSMessage.showNotificationInViewController(self, title: "very well".localized(), subtitle: "now you can design the ".localized() + String(self.date_play.count) + " days activity".localized(), type: TSMessageNotificationType.Success)
            
             
                
                
            }
           
        }
        
        
    }
    
    // Return Options count
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return timeline.count
    }
    
    
    @IBOutlet weak var tabletime: UITableView!
    // return cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
       
        let cell = self.tabletime.dequeueReusableCellWithIdentifier("timeline") as! TimeLineCreate
       // print(timeline[indexPath.row])
        cell.detail.text = timeline[indexPath.row]["description"].stringValue
        let date_for = NSDateFormatter()
        date_for.dateFormat = "yyyy/MM/dd HH:mm"
        let start = date_for.dateFromString( timeline[indexPath.row]["start_time"].stringValue)
        let end = date_for.dateFromString( timeline[indexPath.row]["end_time"].stringValue)
        date_for.dateFormat = "HH:mm"
        cell.start_time.text = date_for.stringFromDate(start!)
        cell.end_time.text = date_for.stringFromDate(end!)
        date_for.dateFormat = "M/d"
        cell.date_show.text = date_for.stringFromDate(start!)
  
        return cell

    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    @IBOutlet weak var viewArea: UIView!
    @IBOutlet weak var start_time_label: UIButton!
    
    @IBOutlet weak var end_time_lable: UIButton!
    
    var detail_start_time = NSDate()
    var detail_end_time = NSDate()
    @IBAction func set_start_time(sender: UIButton) {
       let ac =  ActionSheetDatePicker(title: "設定時間", datePickerMode: UIDatePickerMode.DateAndTime, selectedDate: self.detail_start_time, doneBlock: {
            picker, value, index in
            self.detail_start_time = value as! NSDate
            let date_for = NSDateFormatter()
            date_for.dateFormat = "HHmm"
            self.start_time_label.setTitle(date_for.stringFromDate(self.detail_start_time), forState: UIControlState
        .Normal)
        

        
        
            return
            }, cancelBlock: {
                ActionStringCancelBlock in return
            }, origin: self.viewArea)
        ac.showActionSheetPicker()
    
        
        
    }
    @IBAction func set_end_time(sender: AnyObject) {
        let ac =  ActionSheetDatePicker(title: "設定時間", datePickerMode: UIDatePickerMode.DateAndTime, selectedDate: self.detail_end_time, doneBlock: {
            picker, value, index in
            self.detail_end_time = value as! NSDate
            let date_for = NSDateFormatter()
            date_for.dateFormat = "HHmm"
            self.end_time_lable.setTitle(date_for.stringFromDate(self.detail_end_time), forState: UIControlState
                .Normal)
            
            
            
            
            return
            }, cancelBlock: {
                ActionStringCancelBlock in return
            }, origin: self.viewArea)
        ac.showActionSheetPicker()
        

    }
    
    @IBOutlet weak var detail_input: TextField!
    var timeline = [JSON]()
    @IBAction func add_detail(sender: UIButton) {
        if detail_input.text != ""
        {
            let data = time_line_det(detail_start_time, end_time: detail_end_time, description: detail_input.text!)
            timeline.append(data)
            
            tabletime.beginUpdates()
            tabletime.insertRowsAtIndexPaths([
                NSIndexPath(forRow: timeline.count-1, inSection: 0)
                ], withRowAnimation: .Automatic)
            
            tabletime.endUpdates()
            
            
            detail_input.text = ""
            detail_start_time = detail_end_time
            
            //print(JSON(timeline).rawString())
        }
        
    }
    func time_line_det(start_time: NSDate,end_time:NSDate,description:String) -> JSON
    {
       // let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
     
        let date_for = NSDateFormatter()
        date_for.dateFormat = "yyyy/MM/dd HH:mm"
        let json = JSON(["start_time":date_for.stringFromDate(start_time),"end_time":date_for.stringFromDate(end_time),"description":description])
       // print(json.rawString())
        return json
    }
}


