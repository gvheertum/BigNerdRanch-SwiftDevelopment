//: Playground - noun: a place where people can play
//Big nerd Ranch - Swift development - Playground 2

import Cocoa
//########################################################################
// Part II - Basics of Swift
// Conditionals, control flow etc
//########################################################################
var readerValue : Int = 9001;
var readerMessage : String = "";
var readerMessage2 : String = "";

//What does the reader say vegeta?
if(readerValue > 9000)
{
	readerMessage = "It's over 9000";
}
else if (readerValue > 8000)
{
	readerMessage = "It's not over 9000, but still quite high";
}
else
{
	readerMessage = "It's not over 9000 and also not over 8000, so it's safe?";
}
readerMessage2 = readerValue > 9000 ? "It's over 9000" :  "It's not over 9000, so it's safe?";
print(readerMessage);
print(readerMessage2);


var multiIfValue = 6;
if(multiIfValue >= 0 && multiIfValue <= 10 && multiIfValue % 2 == 0)
{
	print("Number is between 0 and 10 and even");
}
//The if can also have cases (for example to check ranges)
if case 0...10 = multiIfValue, multiIfValue % 2 == 0
{
	print("Check is basically the same, however the notation is different. Number is between 0 and 10 and even");
}

//var shortHandInt : int = 33; //There is no int alias for Integers
//Note that the int is 64 bits in iOS, use the Int32 for specific 32 bits integers
var intMin : Double  = Double(Int.min); //The () is needed for conversion to the Double)
var intMax : Double = Double(Int.max);
var int32Min : Double = Double(Int32.min);
var int32Max : Double = Double(Int32.max);
var intDelta : Double = intMax - intMin; //Doh, this cannot fit in an integer :D, ofc not
var int32Delta : Double = int32Max - int32Min;
print("64b - You can use integers between \(intMin) and \(intMax), giving you \(intDelta) integer values to use");
print("32b - You can use integers between \(int32Min) and \(int32Max), giving you \(int32Delta) integer values to use");


//In swift integers will not overflow automatically, which is nice but can be interesting when not expected
var intToOverflow : Int32 = Int32.max;
print(intToOverflow);
//intToOverflow += 1; //this yields an error
intToOverflow = intToOverflow &+ 1; //Flipping it to int32.min (note there is no &+=)
print("intToOverflow == Int32.min? -> \(intToOverflow == Int32.min)");

//########################################################################
//Testing of the initializations requirements for vars?
//########################################################################
//(Testing if there are differences compared to other languages)
var myStrNotInitialized : String;
let myStrNotInitialized2 : String;
// If not initialized, an compiler exceptions is throwns (which is to expected tbh)
//print (myStrNotInitialized);
//print (myStrNotInitialized2);

//Funny, you can assign it outside of the declaration once (to be more precise, you HAVE to assign it before trying to use it! (like you would expect))
myStrNotInitialized2 = "Value"; //
//myStrNotInitialized2 = "Value2";


var myIntNotInitialized : Int;
//print(myIntNotInitialized); //Swift does not initialize integers to an explict 0 value, so even primitive types need to be initialized before using (this might depend on how the playground is treated, in .NET you don't need an initial value for class items, but in a function you DO need to specify the value explicitly)

//########################################################################
// Playing with switches
// The switch needs to be exhaustive, throug a default or a let 
// without where
//########################################################################

let nrForSwitch : Int = 99;
var labelForSwitch : String = "";
switch (nrForSwitch) //Funny thing: the break is not needed here
{
case 1:
	labelForSwitch = "One";
//case 2: mmm, multi cases are not allowed this way, we need to have them as a range
//case 3:
case 2, 3:
	labelForSwitch = "A bit above one!";
case 4...9:
	labelForSwitch = "Quite a bit above one";
case let notAnticipatedNumber where (notAnticipatedNumber < 100):
	labelForSwitch = "This number \(notAnticipatedNumber) is not anticipated but still below 100 (switch val: \(nrForSwitch))";
default:
	labelForSwitch = "Unknown";
}
print(labelForSwitch)


//Time for tupples
let myTupple = (404, "Not found");
print(myTupple);
print("Tupple: \(myTupple.0) - \(myTupple.1)")
//print(myTupple.2); //-> Yields compiler error, since there are only 2 elements (0 and 1)

var myNamedTupple = (code: 404, message: "Not found")
myNamedTupple.message = "The page was not found";
print(myNamedTupple);

let collectionOfNumbers = (1,2,6)
switch(collectionOfNumbers)
{
case (1,2,6):
	print("Hit all");
case (1,_,_):
	print("Hit the first");
//case (1,_): //Error because the tupple definition is Int,Int,Int -> compared with Int,Int
//	print("Hit the first");
case let checkedNr:
	print("Nr: \(checkedNr) not defined")
}
