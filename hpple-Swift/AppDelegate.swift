//
//  AppDelegate.swift
//  hpple-Swift
//
//  Created by Jiangzhou on 14/6/9.
//  Copyright (c) 2014年 Petta.mobi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // Override point for customization after application launch.
        
        
        var aaa = "aaa"
        var aa : String = "123123"
        var  queryString : CString = "3333".cStringUsingEncoding(NSUTF8StringEncoding)
//        var queryPointer : CMutablePointer<CString> =  &queryString
//        var t1: UnsafePointer<CString> = UnsafePointer<CString>(queryPointer)
        var t : UnsafePointer<xmlChar> = UnsafePointer<xmlChar>(queryString._bytesPtr)
        
        var cc = String.fromCString(CString(t))

        
//        var data = "123".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
//        var ccharstr = CChar[](count:data.length, repeatedValue:CChar(0))
//        
//        data.getBytes(&ccharstr, length:data.length)
//        
//        ccharstr.append(CChar(0))
//
//        var t3: UnsafePointer<CChar> = UnsafePointer<CChar>(&ccharstr)
//        var ccc = String.fromCString(t3)
//        
//        print(ccc)
        
        print(t.description)
        
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
    }


}

