

import UIKit

//我的课节页面逻辑
class DetailController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //tableView
    @IBOutlet weak var d_tv: UITableView!
    
    var sign : String = ""
    var base : baseClass = baseClass()
    
    //tableView的数据
    var d_tableData:NSArray = NSArray()
    
    //临时变量
    var itemString:NSDictionary = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = itemString["title"] as? String
        var course_id = itemString["id"] as? String
        self.sign = base.cacheGetString("sign")
        
        var class_url = "http://www.17ske.com/api/getClassList?username="+self.sign+"&course_id="+course_id!
        getList(class_url)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return d_tableData.count
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "classList")
        let rowData:NSDictionary = self.d_tableData[indexPath.row] as! NSDictionary
        cell.textLabel?.text = (rowData["dates"] as! String) + "   " + (rowData["xinqi"] as! String)
        cell.detailTextLabel?.text = (rowData["start_time"] as! String) + "   " + (rowData["end_time"] as! String)
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }

    
    //请求数据
    func getList(url:String){
        let URL:NSURL=NSURL(string:url)!
        let request:NSURLRequest=NSURLRequest(URL: URL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
            
            var jsonResult:NSDictionary=NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            
            var status = jsonResult["status"] as! String
            var msg = jsonResult["msg"] as! String
            
            if (status == "ok") {
                self.d_tableData = jsonResult["data"] as! NSArray
                self.d_tv.reloadData()
            } else {
                let alertView = UIAlertView(title: "提示", message: msg, delegate: nil, cancelButtonTitle: "确定")
                alertView.show()
            }
            
        })
        
    }
    
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        var itemNSDictionary = self.d_tableData[indexPath.row] as! NSDictionary
        
        self.performSegueWithIdentifier("room", sender: itemNSDictionary)
    }
    
    //在这个方法中给新页面传递参数
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "room"{
            let controller = segue.destinationViewController as! RoomController
            var ss = sender as! NSDictionary
            controller.itemString = ss
        }
    }
}
