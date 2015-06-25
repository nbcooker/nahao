

import UIKit

class DetailController: UIViewController {


    
    @IBOutlet weak var ul1: UILabel!
    
    @IBOutlet weak var ul2: UILabel!
    
    var itemString:NSDictionary = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println(itemString)
        ul1.text = itemString["title"] as? String
       ul2.text = itemString["artist"] as? String
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
