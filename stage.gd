extends Node2D

var level_0 = preload("res://level0.tscn")
#var level_1 = preload("res://level01.tscn")
var report = preload("res://report_stage.tscn")
var index = 0
var levels = [
	level_0.instance(), 
	level_0.instance()
	]

func _ready():	
	for instance in levels:
		instance.connect("level_complete", self, "_on_level_complete")
	
	$UI/Control/ViewportContainer/Viewport.add_child(levels[index])
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
	levels[index].connect("tick", self, "_on_level_tick")

func _on_level_tick(time_left):

	var seconds = time_left % 60
	var minutes = time_left % 3600 / 60
	var str_elapsed = "%01d:%02d" % [minutes, seconds]
	$UI/Control/TimeDisplay.text = str_elapsed

