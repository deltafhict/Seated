//
//  AppDelegate.swift
//  Seated
//
//  Created by Bas on 14/04/2015.
//  Copyright (c) 2015 Bas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
	var window: UIWindow?

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
	{
		// Override point for customization after application launch.
		
		// FIXME: Below is a workaround for non-working selected images in a tab bar via the storyboard.
		self.selectedImagesWorkaround()
		
		//defaults.setInteger(0, forKey: "startAmount")
		
		let defaults = NSUserDefaults.standardUserDefaults()
		let startedAmount = defaults.integerForKey("startAmount")
		
		defaults.setInteger((startedAmount + 1), forKey: "startAmount")
		
		return true
	}

	func applicationWillResignActive(application: UIApplication)
	{
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication)
	{
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication)
	{
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication)
	{
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(application: UIApplication)
	{
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
}

extension AppDelegate
{
	func selectedImagesWorkaround()
	{
		let tabBarController = self.window?.rootViewController as? SeatedTabBarController
		
		let r1 = tabBarController?.tabBar.items![0] as? UITabBarItem
		r1!.selectedImage = UIImage(named: "r1_sel")
		
		let r3 = tabBarController?.tabBar.items![1] as? UITabBarItem
		r3!.selectedImage = UIImage(named: "r3_sel")
		
		let r4 = tabBarController?.tabBar.items![2] as? UITabBarItem
		r4!.selectedImage = UIImage(named: "r4_sel")
		
		let r5 = tabBarController?.tabBar.items![3] as? UITabBarItem
		r5!.selectedImage = UIImage(named: "r5_sel")
	}
}