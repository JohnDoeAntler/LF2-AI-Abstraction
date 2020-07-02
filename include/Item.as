#include "Entity.as";

class Item : Entity {

	Item (const Info& info) {
		super(info);
	}

	Item (int num) {
		super(num);
	}

	bool isDropping()		{return this.getState() == 1000 || this.getState() == 2000;}
	bool isOnHand()			{return this.getState() == 1001 || this.getState() == 2001;}
	bool isBeingThrown()	{return this.getState() == 1002;}
	bool isOnGround()		{return this.getState() == 1003 || this.getState() == 1004 || this.getState() == 2004;}
	bool isAttacking()		{return this.getState() == 2000 || this.isBeingThrown();}

}