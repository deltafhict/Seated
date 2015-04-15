//
//  Building.swift
//  Seated
//
//  Created by Bas on 15/04/2015.
//  Copyright (c) 2015 Bas. All rights reserved.
//

import UIKit

public class Building
{
	public var name: String
	public var rooms = [Room]()
	
	public init(_ name: String)
	{
		self.name = name
	}
	
	public func addRoom(room: Room)
	{
		self.rooms.append(room)
	}
}
