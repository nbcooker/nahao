
import UIKit

class ListController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    //tableview
    @IBOutlet weak var tv: UITableView!
    //用户名
    @IBOutlet weak var laber_username: UILabel!
    //网络请求的数据 保存在该数组中
    var tableData:NSArray = NSArray()
    //图片缓存该字典中
    var imageCache = Dictionary<String,UIImage>()
    //用户公共信息
    var base: baseClass = baseClass()
    //封装的网络连接方法
    var eHttp: HttpController = HttpController()
    //临时变量
    var sign: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sign = base.cacheGetString("sign")
        self.laber_username.text = "你好," + self.sign
        var courseList = "http://www.eduvtest.com/api/getCourseList?username="+self.sign
        getList(courseList)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "courseList")
//        let rowData:NSDictionary = self.tableData[indexPath.row] as! NSDictionary
//        cell.textLabel?.text = rowData["title"] as? String
//        //cell.detailTextLabel?.text = rowData["description"] as? String
//        
//        cell.imageView?.image = UIImage(named:"detail.jpg")
//        var url = rowData["image"] as! String
//        let image = self.imageCache[url]
//        if (image == nil){
//            
//            let imgURL:NSURL=NSURL(string:url)!
//            
//            let request:NSURLRequest=NSURLRequest(URL: imgURL)
//            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
//
//                var img=UIImage(data:data)
//                cell.imageView?.image=img
//                self.imageCache[url]=img
//            })
//        }else{
//            cell.imageView?.image=image
//        }
//
//        return cell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("courseList", forIndexPath: indexPath) as! UITableViewCell
        let rowData:NSDictionary = self.tableData[indexPath.row] as! NSDictionary
        var courseImg = cell.viewWithTag(101) as! UIImageView
        var courseTitle = cell.viewWithTag(102) as! UILabel
        courseImg.image = UIImage(named:"detail.jpg")
        courseTitle.text = rowData["title"] as? String
        
        var url = rowData["image"] as! String
        let image = self.imageCache[url]
        if (image == nil){
            
            let imgURL:NSURL=NSURL(string:url)!
            
            let request:NSURLRequest=NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
                
                var img=UIImage(data:data)
                courseImg.image=img
                self.imageCache[url]=img
            })
        }else{
            courseImg.image=image
        }
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
                self.tableData = jsonResult["data"] as! NSArray
                self.tv.reloadData()
            } else {
                let alertView = UIAlertView(title: "提示", message: msg, delegate: nil, cancelButtonTitle: "确定")
                alertView.show()
            }
            
        })
    
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        var itemNSDictionary = self.tableData[indexPath.row] as! NSDictionary
        self.performSegueWithIdentifier("ShowDetail", sender: itemNSDictionary)
    }
    
    //在这个方法中给新页面传递参数
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail"{
            let controller = segue.destinationViewController as! DetailController
            var ss = sender as! NSDictionary
            controller.itemString = ss
        }
    }

}
