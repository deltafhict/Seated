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
	var testData = [Room]()
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		self.testData += [
			Room("4.11", amount: 8, occupied: true),
			Room("4.22", amount: 6),
			Room("4.34A", amount: 6),
			Room("4.34B", amount: 6, occupied: true),
			Room("4.105", amount: 6),
			Room("4.106", amount: 6)]
		
		self.tableView.estimatedRowHeight = 70
		self.tableView.rowHeight = UITableViewAutomaticDimension
		
		let refresh = UIRefreshControl()
		refresh.addTarget(self, action: Selector("refresh"), forControlEvents: .ValueChanged)
		
		self.refreshControl = refresh
		
		let req = Request(delegate: self)
		req.get(request: "clientLocation.php", withParams: ["":""])
		
		self.sortRooms()
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
        return self.testData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
        let cell = tableView.dequeueReusableCellWithIdentifier("default", forIndexPath: indexPath) as! RoomTableViewCell
		cell.errorLabel.hidden = true
		
        // Configure the cell...
		cell.delegate = self
		let room = self.testData[indexPath.row]
		
		cell.room = room
		
		cell.roomLabel.text = room.code
		
		if room.occupied && !room.occupiedByMe
		{
			cell.roomSwitch.enabled = !room.occupied
			cell.roomSwitch.on = false
			
			cell.circleView.image = UIImage(named: "circle_red")
			cell.amountView.image = UIImage(named: "person-full\(room.amount)")
		}
		else if room.occupied && room.occupiedByMe
		{
			cell.roomSwitch.on = true
			
			cell.circleView.image = UIImage(named: "circle_red")
			cell.amountView.image = UIImage(named: "person-full\(room.amount)")
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
		if let _location = json["WirelessClientLocation"] as? NSDictionary
		{
			if let _mapInfo = _location["MapInfo"] as? NSDictionary
			{
				if let _locationString = _mapInfo["mapHierarchyString"] as? String
				{
					println("Je bevindt je nu in \(_locationString)")
				}
			}
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
	
	// MARK: - Occupy delegate
	func releaseRooms(occupiedRoom room: Room, released: Bool)
	{
		for room in self.testData
		{
			if room.occupiedByMe
			{
				room.occupiedByMe = false
				room.occupied = false
			}
		}
		
		room.occupied = !released
		room.occupiedByMe = !released
		
		self.sortRooms()
	}
	
	// MARK: - Refresh handling
	func refresh()
	{
		println("Refreshing...")
		self.sortRooms()
		self.refreshControl?.endRefreshing()
	}
	
	// MARK: - Methods
	func sortRooms()
	{
		self.testData.sort({ $0.code.lowercaseString < $1.code.lowercaseString })
		self.testData.sort({ !$0.occupied && $1.occupied })
		
		self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
		
		//self.tableView.reloadData()
	}
}