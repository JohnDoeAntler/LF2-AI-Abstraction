class PredictedRange : Range {

	private int timer;

	PredictedRange (
		int x1,
		int x2,
		int y1,
		int y2,
		int z1,
		int z2,
		int timer
	) {
		super(x1, x2, y1, y2, z1, z2);
		this.timer = timer;
	}

	bool isEmpty() {
		return this.timer == -1;
	}

	int getTimer () {
		return this.timer;
	}

	string toString() {
		return "predicted range: [ x1: " + this.x1 + ", x2: " + this.x2 + ", y1: " + this.y1 + ", y2: " + this.y2 + ", z1: " + this.z1 + ", z2: " + this.z2 + ", timer: " + this.timer + " ]";
	}

}