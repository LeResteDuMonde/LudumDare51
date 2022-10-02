extends Sprite

var thread

func _ready():
	thread = Thread.new()
	thread.start(self, "_thread_function")

func _process(delta):
	pass
	#tween.tween_property(self, "rotation", 1.0 , 2.0)

func _thread_function(userdata):
	while true: 
		rotation += .00001