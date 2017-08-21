//Big nerd Ranch - Swift development - Playground 3

import Cocoa
//########################################################################
// Part II - Basics of Swift
// Loops
//########################################################################
//Notes: The for i in cannot be used in (), this will yield an error

//for (var i = 0; i < 10; i++) //Classic style if is removed in swift 3
print("Starting");

var cnt : Int = 0;
for i in 1...5 //This is up-AND-until (so including 5)
{
	cnt += 1; //the ++ is removed... :X
	print("Hit counter: \(cnt) (step \(i))");
}

let lowerLimit : Int = 0;
let upperLimit : Int = 10;
cnt = 0;
for i in lowerLimit...upperLimit //the values can also be variables
{
	cnt += 1;
	print("Counter: \(cnt) (step \(i))");
}

//You can also use where in the for..in to select certain elements
var sumOfEvens : Int = 0;
for i in 0...100 where (i % 2 == 0)
{
	sumOfEvens += i;
	print("\(i) is an even number");
}
print("sum of events in 0...100 => \(sumOfEvens)")

//for i in 0...10
for _ in 0...10 //If we don't care about the value of the iterator we can use _ wildcard, but ignoring i can also help, but might trigger warnings (and later maybe an error if they change the working)
{
	print("Test string");
}


//While loops
//########################################################################

//simple while
var whileVar : Int = 10;
while(whileVar > 0)
{
	print("still above 0: \(whileVar)");
	whileVar -= 1;
}

//repeat while works like the do-while in other languages. Will run the first iteration before performing the check
whileVar = 0; //If set to 10 it will run equal to the simple while, having it on 0 will run it once, where the simple while will not run
repeat
{
	print("repeat while (var: \(whileVar))");
	whileVar -= 1;
}while(whileVar > 0)

//Control statements (work just like .NET)
for i in 0...10
{
	if(i == 2) { continue; }
	if(i == 5) { break; }
	print("Hitting: \(i)"); //Will echo 0,1,3,4 and then quit
}

