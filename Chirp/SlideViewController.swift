import UIKit

class SlideViewController : UIViewController{
    
    
    
    
    @IBAction func aas(sender: AnyObject) {
        
    }
    @IBOutlet weak var test: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
