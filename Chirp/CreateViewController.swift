import UIKit
import Material
class CreateViewController : UIViewController{
    
     // 上方標題
    
    
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
        
        /// TEMP DEBUG Change language to chinese
        //print(Localize.availableLanguages())
 
        ///
      
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        event_name_input.font = RobotoFont.mediumWithSize(20)
        label_event_name.text = "event name".localized()
        event_name_input.textAlignment = NSTextAlignment.Center
     
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // 開啟側邊選單
    
    @IBAction func openleft(sender: AnyObject) {
        self.slideMenuController()?.openLeft()
    }

    
    
    
}

