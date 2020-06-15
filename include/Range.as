#include "Entity.as";
#include "Stringifiable.as";

Range@ itrToRange (Entity@ entity, const Frame@ frame) {
	return Range(
		frame.itr_x - frame.centerx,
		frame.itr_x + frame.itr_w - frame.centerx,
		frame.itr_y - frame.centery,
		frame.itr_y + frame.itr_h - frame.centery,
		-14,
		14
	) + entity;
}

Range@ bdyToRange (Entity@ entity, const Frame@ frame) {
	return Range(
		frame.bdy_x - frame.centerx,
		frame.bdy_x + frame.bdy_w - frame.centerx,
		frame.bdy_y - frame.centery,
		frame.bdy_y + frame.bdy_h - frame.centery,
		0,
		0
	) + entity;
}

int min (int a, int b) {
	return a > b ? b : a;
}

int max (int a, int b) {
	return a > b ? a : b;
}

class Range : IStringifiable {

	//    x1, y1, z1 +--------+ x2, y1, z1
	//              /|       /|
	//             / |      / |
	// x1, y1, z2 +--------+ x2, y1, z2
	//            |  |     |  |
	//    x1, y2, z1 +-----|--+ x2, y2, z1
	//            | /      | /
	//            |/       |/
	// x1, y2, z2 +--------+ x2, y2, z2
	protected int x1;
	protected int x2;
	protected int y1;
	protected int y2;
	protected int z1;
	protected int z2;

	Range (
		int x1,
		int x2,
		int y1,
		int y2,
		int z1,
		int z2
	) {
		this.x1 = x1;
		this.x2 = x2;
		this.y1 = y1;
		this.y2 = y2;
		this.z1 = z1;
		this.z2 = z2;
	}

	int getX1() {
		return this.x1;
	}

	int getX2() {
		return this.x2;
	}

	int getY1() {
		return this.y1;
	}
	
	int getY2() {
		return this.y2;
	}

	int getZ1() {
		return this.z1;
	}

	int getZ2() {
		return this.z2;
	}

	Range () {
		x1 = x2 = y1 = y2 = z1 = z2 = -1;
	}

	bool isEmpty () {
		return x1 == -1
			&& x2 == -1
			&& y1 == -1
			&& y2 == -1
			&& z1 == -1
			&& z2 == -1;
	}

	bool isOverlapping (Range@ range) {
		return @range !is null
		&& !this.isEmpty() 
		&& (
			this.x1 <= range.x2
			&& this.x2 >= range.x1
		) && (
			this.y1 <= range.y2
			&& this.y2 >= range.y1
		) && (
			this.z1 <= range.z2
			&& this.z2 >= range.z1
		);
	}

	Range@ getIntersection (Range@ range) {
		return Range(
			max(this.x1, range.x1),
			min(this.x2, range.x2),
			max(this.y1, range.y1),
			min(this.y2, range.y2),
			max(this.z1, range.z1),
			min(this.z2, range.z2)
		);
	}

	// operator
	Range@ opAdd(Entity@ other) {
		return Range(
			other.getX() + (other.isFacing() ? -this.x2 : this.x1),
			other.getX() + (other.isFacing() ? -this.x1 : this.x2),
			this.y1 + other.getY(),
			this.y2 + other.getY(),
			this.z1 + other.getZ(),
			this.z2 + other.getZ()
		);
	}

	Range@ opAdd(Position@ other) {
		return Range(
			this.x1 + other.getX(),
			this.x2 + other.getX(),
			this.y1 + other.getY(),
			this.y2 + other.getY(),
			this.z1 + other.getZ(),
			this.z2 + other.getZ()
		);
	}

	string toString () {
		return "range: [ x1: " + this.x1 + ", x2: " + this.x2 + ", y1: " + this.y1 + ", y2: " + this.y2 + ", z1: " + this.z1 + ", z2: " + this.z2 + " ]";
	}

}
