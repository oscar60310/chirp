import UIKit

class SlideViewController : UIViewController,UITableViewDelegate,UITableViewDataSource{
    

    @IBOutlet weak var OptionTable: UITableView!
    var s_option = [SlideOption]()

    @IBOutlet weak var hellow: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 左方選單內容
        self.s_option = [SlideOption(name: "create event".localized() , icon:"add.png"),SlideOption(name: "event list".localized() , icon:"note.png"),SlideOption(name: "chat room".localized() , icon:"chat.png"),SlideOption(name: "high light event".localized() , icon:"badge.png"), SlideOption(name: "Logout".localized() , icon:"badge.png")]
        
       
        

    }
   
    
    override func viewDidAppear(animated: Bool) {
        let config = Config()
        let js = config.main_config_read() as JSON
     
        if js != nil
        {
            hellow.text = "hellow".localized() + "，" + js["first_name"].string!
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // 改變主畫面，並將選單收起
    func changeMainView(ViewName: String)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.slideMenuController()?.changeMainViewController(storyboard.instantiateViewControllerWithIdentifier(ViewName), close: false)
        self.slideMenuController()?.closeLeft()

    }
    
    // Return Options count
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.s_option.count
    }
    
    // return cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = self.OptionTable.dequeueReusableCellWithIdentifier("Cell_option") as! SlideOptionTable?
        
        
        var option : SlideOption
        option = s_option[indexPath.row]
        
        cell!.name_label.text = option.name
        cell!.icon.image = UIImage(named: option.icon)
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 4)
        {
            let refreshAlert = UIAlertController(title: "Logout", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                let config = Config()
                config.main_config_write("")
                self.slideMenuController()?.closeLeft()
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
               
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
            

        }
    }
      
}
