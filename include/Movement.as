#include "Entity.as";
#include "Position.as";
#include "Boundary.as";

class Movement {

	private Entity@ me;

	// dependency injection
	Movement (Entity@ me) {
		@this.me = me;
	}

	// clean buffer
	void init () {
		A(0,0);
		D(0,0);
		J(0,0);
		up(0,0);
		down(0,0);
		left(0,0);
		right(0,0);
	}

	// face to object
	void face (Position@ obj) {
		if (!me.isFacing(obj)) {
			if (me.isFacing()) {
				right();
			} else {
				left();
			}
		}
	}

	// run straight forward
	void run () {
		if (me.isFacing()) {
			left();
		} else {
			right();
		}
	}

	// stop running
	void stopRunning() {
		if (me.isRunning()) {
			if (me.isFacing()) {
				right();
			} else {
				left();
			}
		}
	}

	// jump if runninng
	void dash () {
		if (me.isRunning()) {
			J();
		}
	}

	// straight
	void DfA () {
		if (me.isFacing()) {
			DlA();
		} else {
			DrA();
		}
	}

	void DfJ () {
		if (me.isFacing()) {
			DlJ();
		} else {
			DrJ();
		}
	}

	// aim to object
	void DfA (Position@ obj) {
		if (obj.isLeftOf(me)) {
			DlA();
		} else {
			DrA();
		}
	}

	void DfJ (Position@ obj) {
		if (obj.isLeftOf(me)) {
			DlJ();
		} else {
			DrJ();
		}
	}

	// most useful function I've made lol
	void surround (Position@ obj, int x, int z, int runbuffer, int walkbuffer) {
		Boundary@ b = obj.distanceToBoundary();
		// the distance from me to boundary
		double bx = b.getX();
		double bz = b.getZ();

		// the condition of the position between me and object
		bool isTopOf = me.isTopOf(obj);
		bool isLeftOf = me.isLeftOf(obj);
		// which boundary am i nearing
		bool isNearBgLeft = b.isNearingLeft();
		bool isNearBgTop = b.isNearingTop();

		// let obj equals to o, find the nearest x point
		// x-------x
		// ----o----
		// x-------x
		bool isLeft = (isLeftOf || x > bx) && (x <= bx || !isNearBgLeft);
		bool isTop = (isTopOf || z > bz) && (z <= bz || !isNearBgTop);
		double desX = isLeft ? obj.getX() - x : obj.getX() + x;
		double desZ = isTop ? obj.getZ() - z : obj.getZ() + z;
		double buffer1 = desX - runbuffer;
		double buffer2 = desX + runbuffer;

		if (me.getX() > buffer1 && me.getX() < buffer2) {
			// stop running
			if (me.isRunning()) {
				if (me.isFacing()) {
					right();
				} else {
					left();
				}
			} else {
				if (desX + walkbuffer < me.getX() || desX - walkbuffer > me.getX()) {
					if (desX < me.getX()) {
						left(1,1);
					} else {
						right(1,1);
					}
				}
			}
		} else if (desX < me.getX()) {
			left();
		} else {
			right();
		}

		// prevent wiggling
		if (desZ + 2 < me.getZ() || desZ - 2 > me.getZ()) {
			if (desZ < me.getZ()) {
				up();
			} else {
				down();
			}
		}
	}

	void surround (Position@ obj, int x, int z) {
		this.surround(obj, x, z, 25, 3);
	}

	// run straight forward object
	void trace (Position@ obj) {
		if (me.isFacing(obj)) {
			run();
		} else {
			face(obj);
		}

		if (!obj
			.distanceTo(me)
			.inZ(14)
			.toBoolean()
		) {
			if (me.isTopOf(obj)) {
				down();
			} else {
				up();
			}
		}
	}

	// run away from object.
	void dodge (Position@ obj) {
		this.surround(obj, getBoundaryWidth() - 80, getBoundaryZwidth() - 20);
		this.dash();
	}
	
	// goto specific position
	void goto (int x, int z) {
		if (me.getX() > x) {
			left();
		} else {
			right();
		}

		if (me.getZ() > z) {
			up();
		} else {
			down();
		}
	}

	// catch object
	void goto (Position@ obj) {
		this.surround(obj, 30, 0, 25, 0);
		if (me
			.distanceTo(obj)
			.outX(80)
			.outZ(25)
			.toBoolean()
		) {
			this.dash();
		}
	}

	// z approach
	void approach (Position@ obj, int buffer) {
		if (
			obj
				.distanceTo(me)
				.outZ(buffer)
				.toBoolean()
		) {
			if (obj.isTopOf(me)) {
				up();
			} else {
				down();
			}
		}
	}

	// z leave
	void leave (Position@ obj, int buffer) {
		if (
			obj
				.distanceTo(me)
				.outZ(buffer)
				.toBoolean()
		) {
			if (obj.isBottomOf(me)) {
				up();
			} else {
				down();
			}
		}
	}

}