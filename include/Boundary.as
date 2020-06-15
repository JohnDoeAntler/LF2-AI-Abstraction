#include "Position.as";
#include "Stringifiable.as";

int getBoundaryWidth () {
	return mode == 1 ? stage_bound : bg_width;
}

int getBoundaryZwidth () { 
	return bg_zwidth2 - bg_zwidth1;
}

class Boundary : IStringifiable {

	private Position@ pivot;

	Boundary (Position@ pivot) {
		@this.pivot = pivot;
	}

	// get distance from pivot to nearest boundary (x-axis)
	int getX () {
		int width = getBoundaryWidth();
		return 2 * this.pivot.getX() > width ? width - this.pivot.getX() : this.pivot.getX();
	}

	// get distance from pivot to nearest boundary (z-axis)
	int getZ () {
		if (this.pivot.getZ() > ((bg_zwidth1 + bg_zwidth2) / 2)) {
			return bg_zwidth2 - this.pivot.getZ();
		} else {
			return this.pivot.getZ() - bg_zwidth1;
		}
	}

	// is nearing left or right boundary
	// return true if nearing left
	// return false if nearing right
	bool isNearingLeft () {
		return this.pivot.getX() < getBoundaryWidth() / 2;
	}

	// is nearing top or bottom boundary
	// return true if nearing top
	// return false if nearing bottom
	bool isNearingTop () {
		return this.pivot.getZ() < ((bg_zwidth1 + bg_zwidth2) / 2);
	}

	string toString() {
		return "boundary: [ x: " + this.getX() + ", z: " + this.getZ() + ", isNearingLeft: " + this.isNearingLeft() + ", isNearingTop: " + this.isNearingTop() + " ]";
	}

}