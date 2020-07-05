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

	// use aimer to enable the z-axis aiming of arrow spamming
	Aimer@ aimer = Aimer(me);
	aimer.autoAim(enemy);

	// arrow spamming condition
	if (
		me.distanceTo(enemy)
			.predict(3) // predict the distance after 3 game tick
			.inX(428) // the x-axis distance should be less than or equal to 428 px
			.inY(80) // the y-axis distance should be less than or equal to 80 px
			.inZ(45) // the z-axis distance should be less than or equal to 45 px
			.outX(30) // the x-axis distance should be greater than 30 px
			.inProjectileRange(
				373,
				45,
				14,
				55
			) // check is in the tangent scope of henry arrow
			.toBoolean() // stop method chaining, get the result of the calculation
	) {
		// if the AI is not facing to enemy
		if (!me.isFacing(enemy)) {
			// adjust the facing direction
			movement.face(enemy);
		} else {
			A(); // happy spamming arrow ;D
		}
	}
}