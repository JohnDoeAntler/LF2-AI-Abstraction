#include "include/index.as";

void id () {
	// use target loader to retrieve all objects in the game
	TargetLoader@ tl = TargetLoader();
	tl.load();

	// extract ai and nearest enemy from target loader
	Entity@ me = tl.getAI();
	Entity@ enemy = tl.getNearestEnemy();

	// initialize movement
	Movement@ movement = Movement(me);
	movement.init();

	// surround by keeping distance with
	// x-axis distance: 250px
	// z-axis distance: 40px
	// run buffer: 22px
	// walk buffer: 9px
	movement.surround(enemy, 250, 40, 22, 9);
}