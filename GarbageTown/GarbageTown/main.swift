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
	print("*****allocationFunction1()");
	
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
	print("*****allocationFunction2()");

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
	Prints:
	created: Optional(Person(Bob))
	Optional(Person(Bob))
	Optional(Asset(Laptop), worth 1500.0, owned by Person(Bob))
	Person(Bob) is deallocated
	nil
	Asset(Chair), worth 500.0, is not owned by anyone is being deallocated
	Asset(Laptop), worth 1500.0, is not owned by anyone is being deallocated
	*/
}

//weak reference in case of setting it ourself, will cause the ref count to be set to 0 while we would still like to use it (now bob is removed from the asset)
func allocationFunction3()
{
	print("*****allocationFunction3()");

	
	var bob : Person? = Person(name: "Bob");
	print("created: \(bob)");
	var laptop: Asset? = Asset(name: "Laptop", value: 1_500.0);
	laptop?.owner = bob;
	
	print(bob);
	print(laptop);
	bob = nil;
	print(bob);
	print(laptop);
	
	//If the owner is weak, this will result in the owner being cleared if bob is deallocated. Whereas a non weak owner will keep the owner in the asset alive (and only nilling the variable)
	
	/*
	Prints (with weak owner):
	created: Optional(Person(Bob))
	Optional(Person(Bob))
	Optional(Asset(Laptop), worth 1500.0, owned by Person(Bob))
	Person(Bob) is deallocated
	nil
	Optional(Asset(Laptop), worth 1500.0, is not owned by anyone)
	Asset(Laptop), worth 1500.0, is not owned by anyone is being deallocated
	*/

}

//Testing with completion functions (non escaping closures)
func allocationFunction4()
{
	print("*****allocationFunction4()");
	
	var bob : Person? = Person(name: "Bob");
	print("created: \(bob)");
	var laptop: Asset? = Asset(name: "Laptop", value: 1_500.0);
	var chair: Asset? = Asset(name: "Chair", value: 500);
	
	//The function is escaping, so we need to be aware we are not capturing items in the function
	bob?.useNetWorthChangedHandler() { nw in print("Bob now is worth: \(nw)"); };
	
	bob?.takeOwnershipCompletion(of: laptop!);1
	bob?.takeOwnershipCompletion(of: chair!);
	
	print(bob);
	print(laptop);
	bob = nil;
	print(bob);
	
	//The deinits are not called here if the owner var is not weak in the assets, since there are references between the assets and the person.
	//If we set the owner reference to weak (weak var owner : Person?), the deinit is called on bob and then on the assets. The assest have no owner at that moment since that one is deallocated, this yields the follwoing result:
	
	/*
	Prints:
	created: Optional(Person(Bob))
	Optional(Person(Bob))
	Optional(Asset(Laptop), worth 1500.0, owned by Person(Bob))
	Person(Bob) is deallocated
	nil
	Asset(Chair), worth 500.0, is not owned by anyone is being deallocated
	Asset(Laptop), worth 1500.0, is not owned by anyone is being deallocated
	*/
}



//Call tests
allocationFunction1();
allocationFunction2();
allocationFunction3();
allocationFunction4();
