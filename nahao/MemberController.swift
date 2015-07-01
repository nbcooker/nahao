
import UIKit

//个人中心页面逻辑
class MemberController: UIViewController {

    
    @IBOutlet weak var m_laber: UILabel!
    
    var userinfos:NSDictionary = NSDictionary()
    var base : baseClass = baseClass()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.userinfos = base.cacheGetNSDictionary("userinfos")
        
        var nickname = self.userinfos["username"] as! String
        self.m_laber.text = "你好," + nickname
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}