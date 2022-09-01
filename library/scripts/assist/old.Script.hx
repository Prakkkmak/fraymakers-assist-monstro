// API Script for Template Assist

// Set up same states as AssistStats (by excluding "var", these variables will be accessible on timeline scripts!)
// STATE_FALL -> STATE_LAND -> STATE_SHOOT -> STATE_PREJUMP -> STATE_JUMP
STATE_FALL = 0;
STATE_LAND = 1;
STATE_SHOOT = 2;
STATE_PREJUMP = 3;
STATE_JUMP = 4;

// STATE_FALL -> STATE_LAND -> STATE_SHOOT -> STATE_PREJUMP -> STATE_JUMP

var SPAWN_X_DISTANCE = 30; // How far in front of player to spawn
var SPAWN_HEIGHT = 100; // How hight up from player to spawn

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
				self.toState(STATE_SHOOT);
			}
			break;
		case STATE_PREJUMP:
			if(self.finalFramePlayed){
				self.toState(STATE_SHOOT);
			}
			break;
		case STATE_JUMP:
			break;
	}


	// OLD =>
	// Behavior for each state
	if (self.inState(STATE_IDLE)) {
		if (self.finalFramePlayed()) {
			// Bounce into air, activate gravity, and switch to jump state
			self.unattachFromFloor();
			self.setYVelocity(-20);
			self.updateGameObjectStats({ gravity: 1 });
			self.toState(STATE_JUMP); 
		}
	} else if (self.inState(STATE_JUMP)) {
		// Wait until assist starts to fall
		if (self.getYVelocity() >= 0) {
			// Move to fall state
			self.toState(STATE_FALL); 
		}
	} else if (self.inState(STATE_FALL)) {
		// Wait until assist lands
		if (self.isOnFloor()) {
			// Fire two projectiles and switch to slam state
			var proj1 = match.createProjectile("assisttemplateProjectile", self);
			var proj2 = match.createProjectile("assisttemplateProjectile", self);
			proj2.flip(); // Flip the other projectile the opposite way
			self.toState(STATE_SLAM); 
		}
	} else if (self.inState(STATE_SLAM)) {
		if (self.finalFramePlayed()) {
			// Move to outro state and start fading away
			self.toState(STATE_OUTRO); 
			startFadeOut();
		}
	} else if (self.inState(STATE_OUTRO)) {
		if (fadeOutComplete() && self.finalFramePlayed()) {
			// Destroy
			self.destroy();
		}
	}
}


function onTeardown(){
}

function shootTears(){
	//TODO
}