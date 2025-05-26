extends Panel

@onready var item_visual: Sprite2D = $item_display

func update(item:InvItem):
	if !item:
		item.visual.visible = false
	else:
		item.visual.visible = true
		item.visual.texture = item.texture
