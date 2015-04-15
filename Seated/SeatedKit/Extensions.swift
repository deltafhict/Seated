//
//  Extensions.swift
//  Seated
//
//  Created by Bas on 14/04/2015.
//  Copyright (c) 2015 Bas. All rights reserved.
//

import UIKit

extension UIColor
{
	public class func seatedColor() -> UIColor
	{
		return UIColor(red: 0.204, green: 0.596, blue: 0.859, alpha: 1)
	}
}

extension Int
{
	public func toBool() -> Bool?
	{
		switch(self)
		{
			case 0:
				return false
				
			case 1:
				return true
				
			default:
				return nil
		}
	}
}