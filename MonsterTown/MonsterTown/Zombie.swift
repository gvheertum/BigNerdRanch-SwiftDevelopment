//
//  Zombie.swift
//  MonsterTown
//
//  Created by Gertjan on 28/08/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import Foundation
class Zombie : Monster
{
	var limping: Bool = true;
	//var name = "Bob the brainless zombie";
	override func scareTown()
	{
		//If we would have used the if let x : Town = town { } there would be a copy of the town struct in the if block. 
		//This will be updated, but the real town associated with our zombie will not be updated (since that is a reference to the original element)
		
		
		super.scareTown(); //Do the basic monster stuff
		if(town != nil)
		{
			print("I might as well take 10 residents as fellow zombies");
		}
		town?.disposeResidents(10);
	}
}
