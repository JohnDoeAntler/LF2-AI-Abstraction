#include "PredictedRange.as";

class Predictor {

	// dependency
	private Entity@ entity;
	private int wait_counter;

	Predictor(Entity@ e) {
		@this.entity = e;
		this.wait_counter = e.getWaitCounter();
	}

	private const Frame@ getFrame (int frame) {
		return @game.objects[entity.getNum()].data.frames[frame];
	}

	// predict itr
	PredictedRange@ predictInteraction (Range@ bdy) {
		array<int> frames;
		int frame = this.entity.getFrame();

		double x_displacement = 0;
		double y_displacement = 0;
		double z_displacement = 0;
		double dvx = entity.getVx() * (entity.isFacing() ? -1 : 1);
		double dvy = entity.getVy();
		double dvz = entity.getVz();
		double y = entity.getY();
		int timer = 0;
		bool isFirst = true;

		// loop frame
		for (const Frame@ obj = @getFrame(frame); frames.find(frame) == -1; @obj = getFrame(frame = obj.next)) {
			frames.insertLast(frame);
			// loop unit tick
			for (int i = frame == this.entity.getFrame() ? this.wait_counter : 0; i < obj.wait + 1; i++) {
				// loop itr
				if (obj.itr_count > 0) {
					// is attacking state
					bool isAttacking = false;
					// check current frame is attacking or not
					for (int j = 0; j < obj.itr_count; j++) {
						const Itr@ itr = obj.itrs[j];
						if (
							itr.kind != 1
							&& itr.kind != 2
							&& itr.kind != 3
							&& itr.kind != 7
							&& itr.kind != 8
						) {
							isAttacking = true;
							break;
						}
					}

					Range@ predicted = itrToRange(entity, obj) + Position(int(x_displacement), int(y_displacement), int(z_displacement)) * Position(entity.isFacing() ? -1 : 1, 1, 1);

					if (isAttacking && predicted.isOverlapping(bdy)) {
						return PredictedRange(
							predicted.getX1(),
							predicted.getX2(),
							predicted.getY1(),
							predicted.getY2(),
							predicted.getZ1(),
							predicted.getZ2(),
							timer - (isFirst ? 0 : 1)
						);
					} else if (isAttacking && isFirst) {
						isFirst = false;
					}
				}

				bool isFirstTU = frame == this.entity.getFrame() && this.wait_counter == i;

				// x
				if (obj.dvx != 0 && obj.dvx > dvx) { // if current frame have dvx and frame dvx greather than previos frame's dvx
					dvx = obj.dvx;
				} else if (y + y_displacement == 0 && dvx != 0 && !isFirstTU) { // if on ground and moving and not first tick unti
					// appraoch to zero
					if (dvx > 0) {
						dvx -= 1;
						if (dvx < 0) {
							dvx = 0;
						}
					} else {
						dvx -= 1;
						if (dvx > 0) {
							dvx = 0;
						}
					}
				}
				
				// gravity acceleratoin
				if (y + y_displacement < 0 && !isFirstTU) { // in air
					dvy += 1.7;
				}
				// sum dvy if frame contain dvy value
				if (obj.dvy != 0) {
					dvy += obj.dvy;
				} 

				x_displacement += dvx;
				y_displacement += dvy;
				z_displacement += dvz;

				timer++;
			}

			// if current is last frame in cycle
			if (obj.next == 999 || obj.next == 0) {
				return PredictedRange(
					-1,
					-1,
					-1,
					-1,
					-1,
					-1,
					-1
				);
			}
		}

		// should never be reached
		return null;
	}

	// return bdy
	PredictedRange@ predictBody () {
		array<int> frames;
		int frame = this.entity.getFrame();

		double x_displacement = 0;
		double y_displacement = 0;
		double z_displacement = 0;
		double dvx = entity.getVx() * (entity.isFacing() ? -1 : 1);
		double dvy = entity.getVy();
		double dvz = entity.getVz();
		double y = entity.getY();
		int timer = 0;

		// loop frame
		for (const Frame@ obj = @getFrame(frame); frames.find(frame) == -1; @obj = getFrame(frame = obj.next)) {
			frames.insertLast(frame);
			// loop unit tick
			for (int i = frame == this.entity.getFrame() ? this.wait_counter : 0; i < obj.wait + 1; i++) {
				if (obj.bdy_count > 0) {
					// is attacking state
					Range@ predicted = bdyToRange(entity, obj) + Position(int(x_displacement), int(y_displacement), int(z_displacement)) * Position(entity.isFacing() ? -1 : 1, 1, 1);

					return PredictedRange(
						predicted.getX1(),
						predicted.getX2(),
						predicted.getY1(),
						predicted.getY2(),
						predicted.getZ1(),
						predicted.getZ2(),
						timer
					);
				}

				bool isFirstTU = frame == this.entity.getFrame() && this.wait_counter == i;

				// x
				if (obj.dvx != 0 && obj.dvx > dvx) { // if current frame have dvx and frame dvx greather than previos frame's dvx
					dvx = obj.dvx;
				}

				// gravity acceleratoin
				if (y + y_displacement < 0 && !isFirstTU) { // in air
					dvy += 1.7;
				}
				// sum dvy if frame contain dvy value
				if (obj.dvy != 0) {
					dvy += obj.dvy;
				} 

				x_displacement += dvx;
				y_displacement += dvy;
				z_displacement += dvz;

				timer++;
			}

			// if current is last frame in cycle
			if (obj.next == 999 || obj.next == 0) {
				return PredictedRange(
					-1,
					-1,
					-1,
					-1,
					-1,
					-1,
					-1
				);
			}
		}

		// should never be reached
		return null;
	}

}