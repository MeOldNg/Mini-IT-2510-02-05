extends CharacterBody2D

@onready var sprite_2D: Sprite2D = $Sprite2D
pass
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

signal died
var dead: bool = false
@onready var _focus = $focus_arrow
@onready var progress_bar = $ProgressBar
@onready var animation_damages = $AnimationPlayer

@export var MAX_HEALTH: float =20

var health : float = 7:
	set(value):
		health = value
		_update_progress_bar()
		_play_animation()

func _update_progress_bar():
	progress_bar.value = (health/MAX_HEALTH) * 100
	

func _play_animation():
	animation_damages.play("hurt")

func focus():
	_focus.show()
	
func unfocus():
	_focus.hide()
	
func take_damage(value):
	health -= value
	if health <= 0:
		dead = true
		emit_signal("died")
	
func is_dead():
	return dead

var enemies_count = 1
var action_queue: Array = []
var is_battling: bool = false
var index: int = 0
var turn: int = 1


signal textbox_closed
signal next_player
@onready var choice = $"../CanvasLayer/choice"
var enemies

func _ready():
	enemies = get_children()
	for i in enemies.size():
		enemies
		enemies[i].position = Vector2(0, i*145)
		
		decision()
		

func _process(_delta) :
	var enemies_count = 0
	for enemy in enemies:
		if enemy.has_method("is_dead"):
			if(not enemy.is_dead()):
				enemies_count += 1
	if enemies_count == 0:
		get_tree().change_scene_to_file("res://main-menu/mainmenuscene/youwon.tscn")
	if not choice.visible:
		if Input.is_action_just_pressed("ui_up"):
			if index > 0:
				index -= 1
				switch_focus(index, index+1)

		if Input.is_action_just_pressed("ui_down"):
			if index < enemies.size() - 1 :
				index += 1
				switch_focus(index, index-1)

		if Input.is_action_just_pressed("ui_accept"):
			action_queue.push_back(index)
			emit_signal("next_player")
			
		if action_queue.size() == enemies.size() and not is_battling:
			is_battling = true
			_action(action_queue)
		

func _textbox_appeared():
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
			$TextBox.hide()
			emit_signal("textbox_closed") 

func _action(stack):
	for i in stack:
		enemies[i].take_damage(1)
		await get_tree().create_timer(0.5).timeout
	action_queue.clear()
	is_battling = false
	turn -=1
	decision()

func switch_focus(x,y):
	enemies[x].focus()
	enemies[y].unfocus()

func decision():
	if turn > 0:
		show_choice()
		$"../CanvasLayer/choice/Next Turn".disabled = true
		$"../CanvasLayer/choice/Attack".disabled = false
		$"../CanvasLayer/choice/Abort".disabled = false
	else:
		dont_show_choice()
	
	
func _reset_focus():
	index = 0 
	for enemy in enemies:
		enemy.unfocus()
		
func _start_choosing():
	_reset_focus()
	enemies[0].focus()
	

func show_choice():
	choice.show()
	choice.find_child("Attack").grab_focus()
	choice.find_child("Abort").grab_focus()


func dont_show_choice():
	choice.show()
	choice.find_child("Next Turn").grab_focus()
	$"../CanvasLayer/choice/Attack".disabled = true
	$"../CanvasLayer/choice/Abort".disabled = true
	$"../CanvasLayer/choice/Next Turn".disabled = false

func _on_attack_pressed() -> void:
	display_text("Player attack with powerful forces!!!")
	emit_signal("textbox_closed")
	choice.hide()
	_start_choosing()


func _on_next_turn_pressed() -> void:
	display_text("Enenmy start to take turn.")
	display_text("Bang!!!")
	emit_signal("textbox_closed")
	turn +=1
	decision()
	
	
	
func display_text(text):
	$"../TextBox".show()
	$"../TextBox/Label".text = text
