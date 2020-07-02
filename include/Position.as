#include "Distance.as";
#include "Stringifiable.as";

class Position : IStringifiable {

	protected int x;
	protected int y;
	protected int z;
	protected double vx;
	protected double vy;
	protected double vz;

	Position (
		int x,
		int y,
		int z
	) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	protected void dependencyInjection (const Info& info) {
		this.x = info.x;
		this.y = info.y;
		this.z = info.z;
	}

	Position (const Info& info) {
		Position::dependencyInjection(info);
	}

	Position (int num) {
		int previous = target.num;

		loadTarget(num);
		Position::dependencyInjection(target);
		loadTarget(previous);
	}

	// instance member getter
	int getX() {
		return this.x;
	}

	int getY() {
		return this.y;
	}

	int getZ() {
		return this.z;
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

	double getPx(double weight) {
		return this.x + this.vx * weight;
	}

	double getPy(double weight) {
		return this.y + this.vy * weight;
	}

	double getPz(double weight) {
		return this.z + this.vz * weight;
	}

	// direction
	bool isLeftOf (Position@ pos) {
		return this.x < pos.x;
	}

	bool isRightOf (Position@ pos) {
		return this.x > pos.x;
	}

	bool isTopOf (Position@ pos) {
		return this.z < pos.z;
	}

	bool isBottomOf (Position@ pos) {
		return this.z > pos.z;
	}

	// By Fonix
	bool isApproaching (Position@ pos) {
		return this.getVx() == 0 ? false : pos.isLeftOf(@this) == this.getVx() < 0;
	}

	// By Fonix
	bool isLeaving (Position@ pos) {
		return this.getVx() == 0 ? false : pos.isLeftOf(@this) == this.getVx() > 0;
	}

	// distance
	Distance@ distanceTo (Position@ pos) {
		return Distance(@this, pos);
	}

	Distance@ distanceToSelf () {
		return Distance(@this, Position(self));
	}

	// boundary detection
	Boundary@ distanceToBoundary () {
		return Boundary(@this);
	}

	bool inRangeX (Position@ pos, int val) {
		return distanceTo(pos).inX(val).toBoolean();
	}

	bool inRangeY (Position@ pos, int val) {
		return distanceTo(pos).inY(val).toBoolean();
	}

	bool inRangeZ (Position@ pos, int val) {
		return distanceTo(pos).inZ(val).toBoolean();
	}

	bool inProjectileRange (Position@ pos, int x, int z) {
		return distanceTo(pos).inProjectileRange(x, z).toBoolean();
	}

	bool inProjectileRange (Position@ pos, int x, int z, int zwidth, int offset) {
		return distanceTo(pos).inProjectileRange(x, z, zwidth, offset).toBoolean();
	}

	// operator
	Position@ opMul(Position@ pos) {
		return Position(
			this.x * pos.x,
			this.y * pos.y,
			this.z * pos.z
		);
	}

	string toString() {
		return "position x: [ " + this.x + ", y: " + this.y + ", z: " + this.z + " ]";
	}

}