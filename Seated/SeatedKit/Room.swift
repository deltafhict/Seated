//
//  Room.swift
//  Seated
//
//  Created by Bas on 14/04/2015.
//  Copyright (c) 2015 Bas. All rights reserved.
//

import UIKit

public class Room
{
	public var code: String
	public var amount: Int
	public var occupied: Bool
	
	public init(_ code: String, amount: Int, occupied: Bool = false)
	{
		self.code = code
		self.amount = amount
		
		self.occupied = occupied
	}
}
