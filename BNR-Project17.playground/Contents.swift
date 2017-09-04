//Big nerd Ranch - Swift development - Playground 17


import Cocoa

//########################################################################
// Part V - Advanced Swift
//########################################################################

//In this playground: Protocol extensions


protocol Exercise
{
	var name : String { get }
	var caloriesBurned : Double { get }
	var minutes: Double { get }
}

extension Exercise
{
	var calPerMinute : Double
	{
		return self.caloriesBurned / self.minutes;
	}
	var description : String
	{
		return "Exercise \(self.name) helped you burn \(self.caloriesBurned) in \(self.minutes) minute(s)";
	}
}

struct EllipticalWorkout : Exercise
{
	let name = "Elliptical Workout";
	let caloriesBurned: Double;
	let minutes : Double;
}

struct ThreadmillWorkout : Exercise
{
	let name = "Threadmill Workout";
	let caloriesBurned: Double;
	let minutes: Double;
	let laps: Double;
}

extension ThreadmillWorkout
{
	//Will replace the description set on the Exercise (this could also go in the threadmill class. Note that you are NOT allowed to define it in the Threadmill class AND this extenions, redefining is not allowed.
	var description: String
	{
		return "Exercise \(self.name) helped you burn \(self.caloriesBurned) in \(self.minutes) minute(s) by running \(self.laps) lap(s)";
	}
}

var ellepticalWorkout = EllipticalWorkout(caloriesBurned: 335, minutes: 30);
var runningWorkout = ThreadmillWorkout(caloriesBurned: 350, minutes: 25, laps: 10.5);



print(runningWorkout.description);
print(ellepticalWorkout.description);
