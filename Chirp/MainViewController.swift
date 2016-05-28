import UIKit

class MainViewController : ViewController{
    
    
    @IBOutlet weak var sss: UILabel!
    // 這裡複寫awakeFromeNib
    override func awakeFromNib() {
        
        sss.text = "test"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

