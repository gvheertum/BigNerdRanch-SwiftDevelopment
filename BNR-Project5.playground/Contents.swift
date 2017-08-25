//: Playground - noun: a place where people can play
//Big nerd Ranch - Swift development - Playground 5

//Big nerd Ranch - Swift development - Playground 3

import Cocoa
//########################################################################
// Part II - Basics of Swift
// Conditionals, control flow etc
//########################################################################

//In this playground: Playing with optionals

//Optionals are nil in Swift if not set. The null does not exist in Swift (or at least not for me at this moment ;) )

import Cocoa

var optionalString: String?;
//optionalString = "This is a test";
print(optionalString) //When the optional is used the string does not need to be initialized (which I first though was always required in the earlier lessons)

var optionalNumber : Int?;
print(optionalNumber); //Nullable numbers work pretty much like .net

optionalNumber = 5;
if(optionalNumber != nil)
{
	print("number is set")
}

optionalNumber = nil; //Setting to "null"
if(optionalNumber == nil)
{
	print("number is not set")
}

//Binding optional values
//This will assign the optional number if it is not nil to the numberval, "unboxing" a nullable to a non nullable field. This can be used as a simple if to check for the nil value and assign the value to a non-nullable field (could be useful to unbox for functions not accepting optionals)
if let numberVal : Int = optionalNumber
{
	print("action when set")
	print(numberVal)
}
else
{
	print("action when set to nil")
}

//The binding can be used for more complex situations like casting or doing multiple things on the item
//you can directly work on the non-optional strNumber, since the Int() will fail on 
//string? let intNumber = Int(strNumberOptional) will yield a compile error. The strNumber is directly 
//available AFTER evaluating allowing us to use it in the second if (if the item is not a numeric, it will 
//yield as false and not executing the body
var strNumberOptional : String? = "9001";
if let strNumber = strNumberOptional, let intNumber = Int(strNumber)
{
	print("\(strNumber) \(intNumber)");
}

//What happens with multipe optionals, can I unbox them all?
var strOpt1: String?;
var strOpt2: String?;
strOpt1 = "value1";
strOpt2 = "value2";
//This only works if strOpt1 AND strOpt2 are both not nil, if one or both are nil it will not evaluate to true and not execute the code
if let str1 = strOpt1, let str2 = strOpt2
{
	print("\(str1) - \(str2)");
}

//So, yep you can!


//Playing with assigning to/from optionals
var pOpt1 : String? = "value";
print(pOpt1) //Yields Optional("value")
var p1: String = "";
var pUnknown = pOpt1; //System will auto-interprate this to String? and not string since it can be null
//p1 = pOpt1; //This yields a compiler error since we are not sure pOpt1 is set (even if we just set it, the compiler cannot be absolutely sure, so a compiler error is thrown
//pOpt1 = p1; //This works, ofcourse since we can always put a string in a string?

print(pOpt1?.uppercased()); //This will yield Optional("VALUE")
var upperCasedVal = pOpt1?.uppercased()
print(upperCasedVal)

pOpt1 = nil;
print(pOpt1?.uppercased()); //This will yield nil

pOpt1 = "";
pOpt1?.append("Blabla"); //If nil this will yield nil (like .net the value is ignored
pOpt1


//Null coalescing works like .net
var myNotSetVar : String?;
print(myNotSetVar ?? "This is a value");
var setVar : String = myNotSetVar ?? "This is now a value"; //We can assure string here since we will always have a result in our assignment
