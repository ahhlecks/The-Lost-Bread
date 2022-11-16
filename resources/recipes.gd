extends Node

var recipes:Array = [
	{
		"name" : "plain_bread",
		"chewiness" : .4,
		"toastiness" : .1,
		"butteriness" : .0,
		"sweetness" : .0,
		"saltiness" : .0,
		"temperature" : .4,
		"meatiness" : .0
	},
	{
		"name" : "plain_toast",
		"chewiness" : .2,
		"toastiness" : .4,
		"butteriness" : .0,
		"sweetness" : .0,
		"saltiness" : .0,
		"temperature" : .5,
		"meatiness" : .0
	},
	{
		"name" : "buttered_toast",
		"chewiness" : .3,
		"toastiness" : .6,
		"butteriness" : .5,
		"sweetness" : .0,
		"saltiness" : .6,
		"temperature" : .6,
		"meatiness" : .0
	},
	{
		"name" : "french_toast",
		"chewiness" : .4,
		"toastiness" : .6,
		"butteriness" : .5,
		"sweetness" : .8,
		"saltiness" : .1,
		"temperature" : .7,
		"meatiness" : .0
	},
	{
		"name" : "grilled_cheese",
		"chewiness" : .8,
		"toastiness" : .6,
		"butteriness" : 1,
		"sweetness" : .0,
		"saltiness" : .6,
		"temperature" : .8,
		"meatiness" : .0
	},
	{
		"name" : "crouton",
		"chewiness" : .0,
		"toastiness" : 1,
		"butteriness" : .0,
		"sweetness" : .0,
		"saltiness" : .1,
		"temperature" : .4,
		"meatiness" : .0
	},
	{
		"name" : "ham_sandwich",
		"chewiness" : .4,
		"toastiness" : .0,
		"butteriness" : .2,
		"sweetness" : .1,
		"saltiness" : .7,
		"temperature" : .4,
		"meatiness" : .9
	},
	{
		"name" : "panini",
		"chewiness" : .5,
		"toastiness" : .8,
		"butteriness" : .3,
		"sweetness" : .0,
		"saltiness" : .7,
		"temperature" : 1,
		"meatiness" : .8
	},
	{
		"name" : "ice_cream_sandwich",
		"chewiness" : .3,
		"toastiness" : .0,
		"butteriness" : .4,
		"sweetness" : 1,
		"saltiness" : .0,
		"temperature" : .0,
		"meatiness" : .0
	},
	{
		"name" : "muffin",
		"chewiness" : .7,
		"toastiness" : .0,
		"butteriness" : .2,
		"sweetness" : .5,
		"saltiness" : .0,
		"temperature" : .4,
		"meatiness" : .0
	}
]

func find_recipe(name:String) -> Dictionary:
	for recipe in recipes:
		if recipe.name == name:
			return recipe
	return {}

func print_stat(stat:float) -> String:
	var output:String = ""
	var calculated_stat = stat
	if calculated_stat > 0:
		while calculated_stat > 0:
			calculated_stat -= .05
			output += "+"
	else:
		while calculated_stat < 0:
			calculated_stat += .05
			output += "-"
	return output

# microwave increases chewiness and temperature
# toaster increases toastiness and temperature and decreases chewiness
# butter increases butteriness and slightly increases saltiness
# sugar increases sweetness
# salt increases saltiness 
# meat increases meatiness and slightly increases saltiness
# refrigerator decreases temperature and toastiness and increases chewiness
# freezer greatly decreases temperature increases freshness and decreases chewiness
# cheese increases saltiness and chewiness and slighty increases butteriness
# arugula decreases sweetness and decreases saltiness

# [upgrade name, rarity]
# rarity is from 1 - 4, where 4 is most rare

var ultra_rare_upgrades:Array = [
	"freezer"
]
var rare_upgrades:Array = [
	"cheese",
	"arugula",
	"spatula"
]
var uncommon_upgrades:Array = [
	"sugar",
	"salt",
	"meat",
	"refrigerator"
]
var common_upgrades:Array = [
	"microwave",
	"toaster",
	"butter"
]

var enemies:Array = [
	["kitchen_knife", {
		
	}],
	["butter_knife", {
		
	}],
	["flamethrower", {
		
	}],
	["pizza_cutter", {
		
	}],
	["bird", {
		
	}]
]
