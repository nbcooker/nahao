

import UIKit

class RoomController: UIViewController {

    
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
        
        var escapedString = nickname.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)

        var room_url = itemString["studentJoinUrl"] as? String
        
        var room_urls = room_url! + "?nickname=dd" //+ escapedString!
        //var room_urls = "http://www.baidu.com/s?wd=dd"
        //println(room_urls)
        
        var urlobj = NSURL(string:room_urls)
        
        var request = NSURLRequest(URL:urlobj!)
        
        myWebView.loadRequest(request);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}