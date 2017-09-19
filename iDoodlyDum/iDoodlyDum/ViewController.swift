//
//  ViewController.swift
//  iDoodlyDum
//
//  Created by Gertjan on 14/09/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate
{

	@IBOutlet var textField : UITextField!;
	@IBOutlet var tableView : UITableView!;
	
	var todoList : TodoList = TodoList();
	var todoListHandler : TodoListTableHandler? = nil;
	var todoTableObserver : TodoTableObserver? = nil;
	override func viewDidLoad()
	{
		super.viewDidLoad();
		
		self.todoListHandler = TodoListTableHandler(tableView: tableView, todoList: todoList);
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func addButtonPressed(_ sender : UIButton)
	{
		guard let todoItem = textField.text else { return; }
		print("Add button was pressed to add item: \(textField.text ?? "-")");
		todoList.add(todoItem);
		//Tell the tableview we changed
		todoListHandler?.refresh();
		textField.text = "";
	}
}


