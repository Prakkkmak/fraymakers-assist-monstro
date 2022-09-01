// Assist stats for Template Assist

// Define some states for our state machine
STATE_FALL = 0;
STATE_LAND = 1;
STATE_SHOOT = 2;
STATE_PREJUMP = 3;
STATE_JUMP = 4;

{
	spriteContent: self.getResource().getContent("assist_monstro"),
	initialState: STATE_FALL,
	stateTransitionMapOverrides: [
		STATE_FALL => {
			animation: "fall"
		},
		STATE_LAND => {
			animation: "land"
		},
		STATE_SHOOT => {
			animation: "shoot"
		},
		STATE_PREJUMP => {
			animation: "prejump"
		},
		STATE_JUMP => {
			animation: "jump"
		}
	],
	gravity: 0,
	terminalVelocity: 20,
	assistChargeValue: 1
}
