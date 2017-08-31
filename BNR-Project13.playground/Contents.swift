//Big nerd Ranch - Swift development - Playground 13


import Cocoa

//########################################################################
// Part V - Advanced Swift
//########################################################################

//In this playground: Protocols

struct Person : CustomStringConvertible
{
	let name : String;
	let age: Int;
	let projects: Int;
	var description : String
	{
		return "Meet \(name), existing for \(age) year(s) and done \(projects) project(s)";
	}
}

protocol Printer
{
	func printData(_ persons : [Person]);
}

class TablePrinter : Printer
{
	func printData(_ persons : [Person])
	{
		var strData : [[String]] = [];
		for person in persons
		{
			strData.append([person.name, "\(person.age)", "\(person.description)"]);
		}
		printDataInternal(strData, withLabels: "Name", "Age", "Projects");
	}
	
	
	private func printDataInternal(_ data : [[String]], withLabels : String...)
	{
		var lblBuffer : String = "|";
		for label : String in withLabels
		{
			lblBuffer += " \(label) |";
		}
		print(lblBuffer);
		
		for row : [String] in data
		{
			var rowBuffer : String = "|";
			for col : String in row
			{
				rowBuffer += " \(col) |";
			}
			print (rowBuffer)
		}
	}

}


let data : [Person] = [
	Person(name: "Harry", age: 19, projects: 1),
	Person(name: "Bep", age: 22, projects: 2),
	Person(name: "Theo", age: 33, projects: 11)
];
var tp : Printer = TablePrinter();
tp.printData(data);