

import UIKit

class DetailController: UIViewController,UITableViewDataSource,UITableViewDelegate {


    
    @IBOutlet weak var d_tv: UITableView!
    
    var sign : String = ""
    var base : baseClass = baseClass()

    var d_tableData:NSArray = NSArray()
    

    
    //临时变量
    var itemString:NSDictionary = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = itemString["title"] as? String
        var course_id = itemString["id"] as? String
        self.sign = base.cacheGetString("sign")
        
        
        //println(self.userinfos)
        var class_url = "http://www.eduvdev.com/api/getClassList?username="+self.sign+"&course_id="+course_id!
        //var class_url = "http://www.eduvdev.com/api/getClassList?username=15210674504&course_id=12&nickname="+escapedString!
        //println(class_url)
        getList(class_url)
       // println(itemString)

        
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
        return cell
    }

    
    //请求数据
    func getList(url:String){
        println(url)
        let URL:NSURL=NSURL(string:url)!
        let request:NSURLRequest=NSURLRequest(URL: URL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
            
            var jsonResult:NSDictionary=NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary

            
            // if (jsonResult["data"] != nil) {
            if (jsonResult["data"] != nil) {
                self.d_tableData = jsonResult["data"] as! NSArray
                //println(self.d_tableData)
                //println(self.)
                self.d_tv.reloadData()
            }
            
        })
        
    }
    
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //self.tableView!.deselectRowAtIndexPath(indexPath, animated: true)
        var itemNSDictionary = self.d_tableData[indexPath.row] as! NSDictionary
        
        //println(itemNSDictionary)
        self.performSegueWithIdentifier("room", sender: itemNSDictionary)
    }
    
    //在这个方法中给新页面传递参数
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "room"{
            let controller = segue.destinationViewController as! RoomController
            //println(sender)
            var ss = sender as! NSDictionary
            //println(ss)
            controller.itemString = ss
        }
    }
}
