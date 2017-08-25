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

