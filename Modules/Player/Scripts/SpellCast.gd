extends Node2D

const EnergyScene = preload("res://Modules/Player/Spells/Energy.tscn")

var Spells = {
	'energy': EnergyScene
};

var is_casting = false;
var active_spell;

func _ready():
	active_spell = Spells.energy.instance();
	get_parent().call_deferred("add_child", active_spell)
	pass;

func _process(delta):
	if (is_casting):
		active_spell.activate()
	
	pass;
