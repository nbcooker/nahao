
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
//        getClassList("http://douban.fm/j/mine/playlist?channel=1")
        var courseList = "http://www.eduvdev.com/api/getCourseList?username="+self.sign
        getClassList(courseList)
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
        //cell.detailTextLabel?.text = rowData["description"] as? String
        cell.imageView?.image = UIImage(named:"detail.jpg")
        var url = rowData["image"] as! String
    
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
        let URL:NSURL=NSURL(string:url)!
        let request:NSURLRequest=NSURLRequest(URL: URL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
            
            var jsonResult:NSDictionary=NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            
//                println(jsonResult)
//                if (jsonResult["song"] != nil) {
//                    self.tableData = jsonResult["song"] as! NSArray
//                    //println(self.tableData)
//                    self.tv.reloadData()
//                    
//                } 
            if (jsonResult["data"] != nil) {
                self.tableData = jsonResult["data"] as! NSArray
                //println(self.tableData)
                self.tv.reloadData()
            }
            
        })
    
    }


    
    
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