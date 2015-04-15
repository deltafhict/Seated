//
//  BuildingTableViewController.swift
//  Seated
//
//  Created by Bas on 14/04/2015.
//  Copyright (c) 2015 Bas. All rights reserved.
//

import UIKit
import SeatedKit

class BuildingTableViewController: UITableViewController, RequestDelegate, OccupyDelegate
{
	var buildings = [Building]()
	var rooms = [Room]()
	
	let email = "306880@student.fontys.nl"
	
	var currentFloor: String?
	{
		didSet
		{
			self.getRooms()
		}
	}
	
	var currentBuilding: String?
	{
		didSet
		{
			self.navigationItem.title = "\(self.currentBuilding!)"
		}
	}
	
	//var testData = [Room]()
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		/*self.testData += [
			Room("4.11", amount: 8, occupied: true),
			Room("4.22", amount: 6),
			Room("4.34A", amount: 6),
			Room("4.34B", amount: 6, occupied: true),
			Room("4.105", amount: 6),
			Room("4.106", amount: 6)]*/
		
		self.tableView.estimatedRowHeight = 70
		self.tableView.rowHeight = UITableViewAutomaticDimension
		
		let refresh = UIRefreshControl()
		refresh.addTarget(self, action: Selector("refresh"), forControlEvents: .ValueChanged)
		
		self.refreshControl = refresh
		
		let req = Request(delegate: self)
		req.get(request: "clientLocation.php", withParams: ["":""])
		
		self.sortRooms()
		
		let defaults = NSUserDefaults.standardUserDefaults()
		
		var startedAmount = defaults.integerForKey("startAmount")
		
		if startedAmount != 0
		{
			if startedAmount % 10 == 0 && startedAmount < 30
			{
				let alert = UIAlertController(title: "Heeft de app je geholpen?", message: "We kunnen je input goed gebruiken.", preferredStyle: .Alert)
				alert.addAction(UIAlertAction(title: "Ja :-)", style: .Default, handler: nil))
				alert.addAction(UIAlertAction(title: "Nee :-(", style: .Default, handler: nil))
				
				self.presentViewController(alert, animated: true, completion: nil)
			}
			else
			{
				println("startedAmount mod 10 = \(startedAmount % 10)")
			}
		}
    }

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
        return self.rooms.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
        let cell = tableView.dequeueReusableCellWithIdentifier("default", forIndexPath: indexPath) as! RoomTableViewCell
		cell.errorLabel.hidden = true
		
        // Configure the cell...
		cell.delegate = self
		let room = self.rooms[indexPath.row]
		
		cell.room = room
		
		cell.roomLabel.text = room.code
		
		if room.occupied && room.occupiedByMe != nil
		{
			cell.roomSwitch.enabled = !room.occupied
			cell.roomSwitch.on = false
			
			cell.circleView.image = UIImage(named: "circle_red")
			cell.amountView.image = UIImage(named: "person-full\(room.amount)") ?? UIImage(named: "person-fill_u")
		}
		else if room.occupied && room.occupiedByMe == nil
		{
			cell.roomSwitch.on = true
			cell.roomSwitch.enabled = true
			
			cell.circleView.image = UIImage(named: "circle_red")
			cell.amountView.image = UIImage(named: "person-full\(room.amount)") ?? UIImage(named: "person-fill_u")
		}
		else
		{
			cell.roomSwitch.on = false
			cell.roomSwitch.enabled = true
			
			cell.circleView.image = UIImage(named: "circle")
			cell.amountView.image = UIImage(named: "person\(room.amount)") ?? UIImage(named: "person_u")
		}

        return cell
    }
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
	{
		return 70.0
	}
	
	// MARK: - Request delegate
	func handleJSON(json: NSDictionary, forRequest request: String, withParams params: [String : String])
	{
		switch(request)
		{
			case "clientLocation.php":
				self.setClientLocation(json)
			
			case "getRooms.php":
				self.setupRooms(json)
			
			default:
				return
		}
	}
	
	func handleError(error: NSError)
	{
		println("Handling error: \(error.localizedDescription)")
	}
	
	func handleActionFeedback(forMethod method: String)
	{
		println("Handling action feedback for method \(method)")
	}
	
	// MARK: - Request dispatch
	func setClientLocation(json: NSDictionary)
	{
		if let _location = json["WirelessClientLocation"] as? NSDictionary
		{
			if let _mapInfo = _location["MapInfo"] as? NSDictionary
			{
				if let _locationString = _mapInfo["mapHierarchyString"] as? String
				{
					let splitted = _locationString.componentsSeparatedByString(">")
					
					self.currentBuilding = splitted[1]
					
					self.currentFloor = splitted.last
					println("currentFloor: \(self.currentFloor)")
				}
			}
		}
	}
	
	func setupRooms(json: NSDictionary)
	{
		if let _buildings = json["Buildings"] as? NSArray
		{
			for building in _buildings
			{
				if let _name = building["name"] as? String
				{
					let building = Building(_name)
					
					self.buildings.append(building)
				}
				
				if let _floors = building["floors"] as? NSArray
				{
					for floor in _floors
					{
						if let _rooms = floor["rooms"] as? NSArray
						{
							if _rooms.count > 0
							{
								self.rooms = [Room]()
								
								for room in _rooms
								{
									var code: String!
									var amount: Int!
									var occupied: Bool!
									
									if let _code = room["lokaal"] as? String
									{
										code = _code
									}
									
									if let _amount = room["personen"] as? String
									{
										amount = _amount.toInt()
									}
									
									if let _occupied = room["gereserveerd"] as? String
									{
										occupied = _occupied.toInt()?.toBool()
									}
									
									if code != nil && amount != nil && occupied != nil
									{
										let room = Room(code, amount: amount, occupied: occupied)
										
										self.rooms.append(room)
									}
								}
							}
						}
					}
				}
			}
		}
		
		self.sortRooms()
	}
	
	// MARK: - Occupy delegate
	func releaseRooms(occupiedRoom room: Room, released: Bool)
	{
		for room in self.rooms
		{
			if room.occupiedByMe != nil
			{
				room.occupiedByMe = nil
				room.occupied = false
			}
		}
		
		room.occupied = !released
		room.occupiedByMe = released ? self.email : nil
		
		if room.occupiedByMe != nil
		{
			self.checkIn(room)
		}
		else
		{
			self.checkOut(room)
		}
		
		self.sortRooms()
	}
	
	// MARK: - Refresh handling
	func refresh()
	{
		self.getRooms()
	}
	
	// MARK: - Methods
	func sortRooms()
	{
		self.refreshControl?.endRefreshing()
		
		self.rooms.sort({ $0.code.lowercaseString < $1.code.lowercaseString })
		self.rooms.sort({ !$0.occupied && $1.occupied })
		
		self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
	}
	
	func getRooms()
	{
		let irisReq = Request(delegate: self, baseString: "http://i300486.iris.fhict.nl/Seated/")
		irisReq.get(request: "getRooms.php", withParams: ["":""])
	}
	
	func checkIn(room: Room)
	{
		let irisReq = Request(delegate: self, baseString: "http://i300486.iris.fhict.nl/Seated/")
		irisReq.post(request: "checkin.php", withParams: ["email":self.email, "gebouw":self.currentBuilding!, "lokaal":room.code])
	}
	
	func checkOut(room: Room)
	{
		let irisReq = Request(delegate: self, baseString: "http://i300486.iris.fhict.nl/Seated/")
		irisReq.post(request: "checkout.php", withParams: ["email":self.email, "gebouw":self.currentBuilding!, "lokaal":room.code])
	}
}