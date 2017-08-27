//Big nerd Ranch - Swift development - Playground 11


import Cocoa

//########################################################################
// Part IV - Enumerations, Structures and Classes
// Finally something to store all these datas in ;)
//########################################################################

//In this playground: Enumerations


//Creation works with case. The naming convention writes lowerCamelCase
enum TextAlign
{
	case left
	case right
	case center
}



print(TextAlign.left);



var prefAlign : TextAlign = TextAlign.left;
prefAlign = TextAlign.right;
prefAlign = .center; //You can use a shorthand for the assignment (type is auto-determined)

if (prefAlign == TextAlign.center)
{
	print("align to the center");
}

if (prefAlign == .center) //In comparisons we can also use the shorthand
{
	print("align to the center");
}

switch prefAlign //In switches we can use both the full and the short notation
{ //All cases need to be present, or a default needs to be here (like most languages check for)
case TextAlign.left:
	print("Left");
case .right:
	print("Right");
case .center:
	print("Center");
}

//Enums can inherit from Int
//Which is NOT the default (unlike C#). Swift can have enums without backing type
enum TextAlignWithInt : Int //The int inherit is not defualt (unlike .net)
{
	case left //Autonumbered from 0 (like most languages)
	case right
	case center
}
var prefAlignInt : TextAlignWithInt = TextAlignWithInt.left;
print(prefAlignInt);
//The raw value is only available on the Int inheriting enum. Both on the values in the enum and the vars of the enum type
print(prefAlignInt.rawValue);
print(TextAlignWithInt.left.rawValue)
print(TextAlignWithInt.right.rawValue)
print(TextAlignWithInt.center.rawValue)

enum TextAlignWithIntAndValues : Int
{
	case left = 20
	case right = 30
	case center = 40 //If not numbering, the enum will just +1 the items
}
print(TextAlignWithIntAndValues.center.rawValue)
var enumCastingVal : TextAlignWithIntAndValues?;
enumCastingVal = TextAlignWithIntAndValues(rawValue: 20); //Will map to left
//enumCastingVal = TextAlignWithIntAndValues(rawValue: 100); //Execution error since 100 is not valid


//like other checks you can use a safe if let method
func TestEnumCast(_ value : Int)
{
	if let enumCastingVal2 = TextAlignWithIntAndValues(rawValue: value)
	{
		print("Value \(value) => \(enumCastingVal2)");
	}
	else
	{
		print("Invalid value: \(value)");
	}
}
TestEnumCast(20);
TestEnumCast(100);

//Enums can also inherit from Strings
enum ProgrammingLanguage : String
{
	case swift = "swift"
	case csharp = "c#"
	case java //For the default value we can also decide not to have a =, this will fallback to the string being equal to the key
}

print(ProgrammingLanguage.csharp);
print(ProgrammingLanguage.csharp.rawValue);

var plCast1 : ProgrammingLanguage? = ProgrammingLanguage(rawValue: "c#");
var plCast2 : ProgrammingLanguage? = ProgrammingLanguage(rawValue: "csharp"); //Mapping only happens on the string value, so the key is not used for construction (which make sense since a value can be both a key and a value for a different key)


//enums can have functions, which can work on the value of the enum variable
enum Status
{
	case on
	case off
	func echoYourStatus() -> String
	{
		switch self
		{
		case .on:
			return "I'm on!";
		case .off:
			return "I'm off!";
		}
	}
	mutating func toggle() -> Void //By default func is not able to mutate the instance, flagging as mutating will allow you to do this
	{
		switch self
		{
		case .on:
			self = .off;
		case .off:
			self = .on;
		}
	}
}
var itemStatus : Status = Status.on;
print(itemStatus.echoYourStatus());
itemStatus = .off;
print(itemStatus.echoYourStatus());

//You can also toggle the status of the enum object itself
itemStatus.toggle();
print(itemStatus);
itemStatus.toggle();
print(itemStatus);

let immutableStatus : Status = Status.on;
//immutableStatus.toggle(); //This toggles a runtime error since the element is immutable but is calling a mutating function


// Values in enums
// There can be much more magic in enumerators
enum Shape
{
	case point //you can have items without values mixed in these enums
	case square(side: Double)
	case rectange(side1: Double, side2: Double)
	func getArea() -> Double
	{
		switch self
		{
		case .point:
			return 0;
		case let .rectange(side1: side1, side2: side2): //Note: use the let
			return side1 * side2;
		case let .square(side: side):
			return side * side;
		}
	}
}
var sq = Shape.square(side: 10); //a "constructor is created
var sq2 = Shape.square(side: 20);
sq.getArea();
//var sqEquality = sq == sq2; // Enums with values cannot be compared with the == (then again, comparing these squares would be interesting, are they equal because .square or not equal due to the value being different
var rec = Shape.rectange(side1: 10, side2: 20);
var rec2 = Shape.rectange(side1: 5, side2: 5);
rec.getArea();

var p = Shape.point;
p.getArea();

