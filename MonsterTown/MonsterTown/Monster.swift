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
	var town: Town?;
	var name: String = "James the base monster";
	func scareTown()
	{
		if(self.town != nil)
		{
			print("I, the monster also known as \(name) am going to scare the people of \(self.town?.name)");
		}
		else
		{
			print("I don't know where to scare, assign me a town please");
		}
	}
	
	final func sayName()
	{
		print("Hi I am \(self.name)")
	}
}
