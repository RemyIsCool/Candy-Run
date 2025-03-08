class_name Player
extends CharacterBody2D


const SPEED = 250.0
const ACCELERATION = 1800.0
const FRICTION = 0.75
const AIR_FRICTION = 0.85
const JUMP_VELOCITY = -400.0
const JUMP_CUT = 0.5
const UP_GRAVITY = 1800.0
const DOWN_GRAVITY = 3000.0
const HANG_GRAVITY = 1200.0
const HANG_THRESHOLD = 50.0


var has_checkpoint: int = 0

var _schedule_cut := false
var _dead := false


@onready var checkpoint: Vector2 = global_position

@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var die_sfx: AudioStreamPlayer = $Die
@onready var jump: AudioStreamPlayer = $Jump
@onready var camera_2d: Camera2D = $Camera2D
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var timer: CanvasLayer = $Timer


func _physics_process(delta: float) -> void:
	if (
		timer and
		get_tree().current_scene.scene_file_path == "res://levels/level_4.tscn"
	):
		timer.queue_free()

	if _dead:
		return
		
	if global_position.y > get_viewport_rect().size.y:
		get_tree().paused = true
		_dead = true
		SceneManager.fade_around(_reset)
		
		
	if is_on_floor():
		coyote_timer.start()
	else:
		sprite.play("jump")
		velocity.y += (HANG_GRAVITY if abs(velocity.y) < HANG_THRESHOLD else UP_GRAVITY if velocity.y < 0 else DOWN_GRAVITY) * delta

	if coyote_timer.time_left and jump_buffer_timer.time_left:
		velocity.y = JUMP_VELOCITY
		jump.play()
		coyote_timer.stop()
		jump_buffer_timer.stop()
		if _schedule_cut:
			velocity.y *= JUMP_CUT
			_schedule_cut = false

	var direction := (
		0.0 if SceneManager.fading else Input.get_axis("left", "right")
	)
	if direction < 0:
		sprite.flip_h = true
	if direction > 0:
		sprite.flip_h = false
	
	if (direction > 0 and velocity.x < SPEED) or (direction < 0 and velocity.x > -SPEED):
		velocity.x += direction * ACCELERATION * delta
		if is_on_floor():
			sprite.play("walk")
	else:
		if is_on_floor():
			sprite.play("idle")
		velocity.x *= FRICTION if is_on_floor() else AIR_FRICTION
	
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		jump_buffer_timer.start()
	elif event.is_action_released("jump"):
		if velocity.y < 0:
			velocity.y *= JUMP_CUT
		elif jump_buffer_timer.time_left:
			_schedule_cut = true


func die():
	die_sfx.play()
	get_tree().paused = true
	_dead = true
	animation_player.play("die")
	await animation_player.animation_finished
	SceneManager.fade_around(_reset)


func _reset():
	global_position = checkpoint
	camera_2d.limit_left = 0
	camera_2d.limit_right = 4000
	camera_2d.limit_top = 0
	velocity = Vector2.ZERO
	Globals.reset.emit()
	get_tree().paused = false
	_dead = false
	animation_player.play("RESET")
