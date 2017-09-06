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
	let accountant : Accountant = Accountant();
	
	var assets : [Asset] = [Asset]();
	var description: String
	{
		return "Person(\(name))";
	}
	
	init(name: String)
	{
		self.name = name;
		accountant.netWorthChangedHandler =
		{
			[weak self] nw in
			self?.netWorthChanged(to: nw);
			return;
		};
	}
	
	func takeOwnership(of asset: Asset)
	{
		asset.owner = self;
		assets.append(asset);
	}
	
	func takeOwnershipCompletion(of asset: Asset)
	{
		accountant.gainedWithCompletion(asset)
		{
			asset.owner = self;
			assets.append(asset);
		};
	}
	
	func useNetWorthChangedHandler(handler : @escaping (Double) -> Void)
	{
		accountant.netWorthChangedHandler = handler;
	}
	
	func netWorthChanged(to newWorth : Double)
	{
		print("The net worth of \(self) is now estimated at \(newWorth)");
	}
	
	deinit
	{
		print("\(self) is deallocated");
	}
}
