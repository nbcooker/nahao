

import UIKit

class ViewController: UIViewController {
    
   
    
    @IBOutlet weak var pwd: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {

        
        let username = name.text
        let password = pwd.text
//        if (username.isEmpty){ //isEmpty 是Swift中的判断是否为空的方法
//            var alert = UIAlertView(title: "提示", message: "用户名为空", delegate: self, cancelButtonTitle: "确定")
//            alert.show();
//            return;
//           
//        }
//        if (password.isEmpty){ //isEmpty 是Swift中的判断是否为空的方法
//            var alert1 = UIAlertView(title: "提示", message: "密码为空", delegate: self, cancelButtonTitle: "确定")
//            alert1.show()
//            return
//        }
        let url = "http://admin.gitci.com/login/checkLogin?username=\(username)&password=\(password)";
        let imgURL:NSURL=NSURL(string:url)!
        let request:NSURLRequest=NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in

            var jsonResult:NSDictionary=NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            
            var status = jsonResult["status"] as! String
            var msg = jsonResult["msg"] as! String
            
            if(status == "error"){
            
//                let alertView = UIAlertView(title: "登录提示", message: msg, delegate: nil, cancelButtonTitle: "确定")
//                alertView.show()
//                return
                self.performSegueWithIdentifier("xx", sender: self)
            } else if(status == "ok") {
                self.performSegueWithIdentifier("xx", sender: self)
            }

        })
        
    }
    
    
    //页面传值
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! NewController
        vc.username_vale = name.text
    }

}

