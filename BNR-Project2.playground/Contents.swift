//: Playground - noun: a place where people can play
//Big nerd Ranch - Swift development - Playground 2

import Cocoa
//########################################################################
// Part II - Basics of Swift
//########################################################################
var readerValue : Int = 9001;
var readerMessage : String = "";
var readerMessage2 : String = "";

//What does the reader say vegeta?
if(readerValue > 9000)
{
	readerMessage = "It's over 9000";
}
else
{
	readerMessage = "It's not over 9000, so it's safe?";
}
readerMessage2 = readerValue > 9000 ? "It's over 9000" :  "It's not over 9000, so it's safe?";
print(readerMessage);
print(readerMessage2);



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