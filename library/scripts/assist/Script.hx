// API Script for Template Assist

// Set up same states as AssistStats (by excluding "var", these variables will be accessible on timeline scripts!)
// STATE_FALL -> STATE_LAND -> STATE_SHOOT -> STATE_PREJUMP -> STATE_JUMP
STATE_FALL = 0;
STATE_LAND = 1;
STATE_SHOOT = 2;
STATE_PREJUMP = 3;
STATE_JUMP = 4;

// STATE_FALL -> STATE_LAND -> STATE_SHOOT -> STATE_PREJUMP -> STATE_JUMP

var SPAWN_X_DISTANCE = 0; // How far in front of player to spawn
var SPAWN_HEIGHT = 0; // How hight up from player to spawn

// Runs on object init
function initialize(){

	// Spawn in position
	spawnPosition()

	// Add fade in effect
	startFadeIn();
}

function spawnPosition(){
	// Face the same direction as the user
	if (self.getOwner().isFacingLeft()) {
		self.faceLeft();
	}
	else {
		self.faceRight();
	}
	
	// Reposition relative to the user
	repositionToEntityEcb(self.getOwner(), self.flipX(SPAWN_X_DISTANCE), -SPAWN_HEIGHT);

	self.unattachFromFloor();
	self.updateGameObjectStats({ gravity: 1 });
}

function update(){
	switch(self.inState){
		case STATE_FALL:
			//When monstro touch the ground
			if(self.isOnFloor()){
				self.toState(STATE_LAND); 
				self.attachToFloor();
			}
			break;
		case STATE_LAND:
			if(self.finalFramePlayed){
				self.toState(STATE_SHOOT);
				shootTears();
			}
			break;
		case STATE_SHOOT:
			if(self.finalFramePlayed){
				self.toState(STATE_PREJUMP);
			}
			break;
		case STATE_PREJUMP:
			if(self.finalFramePlayed){
				self.toState(STATE_JUMP);
				self.unattachFromFloor();
				self.setXVelocity(100);
			}
			break;
		case STATE_JUMP:
			if (fadeOutComplete() && self.finalFramePlayed()) {
				// Destroy
				self.destroy();
			}
			break;
	}
}

function shootTears(){
	//TODO
}