//
//  main.swift
//  GarbageTown
//
//  Created by Gertjan on 04/09/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import Foundation

//Regular deallocation tests
func allocationFunction1()
{
	var bob : Person? = Person(name: "Bob");
	print("created: \(bob)");

	bob=nil;
	print("variable bob is now: \(bob)");

	var laptop: Asset? = Asset(name: "Laptop", value: 1_500.0);
	var chair: Asset? = Asset(name: "Chair", value: 500);
	
	laptop = nil;
	chair = nil;
	
	/*Prints:
	created: Optional(Person(Bob))
	Person(Bob) is deallocated
	variable bob is now: nil
	Asset(Laptop), worth 1500.0, is not owned by anyone is being deallocated
	Asset(Chair), worth 500.0, is not owned by anyone is being deallocated
	Program ended with exit code: 0
	*/
}

//Circular reference deallocation
func allocationFunction2()
{
	var bob : Person? = Person(name: "Bob");
	print("created: \(bob)");
	var laptop: Asset? = Asset(name: "Laptop", value: 1_500.0);
	var chair: Asset? = Asset(name: "Chair", value: 500);

	bob?.takeOwnership(of: laptop!);
	bob?.takeOwnership(of: chair!);
	
	print(bob);
	print(laptop);
	bob = nil;
	print(bob);

	//The deinits are not called here if the owner var is not weak in the assets, since there are references between the assets and the person.
	//If we set the owner reference to weak (weak var owner : Person?), the deinit is called on bob and then on the assets. The assest have no owner at that moment since that one is deallocated, this yields the follwoing result:
	/*
	created: Optional(Person(Bob))
	Optional(Person(Bob))
	Optional(Asset(Laptop), worth 1500.0, owned by Person(Bob))
	Person(Bob) is deallocated
	nil
	Asset(Chair), worth 500.0, is not owned by anyone is being deallocated
	Asset(Laptop), worth 1500.0, is not owned by anyone is being deallocated
	*/
}

//weak reference in case of setting it ourself
func allocationFunction3()
{
	var bob : Person? = Person(name: "Bob");
	print("created: \(bob)");
	var laptop: Asset? = Asset(name: "Laptop", value: 1_500.0);
	laptop?.owner = bob;
	
	print(bob);
	print(laptop);
	bob = nil;
	print(bob);
	print(laptop);
		
}


//Call tests
//allocationFunction1();
//allocationFunction2();
allocationFunction3();
