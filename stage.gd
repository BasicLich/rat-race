extends Node2D

var level_1 = preload("res://levels/Level1.tscn")
var level_2 = preload("res://levels/Level2.tscn")
var level_3 = preload("res://levels/Level3.tscn")
var level_4 = preload("res://levels/Level4.tscn")
#var level_1 = preload("res://level01.tscn")
var report = preload("res://report_stage.tscn")
var index = 0
var levels = [
	level_4.instance(), 
	#level_2.instance()
	]

func _ready():	
	for instance in levels:
		instance.connect("level_complete", self, "_on_level_complete")
	
	$UI/Control/ViewportContainer/Viewport.add_child(levels[index])
	$UI/Control/TimeDisplay.text = convert_time(levels[index].time_limit)
	levels[index].connect("tick", self, "_on_level_tick")
	
func _on_level_complete(successful, reason):
	$UI/Control/ViewportContainer/Viewport.remove_child(levels[index])
	
	var report_instance = report.instance()
	report_instance.rat_id = "abc123"
	report_instance.success = successful
	report_instance.reason = reason
	
	index += 1
	
	$UI/Control.hide()
	report_instance.connect("nexted", self, "_on_report_complete")
	add_child(report_instance)

func _on_report_complete(report_instance):
	print("here")
	remove_child(report_instance)
	$UI/Control.show()
	$UI/Control/ViewportContainer/Viewport.add_child(levels[index])
	$UI/Control/TimeDisplay.text = convert_time(levels[index].time_limit)
	levels[index].connect("tick", self, "_on_level_tick")

func _on_level_tick(time_left):

	$UI/Control/TimeDisplay.text = convert_time(time_left)

func convert_time(time):
	var seconds = time % 60
	var minutes = time % 3600 / 60
	return "%01d:%02d" % [minutes, seconds]
