//Big nerd Ranch - Swift development - Playground 8


import Cocoa

//########################################################################
// Part III - Collections and functions
// Great DRY and more complexity compared to strings and integers
//########################################################################

//In this playground: Sets

var shoppingBag : Set<String> = Set<String>();
shoppingBag.insert("Apples");
shoppingBag.insert("Oranges");
shoppingBag.insert("Pears");

//By serving an array to the Set constructor we can have an inline creation or we can just assign the array directly
var inlineBag : Set<String> = Set<String>(["Cookies", "Chips", "Apples"]);
var inlineBag2 : Set<String> = ["Cookies", "Chips", "Water"];

for item in shoppingBag
{
	print(item);
}

//You can check if items are already in the list, if they are they will not be inserted (giving inserted = false) and contains will also yield false if the item in not in the list
shoppingBag.insert("Apples");
shoppingBag.contains("Bananas");


//Sets can be combined (union) and intersected
var fullShoppingBag = inlineBag.union(shoppingBag); //Combines all items (skipping duplicates)
for item in fullShoppingBag
{
	print(item);
}
var minimalisticShoppingBag : Set<String> = ["Apples"];
var overlapBag = fullShoppingBag.intersection(minimalisticShoppingBag); //Keeps items overlapping
print(overlapBag);
shoppingBag.isDisjoint(with: inlineBag2); //Check if there is NO overlap in the lists