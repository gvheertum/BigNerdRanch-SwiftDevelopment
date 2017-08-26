//Big nerd Ranch - Swift development - Playground 6


import Cocoa

//########################################################################
// Part III - Collections and functions
// Great DRY and more complexity compared to strings and integers
//########################################################################

//In this playground: Arrays

//Arrays are initialized with a type and are editable (so they are not of a predefined length). Note that you need to initialize them with = xxx otherwise they are not defined (duh!)
var shoppingList : Array<String> = Array<String>(); //Good, they are typesafe!
var hipsterList : [String] = [String](); //You can also use a different syntax
shoppingList.append("Apples");
shoppingList.append("Pears");
shoppingList.append("Pineapples");

hipsterList.append("Hipster Apples");
hipsterList.append("Hipster Pears");

print(shoppingList);
print(hipsterList);

//An array can also be directly filled
var inlineArray : [String] = ["Inline Apple", "Inline Pear"];
print(inlineArray);

//You can access items in the array, but also make a slice from the array (by using a range). The slice will yield an ArraySlice<String> object
var item : String = inlineArray[0];
var items : ArraySlice = inlineArray[0...1];
var s : ArraySlice<String> = items; //ArraySlice and ArraySlice<T> can both be used, the system will interprete the true item (in this case items can be ArraySlice and ArraySlice<string> and s can also be the same. When using ArraySlice, the system will after this line indicate that it is a ArraySlice<String>

//Editing the lists
var poppedItem : String = shoppingList.remove(at: 1); //Get the popped item from the shopping list
print(shoppingList);
shoppingList.insert("Oranges", at: 1); //Add an item at position 1 (moving items > 1 to the right
shoppingList[0] += ", good ones";
print(shoppingList); //Editing items directly in the array is no problem

//You can loop with the each item in, but also with the index
for var item : String in shoppingList
{
	print("item: \(item)");
}

for var i : Int in 0...shoppingList.count-1 //Note that the range is until and including, so we need to substract 1 to prevent looping outside of our array
{
	print("Item \(shoppingList[i]) (idx: \(i))");
}

//Array equality. The equality looks at the CONTENTS of the array, which is nice!
var arr1 : [String] = ["Item1", "Item2"];
var arr2 : [String] = ["Item1", "Item2"];
var arr1and2equal = arr1 == arr2;
print("arrays equal? \(arr1and2equal)");

//Readonly/immutable arrays by using let
//The codecompletion however keeps showing the edit statements, but using these will result in compiler errors
let myImmutableArray : [String] = ["IItem1","IItem2","IItem3"];
print(myImmutableArray);


//Items cannot be added/removed
//myImmutableArray.append("IItem4"); //Yield compiler error
//myImmutableArray.remove(at: 1); //Yield compiler error

//Items in the array can also not be changed
//myImmutableArray[0] = "IItem1.1"; //Yield compiler error
//myImmutableArray[0] += ".1"; //Yield compiler error


//****** Challenges

var toDoList : [String] = ["Take out garbage", "Pay bills", "Cross off done items"];
//* Bronze (find an indicator whether the array has items)
var hasItems : Bool = !toDoList.isEmpty;

//* Silver (reverse the todo list with a loop, then try to look for a function to do that)
var reversedToDoList : [String] = [];
for var idx in 0...(toDoList.count - 1) //Silly, you cannot use a reversed range (count-1...0)
{
	print("getting \(idx)");
	reversedToDoList.append(toDoList[toDoList.count - 1 - idx]);
}
print(reversedToDoList)
var reversedToDoList2 : [String] = toDoList.reversed(); //that's a bit easier ;)
print(reversedToDoList2)

//* Gold (find items), find the one to do after paying bills
var idxPay = toDoList.index(of: "Pay bills"); //Yields: 1
var idxUnknown = toDoList.index(of: "New tasks"); //Yields: nil
if let idxPayInt : Int = idxPay //Runs the if block only if item is != nil
{
	var nextAfterPaying = toDoList[idxPayInt+1];
	print(nextAfterPaying);
}
