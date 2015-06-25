
import UIKit

class NewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tv: UITableView!

    @IBOutlet weak var username: UITextField!
    
     var tableData:NSArray = NSArray()
    var imageCache = Dictionary<String,UIImage>()
    
    var username_vale = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.username.text = self.username_vale
        getClassList("http://douban.fm/j/mine/playlist?channel=1")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "classlist")
        let rowData:NSDictionary = self.tableData[indexPath.row] as! NSDictionary
        //println(rowData)
        cell.textLabel?.text = rowData["title"] as? String
        cell.detailTextLabel?.text = rowData["artist"] as? String
        cell.imageView?.image = UIImage(named:"detail.jpg")
        let url = rowData["picture"] as! String
        //let image = self.imageCache[url] as?UIImage
        let image = self.imageCache[url]
        if (image == nil){
            let imgURL:NSURL=NSURL(string:url)!
            let request:NSURLRequest=NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
                var img=UIImage(data:data)
                cell.imageView?.image=img
                self.imageCache[url]=img
            })
        }else{
            cell.imageView?.image=image
        }

        return cell
    }
    //请求数据
    func getClassList(url:String){
        //let url = "http://admin.gitci.com/login/checkLogin?username=\(username)&password=\(password)";
        let URL:NSURL=NSURL(string:url)!
        let request:NSURLRequest=NSURLRequest(URL: URL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
            
            var jsonResult:NSDictionary=NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            
            //println(jsonResult)
            if (jsonResult["song"] != nil) {
                self.tableData = jsonResult["song"] as! NSArray
                //println(self.tableData)
                self.tv.reloadData()
                
            } 
            
             })
    
    }

//    //点击单元格返回到上一个view
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var rowData:NSDictionary = self.channelData[indexPath.row] as! NSDictionary
//        //        let channel_id:AnyObject = rowData["channel_id"] as AnyObject
//        //        let channel_id:String = "channel=\(channel_id)"
//        
//        let channel_id:AnyObject=rowData["channel_id"] as AnyObject!
//        let channel:String="channel=\(channel_id)"
//        delegate?.onChangeChannel(channel)
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
    
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //self.tableView!.deselectRowAtIndexPath(indexPath, animated: true)
        var itemNSDictionary = self.tableData[indexPath.row] as! NSDictionary

        
        self.performSegueWithIdentifier("ShowDetailView", sender: itemNSDictionary)
    }
    
    //在这个方法中给新页面传递参数
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetailView"{
            let controller = segue.destinationViewController as! DetailController
          //println(sender)
            var ss = sender as! NSDictionary
            //println(ss)
        controller.itemString = ss 
        }
    }

}