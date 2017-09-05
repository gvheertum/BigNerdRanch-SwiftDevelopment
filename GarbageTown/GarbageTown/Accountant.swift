//
//  Accountant.swift
//  GarbageTown
//
//  Created by Gertjan on 05/09/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import Foundation

class Accountant
{
	typealias NetWorthChanged = (Double) -> Void;
	var netWorthChangedHandler: NetWorthChanged? = nil;
	var netWorth: Double = 0.0
	{
		didSet
		{
			netWorthChangedHandler?(netWorth);
		}
	}
	
	func gained(_ asset: Asset)
	{
		netWorth += asset.value;
	}
}
