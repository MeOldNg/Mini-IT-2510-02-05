extends Node2D

var players : Array = []
var index : int = 0 
var action_queue: Array = []
var player_take_damage

@onready var choice = $"../CanvasLayer/choice"

func _ready():
	players = get_children()
	for i in players.size():
		players
		players[i].position = Vector2(0, i*145)
		


func _on_enemy_group_next_player() -> void:
	if index < players.size() - 1 :
		index += 1
		switch_focus(index, index-1)
	else:
		index = 0
		switch_focus(index, players.size() - 1 )
		


func switch_focus(x,y):
	players[x].focus()
	players[y].unfocus()


func _on_next_turn_pressed() -> void:
	players[0].take_damage(1)
	players[1].take_damage(1)
	players[2].take_damage(1)
	players[3].take_damage(1)
	await get_tree().create_timer(0.5).timeout
	action_queue.clear()
