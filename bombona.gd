extends AnimatedSprite2D


func _process(delta):
	if $"../../../Player".tinta <= 100 and $"../../../Player".tinta > 75:
		play("Llena")
	elif $"../../../Player".tinta < 75 and $"../../../Player".tinta > 50:
		play("3_4")
	elif $"../../../Player".tinta < 50 and $"../../../Player".tinta > 25:
		play("2_4")
	elif $"../../../Player".tinta < 25 and $"../../../Player".tinta > 0:
		play("1_4")
	elif $"../../../Player".tinta == 0:
		play("Vacia")
