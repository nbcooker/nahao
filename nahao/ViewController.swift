

import UIKit

class ViewController: UIViewController,HttpProtocol {

    var eHttp:HttpController = HttpController()
    
    var tableData:NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        eHttp.delegate=self
        eHttp.onSearch("http://douban.fm/j/mine/playlist?channel=0")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didRecieveResults(results:NSDictionary) {
        //println(results)
      
        if (results["song"] != nil) {
            self.tableData = results["song"] as! NSArray
        }
    }

    @IBAction func onTap(sender: AnyObject) {

        
        let url = "http://douban.fm/j/mine/playlist?channel=0";
        let imgURL:NSURL=NSURL(string:url)!
        let request:NSURLRequest=NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in

            var jsonResult:NSDictionary=NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
//            println(jsonResult)
            
            if (jsonResult["song"] != nil) {
                self.tableData = jsonResult["song"] as! NSArray
                        let firDict:NSDictionary = self.tableData[0] as! NSDictionary
                        let aid:String = firDict["aid"] as! String
                        if(!aid.isEmpty) {
                            let alertView = UIAlertView(title: "alertview", message: "say hello", delegate: nil, cancelButtonTitle: "Cancle")
                            alertView.show()
                        } else{
                            println("444")
                        }
                
                
            }

        })
        

    
        
    }
}

