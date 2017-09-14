//
//  TodoList.swift
//  iDoodlyDum
//
//  Created by Gertjan on 14/09/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import UIKit

class TodoList: NSObject
{

	fileprivate var items: [String] = [];
	
	func add(_ item : String)
	{
		self.items.append(item);
	}
}

extension TodoList : UITableViewDataSource
{
	//This will create an item in a reusable cell (the cells are presented from that function when they are usable)
	//We will ask the index requested and render the cell upon request
	func tableView(_ table : UITableView, cellForRowAt: IndexPath) -> UITableViewCell
	{
		let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: cellForRowAt); //The identifier Cell is provided in the controller when registering the table
		let item = items[cellForRowAt.row];
		cell.textLabel!.text = item;
		
		
		print("Built cell for \(item)");
		return cell;
	}
	
	//Amount of elements we can tell the list to expect
	func tableView(_ table: UITableView, numberOfRowsInSection: Int) -> Int
	{
		print("Requested amount of cells: \(items.count)");
		return items.count;
	}
}
