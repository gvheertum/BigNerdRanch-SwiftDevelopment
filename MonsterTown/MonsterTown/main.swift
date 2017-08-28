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


var myTown : Town = Town();
myTown.printStatus();
myTown.disposeResidents(30);
myTown.printStatus();

var monstersToUnleash : [Monster] = [Monster]();
var genericMonster : Monster = Monster();
genericMonster.town = myTown;
genericMonster.scareTown();
monstersToUnleash.append(genericMonster);

var zombie : Monster = Zombie();
zombie.name = "Bob the brainless zombie";
zombie.town = myTown;
monstersToUnleash.append(zombie);

//Class/static functions
Monster.makeNoise();
Zombie.makeNoise();

//Go monsters!
func unleashTheMonsters(_ monsters : [Monster])
{
	for monster in monsters
	{
		monster.scareTown();
		monster.town?.printStatus();
	}
}
unleashTheMonsters(monstersToUnleash);
myTown.printStatus();
