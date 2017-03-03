//
//  AppDelegate.swift
//  RCIM
//
//  Created by yh on 16/4/20.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,RCIMUserInfoDataSource{

    var window: UIWindow?
    var iconLingDa = "http://pic.baike.soso.com/p/20090711/20090711101754-314944703.jpg"
    var iconLingDaSuper = "http://pic.baike.soso.com/p/20090711/20090711100446-226055609.jpg"
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        /*
         {"code":200,"userId":"lingda","token":"XTyALWoAFrTKskqkgPhvmGnJoliatGpQ1nGgbRwX7LdzEDmZQ10/dDncbfzzIuy/ufrRwdl0i8LbZTolxT2Kkw=="}
        "http://pic.baike.soso.com/p/20090711/20090711101754-314944703.jpg"
         {"code":200,"userId":"lingdasuper","token":"hapNuych8fvgDt24QgWJBGnJoliatGpQ1nGgbRwX7LdzEDmZQ10/dEaf4DgLyXqaPi87O/VN/nIzHahy+RCyRPsq9C5oQvkp"}
        "http://pic.baike.soso.com/p/20090711/20090711100446-226055609.jpg"
         
        appkey : ik1qhw091mnsp  appsecret : zSz3dvCS1wWBgr
         
        */
         setTinColor()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ld.RCIM.RCIM" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("RCIM", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    //MARK: - 注册融云
    func registerRCIM(complete:()->Void){
        //初始化
        RCIM.sharedRCIM().initWithAppKey("ik1qhw091mnsp")
        //设置数据源
        RCIM.sharedRCIM().userInfoDataSource = self
        //连接
        RCIM.sharedRCIM().connectWithToken("XTyALWoAFrTKskqkgPhvmGnJoliatGpQ1nGgbRwX7LdzEDmZQ10/dDncbfzzIuy/ufrRwdl0i8LbZTolxT2Kkw==", success: { (success) in
            //这个应该是用来保存当前用户信息的吧，便于以后取出
            let userInfo = RCUserInfo(userId: "lingda",name: "令达",portrait: self.iconLingDa)
            RCIM.sharedRCIM().currentUserInfo = userInfo
            print("连接成功")
            complete()
            }, error: { (error) in
                print("连接失败\(error)")
        }) {
            print("token错误或者失效")
        }

    }
    
    // MARK: - 融云的代理方法
    /*当聊天界面没有对话时，第一次显示各自对话会各自调用一次
     怎么理解呢？
     因为融云要知道头像和名字，所以会在第一次显示时调用一次
     */
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        let userinfo = RCUserInfo()
        userinfo.userId = userId
        switch userId {
        case "lingda":
            userinfo.name = "令达"
            userinfo.portraitUri = iconLingDa
        case "lingdasuper":
            userinfo.name = "令达super"
            userinfo.portraitUri = iconLingDaSuper
        default:
            print("什么都没有")
        }
        completion(userinfo)
        
    }
    
    // MARK: - 设置主题颜色
    func setTinColor(){
        //配置主题颜色
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    }
}


