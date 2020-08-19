extends Node2D

var level_0 = preload("res://level0.tscn")
var report = preload("res://report_stage.tscn").instance()
var menu = preload("res://stage_menu.tscn").instance()
var index = 0

var levels = []
var activate_level

func _ready():
	levels.append(level_0.instance())
	levels.append(level_0.instance())
	
	for instance in levels:
		instance.connect("level_complete", self, "_on_level_complete")
	
	menu.connect("started", self, "_start_game")
	report.connect("nexted", self, "_on_report_complete")
	add_child(menu)
	
func _start_game():
	remove_child(menu)
	add_child(levels[0])
	
func _on_level_complete():
	remove_child(levels[index])
	report.rat_id = "abc123"
	report.success = true
	report.reason = "fucked up"
	add_child(report)
	index += 1

func _on_report_complete():
	remove_child(report)
	add_child(levels[index])
	


