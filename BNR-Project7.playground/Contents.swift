//Big nerd Ranch - Swift development - Playground 7

import Cocoa

//########################################################################
// Part III - Collections and functions
// Great DRY and more complexity compared to strings and integers
//########################################################################
//!!You can use alt-click to reveal data of the variables created
//In this playground: Dictionaries

//Dictionaries work similar to .NET
var myDict : Dictionary<String, Int> = Dictionary<String, Int>();
var myDict2 : [String:Int] = [:];
var myDict3 : [String:Int] = ["One" : 1, "Two" : 2, "Three" : 3, "Four" : 4];
var itemsInDict = myDict3.count;
var itemFind : Int? = myDict3["Two"]; //Yields Int? => 1
var itemNotFound : Int? = myDict["Three"]; //Yields nil (different from .net since .net will throw an exception)

myDict["One"] = -1; //This will create the entry
print(myDict);
myDict3["One"] = -1; //This will replace the item (like expected)
myDict3.updateValue(-2, forKey: "Two") //This can also be used to change the value, but is less readable
print(myDict3);

myDict.updateValue(-2, forKey: "Two") //Like the key usage, this will insert the item
print(myDict);

//You can remove th items by key (however the name is value, which is a bit odd)
myDict3.removeValue(forKey: "Two"); //like arrays this will return the object
myDict3.removeValue(forKey: "Three"); //this returns nil
print(myDict3);
print(myDict3);