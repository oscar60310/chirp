import UIKit
import Material
import GoogleMaps
class CreateViewController : UIViewController{
    
     // 上方標題
    

    @IBOutlet weak var label_day: UILabel!
    
    @IBOutlet weak var label_location: UILabel!
    @IBOutlet weak var location_input: TextField!
    
    @IBOutlet weak var label_event_name: UILabel!
    @IBOutlet weak var event_name_input: TextField!
    @IBOutlet weak var NavBar: UINavigationBar!
    
    
    @IBOutlet weak var map_view: GMSMapView!
    
    @IBAction func openSlide(sender: AnyObject) {
        self.slideMenuController()?.openLeft()
    }
    
    
    
    
      override func viewDidLoad() {
        Localize.setCurrentLanguage("zh-Hant")
        //NavBar.topItem?.title = "create event".localized()
             /// TEMP DEBUG Change language to chinese
        //print(Localize.availableLanguages())
 
        ///
        super.viewDidLoad()
        print("google map load")
 
     
        map_view.myLocationEnabled = true
        
        let camera = GMSCameraPosition.cameraWithLatitude(22.626618,
                                                          longitude: 120.265746, zoom: 6)
        map_view.camera = camera
        
        
        
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
                    self.label_set_date.setTitle(" " + date_for.stringFromDate(self.start_date) + " (1日)", forState: UIControlState.Normal)
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
                    
                    self.label_set_date.setTitle(" " + date_for.stringFromDate(self.start_date) + " → " + date_for.stringFromDate(self.end_date)+" (\(self.date_play.count)日)", forState: UIControlState.Normal)

                }
                self.label_set_date.backgroundColor = UIColor(netHex:0x91F2CF)
           //     TSMessage.showNotificationInViewController(self, title: "very well".localized(), subtitle: "now you can design the ".localized() + String(self.date_play.count) + " days activity".localized(), type: TSMessageNotificationType.Success)
            
             
                
                
            }
           
        }
        
        
    }
    
    var start_lng = 0.0
    var start_lat = 0.0
    @IBAction func addr_finish(sender: UITextField) {
        let addr = sender.text
        if addr != ""
        {
            let se = Server()
            se.getlocation(addr!){(result) -> () in
                if result["status"].stringValue == "OK"
                {
                    let data:JSON = result["results"]
                   // print(data.count)
                    var choose_addr = [String]()
                    for i in 0 ..< data.count
                    {
                        
                        choose_addr.append(data[i]["formatted_address"].stringValue)
                    }
                    ActionSheetStringPicker.showPickerWithTitle("選擇一個最接近的地址", rows: choose_addr, initialSelection: 0, doneBlock:
                        {
                            picker,index,selectvalue in
                           // print(index)
                            let coord = data[index]["geometry"]["location"]
                            self.start_lat = coord["lat"].doubleValue
                            self.start_lng = coord["lng"].doubleValue
                            sender.text = choose_addr[index]
                            
                            let  position = CLLocationCoordinate2DMake( self.start_lat, self.start_lng)
                            let marker = GMSMarker(position: position)
                            marker.title = "集合點"
                            marker.map = self.map_view
                            let camera = GMSCameraPosition.cameraWithLatitude( self.start_lat,
                                longitude: self.start_lng, zoom: 15)
                            self.map_view.camera = camera
                            
                            return
                        }, cancelBlock: { (canc) in
                            return
                        }, origin: self.map_view as UIView)
                }
                else
                {
                    // google map encoding error
                }
            }
        }
        
    }
 

}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}


