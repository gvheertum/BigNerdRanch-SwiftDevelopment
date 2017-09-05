//
//  Person.swift
//  GarbageTown
//
//  Created by Gertjan on 05/09/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import Foundation

class Person : CustomStringConvertible
{
	let name: String;
	var assets : [Asset] = [Asset]();
	var description: String
	{
		return "Person(\(name))";
	}
	
	init(name: String)
	{
		self.name = name;
	}
	
	func takeOwnership(of asset: Asset)
	{
		asset.owner = self;
		assets.append(asset);
	}
	
	deinit
	{
		print("\(self) is deallocated");
	}
}
