#include "Position.as";

class Distance {
	
	private Position@ pivot = null;

	private Position@ target = null;

	private bool result = true;

	Distance (
		Position@ pivot,
		Position@ target
	) {
		@this.pivot = pivot;
		@this.target = target;
	}

	double getX () { return abs(pivot.getX() - target.getX()); }

	double getY () { return abs(pivot.getY() - target.getY()); }

	double getZ () { return abs(pivot.getZ() - target.getZ()); }

	// method chaining
	// range condition
	Distance@ inX(int val) {
		if (this.result && this.getX() > val) {
			this.result = false;
		}
		return @this;
	}

	Distance@ inY(int val) {
		if (this.result && this.getY() > val) {
			this.result = false;
		}
		return @this;
	}

	Distance@ inZ(int val) {
		if (this.result && this.getZ() > val) {
			this.result = false;
		}
		return @this;
	}

	Distance@ outX(int val) {
		if (this.result && this.getX() <= val) {
			this.result = false;
		}
		return @this;
	}

	Distance@ outY(int val) {
		if (this.result && this.getY() <= val) {
			this.result = false;
		}
		return @this;
	}

	Distance@ outZ(int val) {
		if (this.result && this.getZ() <= val) {
			this.result = false;
		}
		return @this;
	}

	// diagonal condition
	Distance@ inProjectileRange (int x, int z) {
		return inProjectileRange(x, z, 14, 0);
	}

	Distance@ inProjectileRange (int x, int z, int zwidth, int offset) {
		double tan = double(z) / double(x);
		double pz = tan * (this.getX() - double(offset));

		// pz + zwidth > this.distanceTo(obj).z()
		// && pz - zwidth < this.distanceTo(obj).z()
		// || obj.inRangeZ(this, zwidth)

		if (this.result && 
			!(this
				.outZ(int(pz - zwidth))
				.inZ(int(pz + zwidth))
				.toBoolean()
			|| this
				.inZ(zwidth)
				.toBoolean()
			)
		) {
			this.result = false;
		}

		return @this;
	}

	bool toBoolean () {
		bool ret = this.result;
		this.result = true;
		return ret;
	}

	string toString () {
		return "distance: [ x: " + this.getX() + ", y: " + this.getY() + ", z: " + this.getZ() +" ]";
	}

	// weighted total distance
	double total (int x, int y, int z) { return this.getX() * x + this.getY() * y + this.getZ() * z; }

	// preferred weights
	double total () { return this.total(1,1,3); }

}