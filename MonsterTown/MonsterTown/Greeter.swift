//
//  Greeter.swift
//  MonsterTown
//
//  Created by Gertjan on 28/08/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import Foundation

struct Person
{
	var firstName : String = "";
	var lastName: String = "";
	mutating func changeName(firstName : String, lastName : String)
	{
		self.firstName = firstName;
		self.lastName = lastName;
	}
	func introduce()
	{
		print("\(firstName) \(lastName)");
	}
}

//Chapter 15 -> mutation methods and func references
class Greeter
{
	
	//Returns a greeting function
	func greeting(_ greeting : String) -> ((String) -> String)
	{
		return
		{
			(name : String) -> String in
			return "\(greeting), \(name)";
		};
	}
	
	func doGreetingWork() -> Void
	{
		let niceGreeting = greeting("Hello");
		print(niceGreeting("World"));
	
		var p = Person();
		//p.firstName = "Harry";
		//p.lastName = "de TestKabouter";
		
		//This is equal to using p.changeName(firstName: "Harry", lastName: "de Testkabouter");
		let changeName = Person.changeName; //type = (inout Person) -> (String, String) -> ()
		var changeNameForP = changeName(&p);
		changeNameForP("Harry", "de Testkabouter");
		p.introduce(); //This will update the p object we have (since we parsed a reference)
	}
	
	
	
}

