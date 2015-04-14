//
//  SeatedTabBarController.swift
//  Seated
//
//  Created by Bas on 14/04/2015.
//  Copyright (c) 2015 Bas. All rights reserved.
//

import UIKit
import SeatedKit

class SeatedTabBarController: UITabBarController
{
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		
		UITabBar.appearance().tintColor = .seatedColor()
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
