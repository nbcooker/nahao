

import Foundation


//工具类,放置一些经常用到的方法
//通过userDefault存储数据
class baseClass{
    
    func cacheSetString(key: String,value: String){
        var userInfo = NSUserDefaults()
        userInfo.setValue(value, forKey: key)
    }
    
    func cacheGetString(key: String) -> String{
        var userInfo = NSUserDefaults()
        var tmpSign = userInfo.stringForKey(key)
        return tmpSign!
    }
    
    //将用户数据写到字典中
    func cacheSetNSDictionary(key: String,value: NSDictionary){
        var userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(value, forKey: key)
    }
    
    //从字典中读取用户数据
    func cacheGetNSDictionary(key: String) -> NSDictionary{
        var userDefault = NSUserDefaults.standardUserDefaults()
        var temDictionary = userDefault.objectForKey(key) as! NSDictionary
        return temDictionary
    }
    
}
