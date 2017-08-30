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
	//We are not setting all let vars, so we are convenient
	convenience init()
	{
		self.init(name: "Nameless zombie", town: nil, limping: false);
	}
	
	init(name: String, town: Town?, limping: Bool = false)
	{
		self.limping = limping;
		super.init(name: name, town: town);
	}
	
	//Will point the init specifically to this one instead of arriving at the parent
	//Like the first parameterless constructor we are not setting the vars, so I guess we are also convenient as you might say ;)
	required convenience init(name: String, town: Town?)
	{
		print("constructing Zombie");
		self.init(name: name, town:town, limping: false);
	}
	
	
	
	let limping: Bool;
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
	
	override class var noise : String
	{
		return "Brainsszzz...";
	}
}
