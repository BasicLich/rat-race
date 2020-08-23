extends Node2D

signal nexted(report_instance)
signal restart()

var rat_id = ""
var success = false
var reason = ""

func _ready():
	$CanvasLayer/reason.text = "Rat #" + rat_id + " " + reason
	if success:
		$CanvasLayer/result.text = "SUCCESS"
		$CanvasLayer/result.add_color_override("font_color", Color(0.266667, 0.788235, 0.262745))
		$CanvasLayer/menu_button.text = "NEXT"
		$SuccessMusic.play()
	else:
		$CanvasLayer/result.text = "FAILED"
		$CanvasLayer/result.add_color_override("font_color", Color(0.898438, 0.017548, 0.017548))
		$CanvasLayer/menu_button.text = "TRY AGAIN"
		$FailMusic.play()

func _on_menu_button_pressed():
	emit_signal("nexted", self)


func _on_menu_button_mouse_entered():
	$HoverSound.play()


func _on_PressSound_finished():
	emit_signal("nexted", self)
