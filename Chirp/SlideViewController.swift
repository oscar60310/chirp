import UIKit

class SlideViewController : UIViewController,UITableViewDelegate,UITableViewDataSource{
    

    @IBOutlet weak var OptionTable: UITableView!
    var s_option = [SlideOption]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 左方選單內容
        self.s_option = [SlideOption(name: "create event".localized() , icon:"add.png"),SlideOption(name: "event list".localized() , icon:"note.png"),SlideOption(name: "chat room".localized() , icon:"chat.png"),SlideOption(name: "high light event".localized() , icon:"badge.png")]
        

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
      
}
