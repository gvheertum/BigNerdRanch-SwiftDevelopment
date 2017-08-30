//
//  main.swift
//  MonsterTown
//
//  Created by Gertjan on 27/08/2017.
//  Copyright © 2017 Gertjan. All rights reserved.
//

import Foundation
/* Greeter logic -> used for the exploration of mutation function on structs
var greeter = Greeter();
greeter.doGreetingWork();
*/
var failingTown = Town(name: "The void", population: 0);
print(failingTown);

var myTown : Town = Town(name: "Crazytown", population: 9_002)!;
myTown.name = myTown.name;
myTown.population = myTown.population;
myTown.printStatus();
myTown.disposeResidents(30);
myTown.printStatus();

var monstersToUnleash : [Monster?] = [Monster]();
var genericMonster : Monster? = Monster(name: "Monster James", town: myTown);
genericMonster?.scareTown();
monstersToUnleash.append(genericMonster);

var zombie : Monster? = Zombie(name: "Bob the brainless zombie", town: myTown, limping: false);
monstersToUnleash.append(zombie);

var brokenZombie : Zombie? = Zombie();
print("Does it limp?: \(brokenZombie?.limping)");
monstersToUnleash.append(brokenZombie);

var inheritedZombie : Zombie? = Zombie(name: "Zombie heritage", town: myTown);
monstersToUnleash.append(inheritedZombie);
//Class/static functions
print(Monster.noise);
print(Zombie.noise);

//Go monsters!
func unleashTheMonsters(_ monsters : [Monster?])
{
	for monster in monsters
	{
		monster?.scareTown();
		monster?.town?.printStatus();
	}
}
unleashTheMonsters(monstersToUnleash);
myTown.printStatus();

//Kill all monsters in the array
inheritedZombie = nil; //This ofcourse does not kill our zombie directly, since it's still in the array
genericMonster = nil;
zombie = nil;
brokenZombie = nil;

monstersToUnleash = []; //After clearing the array the monsters are freed (makes sense since there is a reference still to the object
