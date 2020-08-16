extends Node2D

var level_0 = preload("res://level0.tscn")
var report = preload("res://report_stage.tscn")

var activate_level


func _ready():
	var instance = level_0.instance()
	instance.connect("complete", self, "_on_level_complete")
	activate_level = instance
	add_child(instance)
	
func _on_level_complete():
	remove_child(activate_level)
	add_child(report.instance())

	


