#include "Entity.as";
#include "Distance.as";
#include "Utils.as";

// global compare function
bool distanceComparator (int a, int b) {
	return Entity(a).distanceToSelf().total() < Entity(b).distanceToSelf().total();
}

// for character
bool distanceComparator (Entity@ a, Entity@ b) {
	return a.distanceToSelf().total() < b.distanceToSelf().total();
}

enum Type {
	CHARACTER,
	LIGHTWEAPON,
	HEAVYWEAPON,
	ATTACK,
	THROWWEAPON,
	CRIMINAL,
	DRINK,
	// additional type
	ENEMY,
	TEAMMATE,
	ITEM
}

class TargetLoader {

	// object list that exclude self
	// the object list will be grouped by object type
	private array<array<int>> arr(10, array<int>(0));

	void load () {
		// loop 400 times to loop through all objects in game.
		for (int i = 0; i < 400; i++) {
			// load target.
			loadTarget(i);
			// prevent target being modified
			Entity@ tmp = Entity(target);

			// is exist and alive.
			if (game.exists[i] && game.objects[i].hp > 0) {
				if (self.num != i) {
					// if the target type equals to character
					if (target.type == CHARACTER) {
						// if target's team is identical to self's team
						if (self.team == target.team) {
							// insert into teammate
							arr[TEAMMATE].insertLast(i);
						} else {
							// insert into enemy
							arr[ENEMY].insertLast(i);
						}
					} else if ( // if the target's type is sub set of item.
						target.type == LIGHTWEAPON
						|| target.type == HEAVYWEAPON
						|| target.type == THROWWEAPON
						|| target.type == DRINK
					) {
						// insert into item
						arr[ITEM].insertLast(i);
					}
					// insert into correspond array
					arr[target.type].insertLast(i);
				}
			}
		}

		// sort characters
		arr[0].sort(function (a, b) {
			Entity@ tmpA = Entity(a);
			Entity@ tmpB = Entity(b);
			return tmpA.isLying() 
				? tmpB.isLying() 
					? distanceComparator(tmpA, tmpB) 
					: false 
				: tmpB.isLying() 
					? true 
					: distanceComparator(tmpA, tmpB); 
		});

		// sort non-character objects
		for (uint i = 1; i < arr.length(); i++) {
			if (arr[i].length() > 0) {
				arr[i].sort(function (a, b) { return distanceComparator(a, b); });
			}
		}
	}

	bool hasLightWeapon () 	{ return arr[1].length() > 0; }
	bool hasHeavyWeapon () 	{ return arr[2].length() > 0; }
	bool hasAttack () 		{ return arr[3].length() > 0; }
	bool hasThrowWeapon () 	{ return arr[4].length() > 0; }
	bool hasCriminal () 	{ return arr[5].length() > 0; }
	bool hasDrink () 		{ return arr[6].length() > 0; }
	bool hasEnemy () 		{ return arr[7].length() > 0; }
	bool hasTeammate () 	{ return arr[8].length() > 0; }
	bool hasItem () 		{ return arr[9].length() > 0; }

	array<Entity@> getLightWeapons () {
		array<Entity@> arr;
 		for (uint i = 0; i < this.arr[1].length(); i++) {
			arr.insertLast(Entity(this.arr[1][i]));
		}
		return arr;
	}
	
	array<Entity@> getHeavyWeapons () {
		array<Entity@> arr;
 		for (uint i = 0; i < this.arr[2].length(); i++) {
			arr.insertLast(Entity(this.arr[2][i]));
		}
		return arr;
	}
	
	array<Entity@> getAttacks () {
		array<Entity@> arr;
 		for (uint i = 0; i < this.arr[3].length(); i++) {
			arr.insertLast(Entity(this.arr[3][i]));
		}
		return arr;
	}
	
	array<Entity@> getThrowWeapons () {
		array<Entity@> arr;
 		for (uint i = 0; i < this.arr[4].length(); i++) {
			arr.insertLast(Entity(this.arr[4][i]));
		}
		return arr;
	}
	
	array<Entity@> getCriminals () {
		array<Entity@> arr;
 		for (uint i = 0; i < this.arr[5].length(); i++) {
			arr.insertLast(Entity(this.arr[5][i]));
		}
		return arr;
	}
	
	array<Entity@> getDrinks () {
		array<Entity@> arr;
 		for (uint i = 0; i < this.arr[6].length(); i++) {
			arr.insertLast(Entity(this.arr[6][i]));
		}
		return arr;
	}
	
	array<Entity@> getEnemies () {
		array<Entity@> arr;
 		for (uint i = 0; i < this.arr[7].length(); i++) {
			arr.insertLast(Entity(this.arr[7][i]));
		}
		return arr;
	}
	
	array<Entity@> getTeammates () {
		array<Entity@> arr;
 		for (uint i = 0; i < this.arr[8].length(); i++) {
			arr.insertLast(Entity(this.arr[8][i]));
		}
		return arr;
	}
	
	array<Entity@> getItems () {
		array<Entity@> arr;
 		for (uint i = 0; i < this.arr[9].length(); i++) {
			arr.insertLast(Entity(this.arr[9][i]));
		}
		return arr;
	}

	Entity@ getAI() {
		return Entity(self.num);
	}

	Entity@ getNearestEnemy () {
		if (this.hasEnemy()) {
			return Entity(this.arr[ENEMY][0]);
		}
		return null;
	}
	
	Entity@ getNearestTeammate () {
		if (this.hasTeammate()) {
			return Entity(this.arr[TEAMMATE][0]);
		}
		return null;
	}

	Entity@ getNearestAttack () {
		if (this.hasAttack()) {
			return Entity(this.arr[ATTACK][0]);
		}
		return null;
	}

	Entity@ getNearestCriminal () {
		if (this.hasCriminal()) {
			return Entity(this.arr[CRIMINAL][0]);
		}
		return null;
	}

	Entity@ getNearestItem () {
		if (this.hasItem()) {
			return Entity(this.arr[ITEM][0]);
		}
		return null;
	}

	Entity@ getNearestLightWeapon () {
		if (this.hasLightWeapon()) {
			return Entity(this.arr[LIGHTWEAPON][0]);
		}
		return null;
	}

	Entity@ getNearestHeavyWeapon () {
		if (this.hasHeavyWeapon()) {
			return Entity(this.arr[HEAVYWEAPON][0]);
		}
		return null;
	}

	Entity@ getNearestThrowWeapon () {
		if (this.hasThrowWeapon()) {
			return Entity(this.arr[THROWWEAPON][0]);
		}
		return null;
	}

	Entity@ getNearestDrink () {
		if (this.hasDrink()) {
			return Entity(this.arr[DRINK][0]);
		}
		return null;
	}

}