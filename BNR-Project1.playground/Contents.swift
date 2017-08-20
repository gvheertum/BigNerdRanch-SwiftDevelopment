//: Playground - noun: a place where people can play
//Big nerd Ranch - Swift development - Playground 1


import Cocoa

//########################################################################
// Part I - var, let, assignment and strings
// Good to start with the basis (even if you know this in other languages
// starting with this in new languages will give you a nice start)
//########################################################################

var str : String = "Hello, playground";
str += "! So this is equal to 'normal' languages ;)";
print(str);

let fixedStr : String = "This string is not able to change!";
//fixedStr += " So this is an error, no?" //Lol, this randomly killed my xcode instance after entering the semi-colon at the end of the line
print(fixedStr);

var editableNr : Int = 4;
editableNr = 5;
let nonEditableNr : Int = 10;
//nonEditableNr = 11;

print(editableNr, "-", nonEditableNr); //Note to self: the + operator does not work on Int & string
var interpolatedString = "This is kinda neat, like the dot net version of {} we can use \\() for output: \(editableNr), \(nonEditableNr) (even calculated: (\(editableNr - nonEditableNr)))";
print(interpolatedString)

