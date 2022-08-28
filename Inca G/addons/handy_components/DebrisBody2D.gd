tool
extends Node2D


signal collapsed

const WARNING_MESSAGE_01: String =\
"""This node has no shape, so it can\'t collapse.
Consider adding a Polygon2D as a child to define its shape."""

const WARNING_MESSAGE_02: String =\
"""This node has more than one shape.
Consider removing possible duplications, otherwise the first
Polygon2D child will be assumed as this node's shape.'"""

export(int) var fragment_count = 32
export(bool) var random_color = true

var _polygon_2d: Polygon2D
var _fragment_repulsion_map: Dictionary = {}


func _ready() -> void:
	if Engine.editor_hint:
		return
	randomize()
	for child in get_children():
		if child is Polygon2D:
			_polygon_2d = child
			break


func _process(delta: float) -> void:
	if Engine.editor_hint:
		return
	
	for child in _fragment_repulsion_map.keys():
		child.position -= _fragment_repulsion_map[child] * delta * 20.0
		child.rotation -= _fragment_repulsion_map[child].x * delta * 0.1
		_fragment_repulsion_map[child].y -= delta * 35.0


func _draw() -> void:
	draw_rect(_get_polygon_rect(_polygon_2d.polygon), Color.red, false)


func _get_configuration_warning() -> String:
	var has_polygon_2d = false
	for child in get_children():
		if child is Polygon2D:
			if has_polygon_2d:
				return WARNING_MESSAGE_02
			has_polygon_2d = true
	
	if not has_polygon_2d:
		return WARNING_MESSAGE_01
	return ''


func reset() -> void:
	_fragment_repulsion_map.clear()
	for fragment in get_tree().get_nodes_in_group("debris"):
		fragment.queue_free()
	_polygon_2d.show()


func collapse() -> void:
	var points: PoolVector2Array = _polygon_2d.polygon
	for i in fragment_count:
		points.append(Vector2(randi() % 64, randi() % 64))
	
	var delaunay_indices: PoolIntArray = Geometry.triangulate_delaunay_2d(points)
	
	for i in len(delaunay_indices) / 3:
		var fragment_vertices: PoolVector2Array = PoolVector2Array()
		
		var fragment_center: Vector2 = Vector2.ZERO
		for j in 3:
			fragment_vertices.append(points[delaunay_indices[i * 3 + j]])
			fragment_center += points[delaunay_indices[i * 3 + j]]
		fragment_center /= 3.0
		
		var fragment: Polygon2D = Polygon2D.new()
		fragment.polygon = fragment_vertices
		
		if random_color:
			fragment.color = Color(randf(), randf(), randf(), 1.0)
		else:
			fragment.texture = _polygon_2d.texture
		
		_fragment_repulsion_map[fragment] = Vector2(32.0, 32.0) - fragment_center
		
		fragment.add_to_group("debris")
		add_child(fragment)
	_polygon_2d.hide()
	emit_signal("collapsed")


func _get_polygon_rect(points: PoolVector2Array) -> Rect2:
	var rect: Rect2 = Rect2(points[0], Vector2.ZERO)
	for point in points:
		rect = rect.expand(point)
	return rect
