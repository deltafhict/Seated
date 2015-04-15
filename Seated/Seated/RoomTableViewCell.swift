//
//  RoomTableViewCell.swift
//  Seated
//
//  Created by Bas on 14/04/2015.
//  Copyright (c) 2015 Bas. All rights reserved.
//

import UIKit
import SeatedKit

protocol OccupyDelegate
{
	func releaseRooms(occupiedRoom room: Room, released: Bool)
}

class RoomTableViewCell: UITableViewCell
{
	@IBOutlet weak var roomLabel: UILabel!
	@IBOutlet weak var roomSwitch: UISwitch!
	@IBOutlet weak var amountView: UIImageView!
	@IBOutlet weak var circleView: UIImageView!
	@IBOutlet weak var errorLabel: UILabel!
	
	var room: Room?
	
	var delegate: OccupyDelegate?
	
    override func awakeFromNib()
	{
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
	{
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	@IBAction func switchValueChanged(sender: AnyObject)
	{
		let roomSwitch = sender as! UISwitch
		
		if let room = room
		{
			room.occupied = roomSwitch.on
			
			if room.occupied
			{
				room.occupiedByMe = "306880@student.fontys.nl"
			}
			else
			{
				room.occupiedByMe = nil
			}
			
			self.delegate?.releaseRooms(occupiedRoom: room, released: !room.occupied)
		}
	}
}