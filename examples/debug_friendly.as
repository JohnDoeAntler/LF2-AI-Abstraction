#include "include/index.as";

void id () {
	// use target loader to retrieve all objects in the game
	TargetLoader@ tl = TargetLoader();
	tl.load();

	// extract ai and nearest enemy from target loader
	Entity@ me = tl.getAI();
	Entity@ enemy = tl.getNearestEnemy();

	// initialize movement
	Movement@ movement = Movement(Entity(self));
	movement.init();

	print("AI's ");
	println(me); // print the current AI position
	print("enemy's ");
	println(enemy); // print the enemy positoin
	println(me.distanceTo(enemy)); // print the distance between the AI and the enemy
	println();
}