//
//  TodoList.swift
//  iDoodlyDum
//
//  Created by Gertjan on 14/09/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import UIKit
protocol CanRefresh
{
	func refresh();
}

class TodoListTableHandler : NSObject, CanRefresh
{
	private var tableView : UITableView;
	private var tableObserver : TodoTableObserver?;
	init(tableView : UITableView, todoList: TodoList)
	{
		self.tableView = tableView;
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell"); //Register cell type "Cell" and use the constructor delegate of the UITableViewCell
		self.tableView.dataSource = todoList;
		super.init();
		
		self.tableObserver = TodoTableObserver(todoList: todoList, refresher: self);
		self.tableView.delegate = self.tableObserver;
	}
	
	public func refresh()
	{
		self.tableView.reloadData();
	}
}

class TodoTableObserver : NSObject, UITableViewDelegate
{
	let todoList : TodoList;
	let refresher : CanRefresh;
	public init(todoList : TodoList, refresher : CanRefresh)
	{
		self.todoList = todoList;
		self.refresher = refresher;
	}
	
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		print("Selected a row in othe thingy: \(indexPath)");
		self.todoList.removeAt(indexPath.row);
		refresher.refresh();
	}
}

class TodoList: NSObject
{

	private let fileUrl : URL =
	{
		let documentDirUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask);
		let documentDirUrl = documentDirUrls.first!;
		return documentDirUrl.appendingPathComponent("todolist.items");
	}();
	
	fileprivate var items: [String] = [];
	
	func add(_ item : String)
	{
		if(item.characters.count <= 0) { return; }
		self.items.append(item);
		saveItems();
	}
	
	func removeAt(_ itemIdx: Int)
	{
		self.items.remove(at: itemIdx);
		saveItems();
	}
	
	func saveItems()
	{
		let itemsArray = items as NSArray;
		print("writing to: \(fileUrl)");
		if(!itemsArray.write(to: fileUrl, atomically: true))
		{
			print("Uh oh, writing is broken :(");
		}
	}
	
	func loadItems()
	{
		if let itemsArray = NSArray(contentsOf: fileUrl) as? [String]
		{
			items = itemsArray;
		}
	}
	
	override init()
	{
		super.init();
		loadItems();
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
