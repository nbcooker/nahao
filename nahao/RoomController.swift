

import UIKit

//教室页面逻辑
class RoomController: UIViewController {

    //webView
    @IBOutlet weak var myWebView: UIWebView!
    
    var userinfos:NSDictionary = NSDictionary()
    var base : baseClass = baseClass()
    
    //临时变量
    var itemString:NSDictionary = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //println(itemString)
        self.userinfos = base.cacheGetNSDictionary("userinfos")
        
        var nickname = self.userinfos["username"] as! String
        
        //中文转码一下
        var escapedString = nickname.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)

        var room_url = itemString["studentJoinUrl"] as? String
        
        var room_urls = room_url! + "?nickname=" + escapedString!
      
        var urlobj = NSURL(string:room_urls)
        
        var request = NSURLRequest(URL:urlobj!)
        
        myWebView.loadRequest(request);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}