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
	/*init()
	{
		var x = Date.init(timeIntervalSinceNow: 0);
		self.init(name: "Default town \(x)", population: 9_005);
	}*/
	init?(name: String, population: Int = 9_001)
	{
		guard population > 0 else { return nil; }
		self.population = population;
		self.name = name;
	}
	
	init?(name: String, population: Int, region: String)
	{
		self.init(name: name, population: population);
		self.region = region;
	}

	
	var region : String = "";
	
	enum TownSize
	{
		case small;
		case medium;
		case large;
	}
	
	//Will be set only once
	lazy var lazyTownSize : TownSize =
	{
		print("setting lazy townsize for: \(self.population)")
		return self.townSize; //Will set the own element to that size (in the earlier iteration the switch was here)
	}();
	
	var townSize : TownSize
	{
		get {
			print("testing size for: \(self.population)");
			switch self.population
			{
			case 0...100:
				return TownSize.small;
			case 100...9_000:
				return TownSize.medium;
			default:
				return TownSize.large;
			}
		}
	}
	
	var name : String = "Smallvile" {
		didSet(oldName)
		{
			print("Mayor of \(oldName) decided that \(name) is more suitable");
		}
	}
	
	var population : Int = 9_001
	{
		didSet(oldPopulation)
		{
			print("Population changed from \(oldPopulation) to \(population)");
		}
	}
	var numberOfStopLights = 4;
	
	mutating func printStatus() -> Void
	{
		//Vars can be referenced by self and just the name
		print("Our little town of \(self.name) has \(population) residents and \(self.numberOfStopLights) stoplights, we consider it a \(self.townSize) town (but if we are lazy, we call it: \(self.lazyTownSize))");
	}
	
	mutating func disposeResidents(_ amountToDispose : Int)
	{
		self.population -= amountToDispose;
		print("Disposed \(amountToDispose) residents");
	}
}
