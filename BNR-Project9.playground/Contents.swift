//Big nerd Ranch - Swift development - Playground 9


import Cocoa

//########################################################################
// Part III - Collections and functions
// Great DRY and more complexity compared to strings and integers
//########################################################################

//In this playground: Functions (at last!)

//The -> () and -> Void are optional, but can be used to explicitly identify void functions
func helloWorld() -> ()
{
	print("Hello world");
}
helloWorld();

func helloYou(_ you: String) -> Void //putting _ as function name allows you to have no parameter name, this can be done for multiple parameters
{
	print("Also Hello to you, \(you)");
}
helloYou("Tester");

func multiply(part1: Int, part2: Int)
{
	print(part1 * part2);
}
multiply(part1: 1, part2: 6);

//You can alter the name of the parameter to be different for the caller and the function
//This will expose the param to, but internally we can use name (this can greatly help in readability on both sides)
func differentName(to name : String)
{
	//print(to); //As expected, to is no available, only to the outside
	print(name);
}
differentName(to: "Tester");

//multiple items to a single parameters (similar to params string[] in .net). This is called variadic parameters
func multiHello(to names : String..., what : String = "Hello") //Unlike .net we can have the variadic everywhere, due to having the parameters always named
{
	for name in names
	{
		print("\(what) \(name)");
	}
}

multiHello(to: "Harry", "Betsie", "Theo", "Frits"); //Default param values work like they work in .net, just add an = value in the function and you can skip it in the call
multiHello(to: "Harry", "Betsie", "Theo", "Frits", what: "Hi! ");
//multiHello(what: "Hi! ", to: "Harry", "Betsie", "Theo", "Frits"); //You cannot switch the parameters (unlike what you are used to in .NET where naming parameters allow you to switch their order.



//In-out parameters
var resString : String = "Hello, ";
func sayHelloThroughOutput(_ name : String, outputString : inout String) //This creates a "ref" like function, the function is always inout, no separate out
{
	outputString += "\(name)";
}
sayHelloThroughOutput("Tester", outputString: &resString);
print(resString);

func returnMultiply(_ part1 : Int, _ part2: Int) -> Int //Return is via the -> notation, would expect the : since most languages using typedef through : do this
{
	return part1 * part2;
}
var myMultiplyRes = returnMultiply(1,2);
print(myMultiplyRes);

//When ommiting the name of the parameter you can opt to name some of them (in this case part3), this requires you to use the name in the call for that parameter, while being able to skip it for the others. This might cause some readability issues...
func returnMultiply2(_ part1 : Int, part3: Int, _ part2: Int) -> Int
{
	return part1 * part2;
}
returnMultiply2(1,part3: 2,3);


//Functions can be nested and can use vars from the upper scope (like most languages can). This can however yield interesting issues regarding scoping.
func function1()
{
	var var1 : Int = 10;
	func function2()
	{
		print(var1);
	}
	var1 = 20;
	function2();
}
function1();

//When multiple objects need to be returned we can use tupple constructions
func splitEvenOdds(_ numbers : Int...) -> (even : [Int], odd : [Int])
{
	var oddList : [Int] = [];
	var evenList : [Int] = [];
	for nr in numbers
	{
		if (nr % 2 == 0)
		{
			evenList.append(nr);
		}
		else
		{
			oddList.append(nr);
		}
	}
	return (even: evenList, odd: oddList);
}
var splittedData = splitEvenOdds(1,3,4,6,7,11);
print(splittedData);


//Guard statement
//Useful for nil checks and premature exit if these are not set
func greet(fullName : (first: String, middle: String?, last: String))
{
	if let middleName = fullName.middle
	{
		print("Hello: \(middleName)");
	}
	else
	{
		return;
	}
}
func greetGuarded(fullName : (first: String, middle: String?, last: String))
{
	guard let middleName = fullName.middle else //This does the same, but uses the guard to summon the else statement
	{
		print("no middle name?");
		return;
	}
	print("Hello: \(middleName)");
	
}
greet(fullName: ("Harry", "Superman", "Tester"));
greet(fullName: ("Tinus", nil, "Tester"));
greetGuarded(fullName: ("Harry", "Superman", "Tester"));
greetGuarded(fullName: ("Tinus", nil, "Tester"));


//Function pointers
//Like most languages we can also have a function pointer, this can be helpful for building functional code
//we can even rename the values from the return object to something that pleases us (so the tupple seems to be rebuilt)
let splitterFunc : (Int...) -> (evenList: [Int], oddList: [Int]) = splitEvenOdds;
var splitterFuncRes = splitterFunc(1,4,5,7);
print(splitterFuncRes.evenList);