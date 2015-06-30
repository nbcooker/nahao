

import UIKit

class ViewController: UIViewController ,HttpProtocol {
    
    //用户名
    @IBOutlet weak var name: UITextField!
    
    //密码
    @IBOutlet weak var pwd: UITextField!
    //存储用户基础数据
    var base: baseClass = baseClass()
    //封装的网络连接方法
    var eHttp: HttpController = HttpController()
    //提交按钮
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //点击提交按钮
    @IBAction func onSubmit(sender: AnyObject) {
        
        let tel = self.name.text
        let password = self.pwd.text
        
//        let tel = "15210674504"
//        let password = "123456"
        
        if (tel.isEmpty){ //isEmpty 是Swift中的判断是否为空的方法
            var alert = UIAlertView(title: "提示", message: "用户名为空", delegate: self, cancelButtonTitle: "确定")
            alert.show();
            return

        }
        if (password.isEmpty){ //isEmpty 是Swift中的判断是否为空的方法
            var alert1 = UIAlertView(title: "提示", message: "密码为空", delegate: self, cancelButtonTitle: "确定")
            alert1.show()
            return
        }
        

        let url = "http://www.eduvdev.com/api/checkLogin"
        let params = ["username" : tel , "password" : password]
        
        // self.performSegueWithIdentifier("login", sender: self) //直接跳转
        // 点击之后,先讲按钮disable,更改背景图片,防止多次点击
        loginBtn.setImage(UIImage(named: "login-off"), forState: UIControlState.Normal)
        loginBtn.enabled = false
        
        eHttp.post(url, params: params, callback: {(data: NSDictionary) -> Void in
    
                var status = data["status"] as! String
                var msg = data["msg"] as! String

                if(status == "error"){
                    //错误判断,弹出框错误提示
                    self.loginBtn.setImage(UIImage(named: "login"), forState: UIControlState.Normal)
                    self.loginBtn.enabled = true

                    let alertView = UIAlertView(title: "登录提示", message: msg, delegate: nil, cancelButtonTitle: "确定")
                    alertView.show()
                    return
                } else if(status == "ok") {
                    //存储cache
                    self.base.cacheSetString("sign", value: tel as String)
                    self.base.cacheSetNSDictionary("userinfos", value: data["data"] as! NSDictionary)
                    self.performSegueWithIdentifier("xx", sender: self)
                }

        })
    }
    
    //点击其他部位隐藏虚拟键盘
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        name.resignFirstResponder()
        pwd.resignFirstResponder()
    }
    
    //http返回函数
    func didRecieveResult(result: NSDictionary) {
        
    }

}

