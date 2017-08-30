//
//  Monster.swift
//  MonsterTown
//
//  Created by Gertjan on 28/08/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import Foundation
class Monster
{
	required init(name: String, town : Town?)
	{
		print("constructing Monster");
		self.name = name;
		self.town = town;
	}
	
	var town: Town?;
	var name: String = "James the base monster";
	
	func scareTown()
	{
		if(self.town != nil)
		{
			print("I, the monster also known as \(name) am going to scare the people of \(self.town?.name ?? "")");
		}
		else
		{
			print("I don't know where to scare, assign me a town please");
		}
	}
	
	var victimPool : Int
	{
		get
		{
			return town?.population ?? 0;
		}
		set(value)
		{
			town?.population = value;
		}
	}
	
	final func sayName()
	{
		print("Hi I am \(self.name)")
	}
	
	class var noise : String
	{
		return "BWAARGH...";
	}
	
	deinit
	{
		print("Sadly \(name) decided to no longer be with us");
	}
}
