extends StaticBody2D

class_name SolidObject


func _process(_delta):
	self.set_z_index(int(self.position.y))
