#include "Entity.as";

class Attack : Entity {

	private int team;

	private void dependencyInjection (const Info& info) {
		this.team = target.team;
	}

	Attack (const Info& info) {
		super(info);
		dependencyInjection(info);
	}

	Attack (int num) {
		super(num);
		int previous = target.num;

		loadTarget(num);
		dependencyInjection(target);
		loadTarget(previous);
	}

	int getTeam () {
		return this.team;
	}

	bool isAttacking() { return this.getState() == 3000 || this.getState() == 3005 || this.getState() == 3006; }

};