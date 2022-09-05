// API Script for Template Assist

// Set up same states as AssistStats (by excluding "var", these variables will be accessible on timeline scripts!)
// STATE_FALL -> STATE_LAND -> STATE_SHOOT -> STATE_PREJUMP -> STATE_JUMP
STATE_FALL = 0;
STATE_LAND = 1;
STATE_SHOOT = 2;
STATE_PREJUMP = 3;
STATE_JUMP = 4;

// STATE_FALL -> STATE_LAND -> STATE_SHOOT -> STATE_PREJUMP -> STATE_JUMP

var SPAWN_X_DISTANCE = 100; // How far in front of player to spawn
var SPAWN_HEIGHT = 150; // How hight up from player to spawn

// Runs on object init
function initialize(){

	startFadeIn();

	// Face the same direction as the user
	if (self.getOwner().isFacingLeft()) {
		self.faceLeft();
	}
	
	// Reposition relative to the user
	repositionToEntityEcb(self.getOwner(), self.flipX(SPAWN_X_DISTANCE), -SPAWN_HEIGHT);

	// Add fade in effect
	self.unattachFromFloor();
	self.updateGameObjectStats({ gravity: 1 });
	self.setScaleX(2);
	self.setScaleY(2);
	
}

function update(){

	if (self.inState(STATE_FALL)) {	
		//When monstro touch the ground
		if(self.isOnFloor()){
			self.toState(STATE_LAND, "land"); 
		}
	}
	else if (self.inState(STATE_LAND)) {
		if(self.finalFramePlayed()){
			self.toState(STATE_SHOOT, "shoot");
		}
	}
	else if (self.inState(STATE_SHOOT)) {
		if(self.finalFramePlayed()){
			shootProjectiles();
			self.toState(STATE_PREJUMP, "prejump");
		}
	}
	else if (self.inState(STATE_PREJUMP)) {
		if(self.finalFramePlayed()){
			self.updateGameObjectStats({ gravity: 0.3 });
			self.setYVelocity(-20);
			self.toState(STATE_JUMP, "jump");
		}
	}
	else if (self.inState(STATE_JUMP)) {
		if (self.finalFramePlayed()) {
			// Destroy
			self.destroy();
		}
	}
}


function onTeardown(){
}

function shootProjectiles(){
	var proj1 = match.createProjectile("monstro_tear_Projectile", self);
	var proj2 = match.createProjectile("monstro_tear_Projectile", self);
}