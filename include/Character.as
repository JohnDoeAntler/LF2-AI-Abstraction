#include "Entity.as";

class Character : Entity {

	private int hp;
	private int mp;
	private int blink;
	private int team;
	private int weapon_held;
	private int weapon_type;
	private int ctimer;

	private void dependencyInjection (const Info& info) {
		this.hp = info.hp;
		this.mp = info.mp;
		this.blink = info.blink;
		this.team = info.team;
		this.weapon_held = info.weapon_held;
		this.weapon_type = info.weapon_type;
		this.ctimer = info.ctimer;
	}

	Character (const Info& info) {
		super(info);
		dependencyInjection(info);
	}

	Character (int num) {
		super(num);
		int previous = target.num;

		loadTarget(num);
		dependencyInjection(target);
		loadTarget(previous);
	}

	// getters
	int getHp() {
		return this.hp;
	}

	int getMp() {
		return this.mp;
	}

	int getBlink() {
		return this.blink;
	}

	int getTeam() {
		return this.team;
	}

	int getWeaponHeld() {
		return this.weapon_held;
	}

	int getWeaponType() {
		return this.weapon_type;
	}

	int getCTimer() {
		return this.ctimer;
	}

	bool isPlayer()				{ return this.getNum() < 8; }
	bool isStanding()			{ return this.getState() == 0; }
	bool isWalking()			{ return this.getState() == 1; }
	bool isRunning()			{ return this.getState() == 2; }
	bool isAttacking()			{ return this.getState() == 3; }
	bool isJumping()			{ return this.getState() == 4; }
	bool isDashing()			{ return this.getState() == 5; }
	bool isDashAttacking()		{ return this.getFrame() >= 90 && this.getFrame() <= 98; }
	bool isFlipping()			{ return (this.getFrame() >= 100 && this.getFrame() <= 101) || (this.getFrame() >= 108 && this.getFrame() <= 109); }
	bool isRolling()			{ return this.getState() == 6 && !this.isFlipping(); }
	bool isDefending()			{ return this.getState() == 7; }
	bool isBrokenDefend()		{ return this.getState() == 8; }
	bool isCatching()			{ return this.getState() == 9; }
	bool isCaught()				{ return this.getState() == 10; }
	bool isInjured()			{ return this.getState() == 11 || this.isStunned(); }
	bool isFalling()			{ return this.getState() == 12; }
	bool isFrozen()				{ return this.getState() == 13; }
	bool isLying()				{ return this.getState() == 14; }
	bool isStunned()			{ return this.getState() == 16; }
	bool isDrinking()			{ return this.getState() == 17; }
	bool isOnFire()				{ return this.getState() == 18; }
	bool isSkilling()			{ return this.getFrame() > 234; }
	bool isAttackable()			{ return !this.isLying() && this.blink == 0; }

}