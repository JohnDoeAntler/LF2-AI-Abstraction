#include "Entity.as";
#include "Position.as";

class Aimer {

	private Entity@ pivot;

	// dependency injection
	Aimer (Entity@ pivot) {
		@this.pivot = pivot;
	}

	// auto adjust the directoin if next frame has opoint frame element.
	void autoAim(Position@ target) {
		if (this.isAiming()) {
			if (pivot
				.distanceTo(target)
				.outZ(14)
				.toBoolean()
			) {
				if (pivot.isTopOf(target)) {
					down(1, 1);
				} else {
					up(1, 1);
				}
			} 
		}
	}

	// check is aimer auto aiming
	bool isAiming () {
		return game.objects[pivot.getNum()].data.frames[game.objects[pivot.getNum()].data.frames[pivot.getFrame()].next].opoint.kind == 1;
	}

}