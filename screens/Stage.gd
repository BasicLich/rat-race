extends Node2D

signal restart(scene)

var level_1 = preload("res://levels/Level1.tscn")
var level_2 = preload("res://levels/Level2.tscn")
var level_3 = preload("res://levels/Level3.tscn")
var level_4 = preload("res://levels/Level4.tscn")
#var level_1 = preload("res://level01.tscn")
var report = preload("res://screens/Report.tscn")
var intro = preload("res://screens/Intro.tscn")

var index = 0
var levels = [
	level_1.instance(), 
	level_2.instance(),
	level_3.instance(),
	level_4.instance()
	]

var rat_id: int

func _ready():	
	$UI/Control.hide()
	randomize()
	
	rat_id = randi() % 2000
	for instance in levels:
		instance.connect("level_complete", self, "_on_level_complete")
		instance.connect("fronk_speaks", self, "_on_fronk_speaks")
	
	var intro_instance = intro.instance()
	intro_instance.rat_id = rat_id
	intro_instance.connect("nexted", self, "_on_intro_done")
	call_deferred("add_child", intro_instance)
	
func _on_fronk_speaks(message):
	# TODO: what if two signals come between timeouts?
	$UI/Control/Speech.text = message
	$FronkVoice.play()
	$SpeechTimer.start()
	
func _clear_text():
	$SpeechTimer.stop()
	$UI/Control/Speech.text = ""
	
func _on_intro_done(scene):
	call_deferred("remove_child", scene)
	$UI/Control/ViewportContainer/Viewport.call_deferred("add_child", levels[index])
	$UI/Control/TimeDisplay.text = convert_time(levels[index].time_limit)
	levels[index].connect("tick", self, "_on_level_tick")
	$UI/Control.show()
	# TODO: find better way
	get_parent().get_node("AudioStreamPlayer").stop()
	
func _on_level_complete(successful, reason):
	print("called")
	$UI/Control/ViewportContainer/Viewport.call_deferred("remove_child", levels[index])
	
	var report_instance = report.instance()
	report_instance.rat_id = str(rat_id)
	report_instance.success = successful
	report_instance.reason = reason
	
	index += 1
	
	$UI/Control.hide()
	report_instance.connect("nexted", self, "_on_report_complete")
	call_deferred("add_child", report_instance)

func _on_report_complete(report_instance):
	
	call_deferred("remove_child", report_instance)
	if !report_instance.success:
		emit_signal("restart", self)
		return
	$UI/Control.show()
	$UI/Control/ViewportContainer/Viewport.call_deferred("add_child", levels[index])
	$UI/Control/TimeDisplay.text = convert_time(levels[index].time_limit)
	levels[index].connect("tick", self, "_on_level_tick")

func _on_level_tick(time_left):

	$UI/Control/TimeDisplay.text = convert_time(time_left)

func convert_time(time):
	var seconds = time % 60
	var minutes = time % 3600 / 60
	return "%01d:%02d" % [minutes, seconds]


func _on_SpeechTimer_timeout():
	_clear_text()
