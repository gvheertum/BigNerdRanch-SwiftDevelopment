//
//  ViewController.swift
//  iDoodlyDum
//
//  Created by Gertjan on 14/09/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var textField : UITextField!;
	@IBOutlet var tableView : UITableView!;
	
	var todoList : TodoList = TodoList();
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell"); //Register cell type "Cell" and use the constructor delegate of the UITableViewCell
		tableView.dataSource = todoList;
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
		tableView.reloadData();
		textField.text = "";
	}


}

