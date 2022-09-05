// API Script for Assist Template Projectile

function initialize(){
	// Set up wall and ground hit event
	self.addEventListener(EntityEvent.COLLIDE_WALL, self.destroy(), { persistent: true });
	self.addEventListener(EntityEvent.COLLIDE_GROUND, self.destroy(), { persistent: true });
	// Set up horizontal reflection
	// enableReflectionListener({ mode: "X", replaceOwner: true });
	self.updateGameObjectStats({ gravity: 1 });
	self.setYSpeed(Random.int(10,30));
	self.setXSpeed(Random.int(10,30));

}

function update() {

}
function onTeardown(){
}
