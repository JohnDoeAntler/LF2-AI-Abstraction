#include "Distance.as";
#include "Utils.as";
#include "Boundary.as";

class Entity : Position {

	protected int id;
	protected int num;
	protected bool facing;
	protected int wait_counter;
	protected int frame;
	protected int state;
	protected int type;

	/*Character*/
	private int hp;
	private int mp;
	private int blink;
	private int team;
	private int weapon_held;
	private int weapon_type;
	private int ctimer;

	protected void dependencyInjection (const Info& info) {
		this.id = info.id;
		this.num = info.num;
		this.facing = info.facing;
		this.vx = info.x_velocity;
		this.vy = info.y_velocity;
		this.vz = info.z_velocity;
		this.wait_counter = info.wait_counter;
		this.frame = info.frame;
		this.state = info.state;
		this.type = info.type;

		/*Character*/
		this.hp = info.hp;
		this.mp = info.mp;
		this.blink = info.blink;
		this.team = info.team;
		this.weapon_held = info.weapon_held;
		this.weapon_type = info.weapon_type;
		this.ctimer = info.ctimer;
	}

	// From angelscript documenttation:
	// One constructor cannot call another constructor.
	// If you wish to share implementations in the constructors you should use a specific method for that.
	Entity (const Info& info) {
		super(num);
		Entity::dependencyInjection(info);
	};

	Entity (int num) {
		super(num);
		int previous = target.num;

		loadTarget(num);
		Entity::dependencyInjection(target);
		loadTarget(previous);
	}

	// getters
	int getId() {
		return this.id;
	}

	int getNum() {
		return this.num;
	}

	bool isFacing() {
		return this.facing;
	}

	int getWaitCounter() {
		return this.wait_counter;
	}

	int getFrame () {
		return this.frame;
	}

	int getState () {
		return this.state;
	}

	int getType () {
		return this.type;
	}

	// facing detection
	bool isFacing (Position@ obj) {
		return (this.facing && this.isRightOf(obj)) || (!this.facing && this.isLeftOf(obj)) || (this.getX() - obj.getX() == 0);
	}

	/*Character*/
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
	bool isAttacking()			{ return this.getState() == 3 || this.getState() == 3000 || this.getState() == 3005 || this.getState() == 3006 || this.getState() == 2000 || this.isBeingThrown(); }
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

	/*Attack*/
//	bool isAttacking() { return this.getState() == 3000 || this.getState() == 3005 || this.getState() == 3006; }

	
	//Source: Nucleargod's Woody AI
	bool isChee(){
		return this.getType() == 3;
	}
	
	
	bool isBall(){
		return this.getType() == 4;
	}
	
	bool isChasing(){
		if(isAttacking()){
			if(this.getId() == 215) return true;						//Dennis
			else if(this.getId() == 214) return true;					//John
			else if(this.getId() == 219 || this.getId() == 220) return true;	//Jan
			else if(this.getId() == 221 || this.getId() == 222) return true;	//Firzen
			else if(this.getId() == 225) return true;					//Julian
			else if(this.getId() == 228) return true;					//Bat
			else return false;
		}
		else return false;
	}
	
	bool isCure(){
		if(this.getId() == 200 && this.getFrame() >= 50 && this.getFrame() < 55) return true;	//John
		else if(this.getId() == 220 && isAttacking()) return true;			//Jan
		else return false;
	}
	
	bool isWall(){	//John ForceField
		if(this.getId() == 200 && this.getFrame() >= 60 && this.getFrame() <= 65) return true;
		else return false;
	}
	
	bool isPassable(){
		if(this.getId() == 212 && this.getState() == 3000) return false;	//Freeze colume
		else return true;
	}
	
	bool isHitBreakable(){
		if(!isChee()) return true;
		else if(this.getState() == 3005 || this.getState() == 3006) return false;
		else if(this.getId() == 211) return false;					//Fire
		else if(isWall()) return false;						//John ForceField
		else if(this.getId() == 212 && this.getFrame() > 100) return false;		//Freeze whirlwind
		else if(this.getId() == 229) return false;					//Julian col & exp & Bomb
		else return true;
	}
	
	bool isWind(){
		if(this.getState() == 3006) return true;
		else return false;
	}
	
	bool isBreakable(){
		if(this.getId() == 211) return false;							//Fire
		else if(this.getId() == 212 && this.getFrame() > 100) return false;		//Freeze whirlwind
		else if(this.getId() == 229 && this.getFrame() > 5) return false;		//Julian col & exp
		else return true;
	}
	
	bool isDefendable(){
		if(this.getId() == 212 && this.getFrame() >= 150) return false;			//Freeze whirlwind
		else if(this.getId() == 229 && this.getFrame() < 100) return false;		//Julian col & Bomb
		else return true;
	}
	
	bool isFire(){
		if(this.getId() == 210 || this.getId() == 211 || this.getId() == 221) return true;
		else return false;
	}
	
	bool isIce(){
		if(this.getId() == 209 || (this.getId() == 212 && !this.isWind())|| this.getId() == 213 || this.getId() == 222) return true;
		else return false;
	}

	/*Item*/
	bool isDropping()		{return this.getState() == 1000 || this.getState() == 2000;}
	bool isOnHand()			{return this.getState() == 1001 || this.getState() == 2001;}
	bool isBeingThrown()	{return this.getState() == 1002;}
	bool isOnGround()		{return this.getState() == 1003 || this.getState() == 1004 || this.getState() == 2004;}


};