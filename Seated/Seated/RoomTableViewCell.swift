//
//  RoomTableViewCell.swift
//  Seated
//
//  Created by Bas on 14/04/2015.
//  Copyright (c) 2015 Bas. All rights reserved.
//

import UIKit
import SeatedKit

class RoomTableViewCell: UITableViewCell
{
	@IBOutlet weak var roomLabel: UILabel!
	@IBOutlet weak var roomSwitch: UISwitch!
	
	var room: Room?
	
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
		println("The switch value changed to \(roomSwitch.on) for room \(room?.code)")
	}
}