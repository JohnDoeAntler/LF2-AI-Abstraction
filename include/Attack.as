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

}
