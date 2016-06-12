import UIKit

class SlideViewController : UIViewController,UITableViewDelegate,UITableViewDataSource{
    

    @IBOutlet weak var OptionTable: UITableView!
    var s_option = [SlideOption]()

    @IBOutlet weak var hellow: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 左方選單內容
        self.s_option = [SlideOption(name:"home".localized(),icon:"home.png"),
                         SlideOption(name:"event".localized(),icon: "-"),
                         SlideOption(name: "create event".localized() , icon:"add.png"),
                         SlideOption(name: "event list".localized() , icon:"note.png"),
                         SlideOption(name: "chat room".localized() , icon:"chat.png"),
                         SlideOption(name: "high light event".localized() , icon:"badge.png"),
                         SlideOption(name:"abuot".localized(),icon: "-") ,
                         SlideOption(name: "profile".localized() , icon:"about-us.png"),
                         SlideOption(name: "about app".localized() , icon:"about-app.png"),
                         SlideOption(name: "content us".localized() , icon:"phone-receiver.png"),
                         SlideOption(name: "setting".localized() , icon:"-"),
                         SlideOption(name: "Logout".localized() , icon:"sign-out-option.png")]
        
       
        

    }
      override func viewDidAppear(animated: Bool) {
        let cfg = Config(views: self)
     
        if(cfg.token_config_read() == "")
        {
            debugPrint("to login page")
            let loginStorg: UIStoryboard = UIStoryboard(name: "Login",bundle: nil)
            let vc = loginStorg.instantiateViewControllerWithIdentifier("WelcomePage") as! WelcomeViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        else
        {
            let se = Server()
            se.get_profile(cfg.token_config_read(), view: self){ (result) -> () in
             print(result)
                if result == "200"
                {
                    let profile = cfg.main_config_read()
                
                  //  print(profile)
                    let first_name = profile["first_name"]
                    self.change_hellow(first_name.stringValue)
                    
                }
                else if result == "403"
                {
                    
                    cfg.token_config_write("")
                    let loginStorg: UIStoryboard = UIStoryboard(name: "Login",bundle: nil)
                    let vc = loginStorg.instantiateViewControllerWithIdentifier("WelcomePage") as! WelcomeViewController
                    self.presentViewController(vc, animated: true, completion: nil)
                    
                    TSMessage.showNotificationInViewController(vc, title: "re login title".localized(), subtitle: "re login".localized(), type: TSMessageNotificationType.Warning)
            

                    
                }
                else
                {
                 
                    /*
                     
                     網路錯誤
                     */
                }
                
                
            }
            
            
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
        var option : SlideOption
        option = s_option[indexPath.row]
        if (option.icon == "-")
        {
            let cell = self.OptionTable.dequeueReusableCellWithIdentifier("tags") as! SlideOptionTags?
           

            cell!.tag_name.text = option.name
            return cell!
        }
        else
        {
            let cell = self.OptionTable.dequeueReusableCellWithIdentifier("Cell_option") as! SlideOptionTable?
        
            cell!.name_label.text = option.name
            cell!.icon.image = UIImage(named: option.icon)
            return cell!
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 11)
        {
            let refreshAlert = UIAlertController(title: "Logout".localized(), message: "All data will be lost.".localized(), preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                let config = Config(views: self)
                config.token_config_write("")
                self.slideMenuController()?.closeLeft()
                let loginStorg: UIStoryboard = UIStoryboard(name: "Login",bundle: nil)
                let vc = loginStorg.instantiateViewControllerWithIdentifier("WelcomePage") as! WelcomeViewController
                self.presentViewController(vc, animated: true, completion: nil)
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
               
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)

        }
        else if indexPath.row == 2
        {
             let create_con = self.storyboard?.instantiateViewControllerWithIdentifier("create")
             self.slideMenuController()?.changeMainViewController(create_con!,close: true)
        }
        else if indexPath.row == 3
        {
            
            let storyboard = UIStoryboard(name: "Event", bundle: nil)
            let create_con = storyboard.instantiateViewControllerWithIdentifier("eventdetail")
            self.slideMenuController()?.changeMainViewController(create_con,close: true)
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var option : SlideOption
        option = s_option[indexPath.row]
        if (option.icon == "-")
        {
            return 30
        }
        else
        {
           return 50
        }
    }
    func change_hellow(name: String)
    {
         hellow.text = "hellow".localized() + "，" + name
    }
      
}
