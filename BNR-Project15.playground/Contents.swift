//Big nerd Ranch - Swift development - Playground 15


import Cocoa

//########################################################################
// Part V - Advanced Swift
//########################################################################

//In this playground: Extensions

typealias Velocity = Double;
extension Velocity
{
	var speedInMph : Velocity { return self / 1.60934; }
	var speedInKmh : Velocity { return self; }
}
var currentSpeed : Velocity = 120;
print(currentSpeed.speedInKmh);
print(currentSpeed.speedInMph);

protocol Vehicle
{
	var topSpeed : Velocity { get }
	var numberOfDoors : Int { get }
	var hasFlatbed : Bool { get }
}

struct Car
{
	let make : String;
	let model : String;
	let year : Int;
	let color : String;
	let nickname : String;
	var gasLevel : Double
	{
		willSet
		{
			precondition(newValue <= 1.0 && newValue >= 0, "Value need to be between 0 and 1");
		}
	}
}

extension Car : Vehicle
{
	init(make : String, model: String, year: Int){
		self.init(make: make, model: model, year: year, color: "Unknown", nickname: "N/A", gasLevel: 0)
	}
	var topSpeed : Velocity { return 195; }
	var numberOfDoors : Int { return 4; }
	var hasFlatbed : Bool { return false; }
}

extension Car
{
	enum Kind
	{
		case coupe, sedan
	}
	
	var kind : Kind
	{
		if(numberOfDoors == 2) { return .coupe; }
		return .sedan;
	}
}

extension Car
{
	mutating func emptyGas(by amount : Double)
	{
		precondition(amount <= 1 && amount > 0, "Amount to remove must be between 0 and 1");
		gasLevel -= amount;
	}
	mutating func fillGas()
	{
		gasLevel = 1;
	}
}

//Constructing with gaslevel 33 is okay, but setting is lateron will cause an error, interesting
var car = Car(make: "Renault", model: "Megane", year: 2013, color: "Gray", nickname: "Bakkie", gasLevel: 1 /*33*/);
var car2 = Car(make: "Peugeot", model: "207", year: 2009);
print(car);
print(car2);
//car.gasLevel = 33; //This triggers the precondition

car.kind;
car.emptyGas(by: 1);
//car.emptyGas(by: 1); //Draining too much will cause an error due to an invalid value being set by the drain function