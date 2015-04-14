//
//  BuildingTableViewController.swift
//  Seated
//
//  Created by Bas on 14/04/2015.
//  Copyright (c) 2015 Bas. All rights reserved.
//

import UIKit
import SeatedKit

class BuildingTableViewController: UITableViewController, RequestDelegate
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
    }

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
        // Return the number of rows in the section.
        return self.testData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
        let cell = tableView.dequeueReusableCellWithIdentifier("default", forIndexPath: indexPath) as! RoomTableViewCell

        // Configure the cell...
		let room = self.testData[indexPath.row]
		
		cell.room = room
		
		cell.roomLabel.text = room.code
		
		cell.roomSwitch.enabled = !room.occupied

        return cell
    }
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
	{
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
	{
        if editingStyle == .Delete
		{
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
		else if editingStyle == .Insert
		{
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath)
	{

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool
	{
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
	
	// MARK: - Request delegate
	func handleJSON(json: NSDictionary, forRequest request: String, withParams params: [String : String])
	{
		println("Handling JSON: \(json)")
	}
	
	func handleError(error: NSError)
	{
		println("Handling error: \(error.localizedDescription)")
	}
	
	func handleActionFeedback(forMethod method: String)
	{
		println("Handling action feedback for method \(method)")
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
}