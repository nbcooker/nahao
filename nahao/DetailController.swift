

import UIKit

class DetailController: UIViewController {


    
    @IBOutlet weak var uimage: UIImageView!
   
    
    //临时变量
    var itemString:NSDictionary = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println(itemString)
    
        navigationItem.title = itemString["title"] as? String
        
        
        // 图片地址
        
        let strUrl = itemString["image"] as? String
        
        //url
        
        let url = NSURL(string: strUrl!)
        
        //图片数据
        
        var data = NSData(contentsOfURL:url!)
        
        //通过得到图片数据来加载
        
        let image = UIImage(data: data!)
        
        //把加载到的图片丢给imageView的image现实
        
        uimage.image = image
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
