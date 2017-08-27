//
//  Town.swift
//  MonsterTown
//
//  Created by Gertjan on 27/08/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import Foundation

struct Town
{
	var name = "Smallvile";
	var population = 9_001;
	var numberOfStopLights = 4;
	
	func printStatus() -> Void
	{
		//Vars can be referenced by self and just the name
		print("Our little town of \(self.name) has \(population) residents and \(self.numberOfStopLights) stoplights");
	}
	
	mutating func disposeResidents(_ amountToDispose : Int)
	{
		self.population -= amountToDispose;
		print("Disposed \(amountToDispose) residents");
	}
}
