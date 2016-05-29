import UIKit

class SlideViewController : UIViewController{
    

    @IBOutlet weak var OptionTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      //  OptionTable.registerNib(SlideOptionTable, forCellReuseIdentifier: <#T##String#>)
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
    
      
}
