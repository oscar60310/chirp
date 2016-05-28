import UIKit

class CreateViewController : UIViewController{
    
    

   
        @IBOutlet weak var NavBar: UINavigationBar!
     // 上方標題
    
    
    @IBAction func openSlide(sender: AnyObject) {
        self.slideMenuController()?.openLeft()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// TEMP DEBUG Change language to chinese
        //print(Localize.availableLanguages())
        Localize.setCurrentLanguage("zh-Hant")
        ///
        NavBar.topItem?.title = "create event".localized()
        
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

