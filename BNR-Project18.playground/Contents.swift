//Big nerd Ranch - Swift development - Playground 14


import Cocoa

//########################################################################
// Part V - Advanced Swift
//########################################################################

//In this playground: Equatable and Comparable

struct Point : Equatable, Comparable
{
	let x : Double;
	let y : Double;
	
	static func ==(left: Point, right: Point) -> Bool
	{
		return left.x == right.x && left.y == right.y;
	}
	
	static func <(left: Point, right: Point) -> Bool
	{
		return left.x < right.x && left.y < right.y;
	}
}

let a = Point(x: 3, y: 4);
let b = Point(x: 3, y: 4);

var abEqual : Bool = (a == b);
var abNotEqual : Bool = (a != b); //This is a free present from swift ;)

let c = Point(x: 2, y: 6);
let d = Point(x: 3, y: 7);
let cdEqual = (c == d);
let cLessThanD = c < d;
let dGreaterThanD = d > c;


// Bring your own operator
// ****************************
infix operator +++;

class Person
{
	var name : String;
	weak var spouse : Person?;
	init(name: String, spouse: Person? = nil)
	{
		self.name = name;
		self.spouse = spouse;
	}
	static func +++(l: Person, r: Person)
	{
		l.spouse = r;
		r.spouse = l;
	}
	var described : String
	{
		return "\(name), spouse: \(spouse?.name ?? "None")";
	}
}


var harry = Person(name: "Harry");
var thea = Person(name: "Thea");
harry +++ thea;
print(harry.described);
print(thea.described);