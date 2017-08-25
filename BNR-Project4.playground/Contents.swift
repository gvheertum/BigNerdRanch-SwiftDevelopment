//: Playground - noun: a place where people can play
//Big nerd Ranch - Swift development - Playground 4

import Cocoa
import Foundation
//########################################################################
// Part II - Basics of Swift
// Playing with strings
//########################################################################

var myStr : String = "abc ABC Hello world! \u{1F60E}";
for char : Character in myStr.characters
{
	print("Found char: \(char)")
}

for unicodeScalar in myStr.unicodeScalars
{
	print("Scalar: \(unicodeScalar) code: \(unicodeScalar.value)")
}


var accented : String = "\u{0061}\u{0301}"; //á
var accented2 : String = "\u{00E1}"; //á
var accented3: String = "á";
for unicodeScalar in accented.unicodeScalars
{
	print("Scalar: \(unicodeScalar) code: \(unicodeScalar.value)")
} // echoes 2 chars: 97 (a) & 769 (accent)

for unicodeScalar in accented2.unicodeScalars
{
	print("Scalar: \(unicodeScalar) code: \(unicodeScalar.value)")
} //Echoes a single char (255)

for unicodeScalar in accented3.unicodeScalars
{
	print("Scalar: \(unicodeScalar) code: \(unicodeScalar.value)")
} //Echoes a single char (255)

let equal = accented == accented2 && accented2 == accented3;
print("equality: \(equal)"); //Swift doesn't care about the method the accented char is created

print("Counts a1: \(accented.characters.count), a2: \(accented2.characters.count), a3: \(accented3.characters.count)"); //Char count is 1 in all cases (which makes sense since the combined scalar really is only one char

//Indexes and ranges
//You cannot just say 0...5 as range, you need to pull it from the string
var lowerRange = myStr.startIndex;
var upperRange = myStr.index(lowerRange, offsetBy: 4); //Get the first 5 chars (0 until and including 4 -> 5 chars)
var range = lowerRange...upperRange; //(closed range)
var substr = myStr[lowerRange...upperRange];
var ltr = myStr[lowerRange]
var ltr2 = myStr[upperRange]
print(substr);
