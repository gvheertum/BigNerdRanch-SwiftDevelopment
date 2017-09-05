//
//  Asset.swift
//  GarbageTown
//
//  Created by Gertjan on 05/09/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import Foundation

class Asset : CustomStringConvertible
{
	let name: String;
	let value: Double;
	weak var owner: Person?;
	
	var description: String
	{
		if let actualOwner = owner
		{
			return "Asset(\(name)), worth \(value), owned by \(actualOwner)";
		}
		else
		{
			return "Asset(\(name)), worth \(value), is not owned by anyone";
		}
	}
	
	init(name: String, value: Double)
	{
		self.name = name;
		self.value = value;
	}
	
	deinit
	{
		print("\(self) is being deallocated");
	}
}
