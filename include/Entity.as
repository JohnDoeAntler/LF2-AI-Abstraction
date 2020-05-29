#include "Distance.as";
#include "Utils.as";
#include "Boundary.as";

class Entity : Position {

	protected int id;
	protected int num;
	protected bool facing;
	protected double vx;
	protected double vy;
	protected double vz;
	protected int wait_counter;
	protected int frame;
	protected int state;
	protected int type;

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

	double getVx() {
		return this.vx;
	}

	double getVy() {
		return this.vy;
	}

	double getVz() {
		return this.vz;
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

};