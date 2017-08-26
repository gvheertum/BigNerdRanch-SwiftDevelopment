//Big nerd Ranch - Swift development - Playground 10


import Cocoa

//########################################################################
// Part III - Collections and functions
// Great DRY and more complexity compared to strings and integers
//########################################################################

//In this playground: Closures

let testNumbers : [Int] = [1,423,14,123,12,5,12,5,1,68,32,13];
func numberIsEven(_ nr : Int) -> Bool
{
	return nr % 2 == 0;
}
func numberAIsBiggerThenNumberB(_ nr1 : Int, _ nr2 : Int) -> Bool
{
	return nr1 > nr2;
}
func echoNumber(_ nr : Int) -> Void
{
	print(nr);
}
var sorted = testNumbers.sorted(by: numberAIsBiggerThenNumberB);
testNumbers.forEach(echoNumber);
print(sorted);

//You can also make the closure inside of the function accepting it
sorted.forEach({
		(nr:Int) -> Void in
		print(nr);
});

var evenNumbers = testNumbers.filter(numberIsEven); //filter is the where we know from linq
print(evenNumbers);
var doubledNumbers = testNumbers.map({nr in return nr*2;});
print(doubledNumbers);
//Reduces [Int] to Int. Done by giving an initial int and telling for each element what to do with 2 of the results
var sum = testNumbers.reduce(0, { (v1, v2) in return v1+v2 });
print(sum);

//Below are other notations possible in closures (shorter notations)
var sorted2 = testNumbers.sorted(by: {i, j in i < j});
sorted2 = testNumbers.sorted(by: { (i :Int, j: Int) in return i < j; })
sorted2 = testNumbers.sorted(by: {$0 < $1}); //If not explicitly named, we can fallback to the $x tags, which is not that great for readability and I suggest should not be used that often


//Ofcourse functions can also return other functions
func functionBuilder(_ multiplier : Int) -> ((Int) -> Int)
{
	func multiplierFunc(_ input : Int) -> Int
	{
		return input * multiplier;
	}
	return multiplierFunc;
}
var multiplierRes = functionBuilder(2)(3); //Wraps 2 in the function
multiplierRes = functionBuilder(3)(5); //Wraps 3 in the function


func performMultipler(_ inputValue : Int, multiplierFunc : (Int) -> Int) -> Void
{
	var res = multiplierFunc(inputValue);
	print(res);
}
performMultipler(4, multiplierFunc: functionBuilder(3)); //Creates a multiplier function for 3 which will be applied by the perform multiplier function to 4


//Closures track data regarding scope
//This can be very dangerous if you are not aware of what you are doing
func getClosureFunc() -> ((Int) -> Int)
{
	var counter = 0; //This counter is kept "alive" during the lifetime of the addToCounter references.
	func addToCounter(_ amount : Int) -> Int
	{
		counter += amount;
		return counter;
	}
	return addToCounter;
}
var counterFunc = getClosureFunc();
var counterFuncCopy = counterFunc; //the item is a reference, so both keep track of the same data
var counterVal = counterFunc(10); //10
counterVal = counterFunc(100); //110
counterVal = counterFuncCopy(10); //120
counterVal = counterFunc(-10); //110 again

//Getting a new function var will clear the tracking. This boils down 
//to the counter being alive somewhere while the reference to the internal 
//function is used, by recalling the getClosureFunc we create a new 
//instance of the addToCounter AND therefor a new counter object.
counterFunc = getClosureFunc();
counterVal = counterFunc(30); //30
counterVal = counterFuncCopy(33); //This still points to the older object so will set that data to 143
