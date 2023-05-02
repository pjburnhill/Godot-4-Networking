extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Set by the authority, synchronized on spawn.
@export var player_id := 1 :
	set(id):
		player_id = id
		# Give authority over the player input to the appropriate peer.
		$PlayerInput.set_multiplayer_authority(id)
		
# Player synchronized input.
@onready var input = $PlayerInput

func _ready():
	# Set the camera as current if we are this player.
	if player_id == multiplayer.get_unique_id():
		$Camera2D.make_current()
	# Only process on server.
	# EDIT: Let the client simulate player movement too to compesate network input latency.
	# set_physics_process(multiplayer.is_server())

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump. -- OLD JUMP
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
		
	# Handle jump.
	if input.jumping and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Reset jump state.
	input.jumping = false
		
	# Handle input
	# direction = Input.get_axis("ui_left", "ui_right") -- OLD MOVEMENT
	var direction = input.direction
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
