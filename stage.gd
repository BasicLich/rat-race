extends Node2D

var level_0 = preload("res://level0.tscn")
var level_1 = preload("res://level01.tscn")
var report = preload("res://report_stage.tscn").instance()
var menu = preload("res://stage_menu.tscn").instance()
var index = 0

var time_left = 120

var levels = []
var activate_level


func _ready():
	
	levels.append(level_1.instance())
	levels.append(level_0.instance())
	
	for instance in levels:
		instance.connect("level_complete", self, "_on_level_complete")
	
	menu.connect("started", self, "_start_game")
	report.connect("nexted", self, "_on_report_complete")
	add_child(menu)
	
func _start_game():
	remove_child(menu)
	$UI/Control.show()
	$ViewportContainer/Viewport.add_child(levels[0])
	$Timer.start()
	
func _on_level_complete():
	$ViewportContainer/Viewport.remove_child(levels[index])
	report.rat_id = "abc123"
	report.success = true
	report.reason = "fucked up"
	add_child(report)
	index += 1

func _on_report_complete():
	remove_child(report)
	$ViewportContainer/Viewport.add_child(levels[index])
	
func _on_Timer_timeout():
	var seconds = time_left % 60
	var minutes = time_left % 3600 / 60
	var str_elapsed = "%01d:%02d" % [minutes, seconds]
	$UI/Control/TimeDisplay.text = str_elapsed
	time_left -= 1
