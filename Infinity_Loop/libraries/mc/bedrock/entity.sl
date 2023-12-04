package mc.bedrock.Entity

template Entity{
    lazy var namespace = "sl"
    lazy var components = {}
    lazy var events = {"despawn": {"add": {"component_groups": ["despawn"]}}}
    lazy var eventData = {}
    lazy var componentGroups = {"despawn": {"minecraft:despawn": {}}}
    lazy var isSpawnable = true
    lazy var isExperimental = false
    lazy var isSummonable = true
    lazy var eggBaseColor = "#ADADAD"
    lazy var eggOverlayColor = "#ADADAD"
    lazy var material = "entity_alphatest"
    lazy var geometry = "geometry.humanoid"
    lazy var entityTextures = {}
    lazy var entityVariants = []
    lazy var name = Compiler.getContextName()

    def [compile.order=999999] make(){
        if (Compiler.isBedrock()){
            Compiler.insert(($name, $pref), (name, namespace)){
                jsonfile entities.$name{
                    "format_version": "1.8.0",
                    "minecraft:entity": {
                        "description": {
                            "identifier": "$pref:$name",
                            "is_spawnable": isSpawnable,
                            "is_experimental": isExperimental,
                            "is_summonable": isSummonable
                        },
                        "components": components,
                        "component_groups": componentGroups,
                        "events": events
                    }
                }
                [bedrock_rp=true]jsonfile entity.$pref.$name{
                    "format_version": "1.8.0",
                    "minecraft:client_entity": {
                        "description": {
                            "identifier": "$pref:$name",
                            "spawn_egg": {
                                "base_color": eggBaseColor,
                                "overlay_color": eggOverlayColor
                            },
                            "materials": {
                                "default": material
                            },
                            "textures": entityTextures,
                            "geometry": {
                                "default": geometry
                            },
                            "render_controllers": [
                                "controller.render.$pref.$name"
                            ]
                        }
                    }
                }
                [bedrock_rp=true]jsonfile render_controllers.entities.$pref.$name{
                    "format_version": "1.8.0",
                    "render_controllers": {
                    "controller.render.$pref.$name": {
                            "arrays": {
                                "textures": {
                                    "Array.skins": entityVariants
                                }
                            },
                            "geometry": "Geometry.default",
                            "materials": [ { "*": "Material.default" } ],
                            "textures": ["Array.skins[query.variant]"]
                        }
                    }
                }
            }
        }
    }


    """
    Set the namespace of the entity
    """
    def lazy setNamespace(string value){
        namespace = value
    }
    """
    Set the material of the entity
    """
    def lazy setMaterial(string value){
        material = value
    }
    """
    Set the geometry of the entity
    """
    def lazy setGeometry(string value){
        geometry = "geometry."+value
    }
    """
    Set the name of the entity
    """
    def lazy setName(string value){
        name = value
    }
    """
    Set the egg base color of the entity
    """
    def lazy setEggBaseColor(string value){
        eggBaseColor = value
    }
    """
    Set the egg base color of the entity
    """
    def lazy setEggBaseColor(int r, int g, int b){
        eggBaseColor = Compiler.rgb(r,g,b)
    }
    """
    Set the egg overlay color of the entity
    """
    def lazy setEggOverlayColor(string value){
        eggOverlayColor = value
    }
    """
    Set the egg overlay color of the entity
    """
    def lazy setEggOverlayColor(int r, int g, int b){
        eggOverlayColor = Compiler.rgb(r,g,b)
    }

    """
    Add Texture to the entity
    """
    def lazy addTexture(string $name, string value){
        lazy var texture = "textures/"+value
        lazy var variant = "Texture.$name"
        entityTextures += {"$name": texture}
        entityVariants += variant
    }
    

    """
    Set if the entity is spawnable or not
    """
    def lazy setIsSpawnable(bool value){
        isSpawnable = value
    }

    """
    Set the max health and the health of the entity to `health`
    """
    def lazy setHealth(int health){
        components += {"minecraft:health": {
                            "value": health,
                            "max": health
                        }
        }
    }
    """
    Set the collision box width and height of the entity
    """
    def lazy setCollision(float width, float height){
        components += {
            "minecraft:collision_box": {
				"width": width,
				"height": height
			}
        }
    }

    def lazy setBossBar(string name, int range = 100, bool darksky = false){
        components += {
            "minecraft:boss": {
				"should_darken_sky": darksky,
				"hud_range": range,
				"name": name
			}
        }
    }

    def lazy breakBlocks(json blocks){
        components += {"minecraft:break_blocks": {
            "breakable_blocks": blocks
            }
        }
    }
    def lazy breakBlocks(params blocks){
        foreach(block in blocks){
            components += {"minecraft:break_blocks": {
                "breakable_blocks": [block]
                }
            }
        }
    }
    def lazy canBreathAir(bool value = true){
        components += {
            "minecraft:breathable":{
                "breathes_air": value
            }
        }
    }
    def lazy canBreathWater(bool value = true){
        components += {
            "minecraft:breathable":{
                "breathes_water": value
            }
        }
    }
    def lazy canBreathLava(bool value = true){
        components += {
            "minecraft:breathable":{
                "breathes_lava": value
            }
        }
    }
    def lazy canBreathSolids(bool value = true){
        components += {
            "minecraft:breathable":{
                "breathes_solids": value
            }
        }
    }
    def lazy breathTime(float inhale, int suffocate, int supply){
        components += {
            "minecraft:breathable":{
                "inhale_time": inhale,
                "suffocate_time": suffocate,
                "total_supply": supply
            }
        }
    }
    def lazy generateBubbles(bool value = true){
        components += {
            "minecraft:breathable":{
                "generates_bubbles": value
            }
        }
    }
    def lazy burnsInDaylight(){
        components += {
            "minecraft:burns_in_daylight": {
            }
        }
    }
    def lazy setInvinsible(){
        components += {
            "minecraft:damage_sensor": [
				{
					"cause": "all",
					"deals_damage": false
				}
			]
        }
    }
    def lazy setTimer(float time, string event, bool looping = false){
        components += {
            "minecraft:timer":{
                "looping": looping,
                "time": [time, time],
                "time_down_event": {
                    "event": event
                }
            }
        }
    }
    def lazy setTimerRandom(float start, float end, string event, bool looping = false){
        components += {
            "minecraft:timer":{
                "looping": looping,
                "randomInterval":true,
                "time": [start, end],
                "time_down_event": {
                    "event": event
                }
            }
        }
    }
    def lazy canEquipItem(){
        components += {
            "minecraft:equip_item":{
            }
        }
    }
    def lazy setExplode(bool breakblock, bool causesfire, float power, bool destroygrief = false, bool firegrief = false){
        components += {
            "minecraft:explode":{
                "breaks_blocks": breakblock,
                "causes_fire": causesfire,
                "destroy_affected_by_griefing": destroygrief,
                "fire_affected_by_griefing": firegrief,
                "power": power
            }
        }
    }
    def lazy setExplodeTime(bool breakblock, bool causesfire, float power, float time, bool destroygrief = false, bool firegrief = false){
        components += {
            "minecraft:explode":{
                "breaks_blocks": breakblock,
                "causes_fire": causesfire,
                "destroy_affected_by_griefing": destroygrief,
                "fire_affected_by_griefing": firegrief,
                "fuse_length": [time, time],
                "fuse_lit": true,
                "power": power
            }
        }
    }

    def lazy setInteraction(string event, string text = interact){
        components += {
            "minecraft:interact": [
				{
					"on_interact": {
						"filters": {
							"all_of": [
								{
									"test": "is_family",
									"subject": "other",
									"value": "player"
								}
							]
						},
						"event": event
					},
					"interact_text": text
				}
			]
        }
    }
    def lazy setInventory(string size = 5, bool isprivate = false){
        components += {
            "minecraft:inventory":{
                "additional_slots_per_strength": 0,
                "can_be_siphoned_from": false,
                "container_type": "",
                "inventory_size": size,
                "private": isprivate,
                "restrict_to_owner": false
            }
        }
    }
    def lazy isNameable(bool alwaysshow = true, bool allowrenaming = true){
        components += {
            "minecraft:nameable": {
                "always_show": alwaysshow,
                "allow_name_tag_renaming": allowrenaming
			}
        }
    }
    def lazy onNamed(string name, string event){
        components += {
            "minecraft:nameable": {
                "name_actions": [
                    {
                    "name_filter": name,
                    "on_named": {
                        "event": event,
                        "target": "self"
                        }
                    }
                ]
            }
        }
    }
    def lazy setPhysics(bool collision = true, bool gravity = true){
        components += {
            "minecraft:physics":{
                "has_collision": collision,
                "has_gravity": gravity
            }
        }
    }
    def lazy projectile(float power = 1.5, float gravity = 0.03, float angle = 0.0){
        components += {
            "minecraft:projectile": {
                "power": power,
                "gravity": gravity,
                "angle_offset": angle
            }
        }
    }
    def lazy isPushable(bool pushable = true, bool piston = true){
        components += {
            "minecraft:pushable":{
                "is_pushable": pushable,
                "is_pushable_by_piston": piston
            }
        }
    }
    def lazy setScale(float scale){
        components += {
            "minecraft:scale": {
				"value": scale
			}
        }
    }
    def lazy shooter(string shoot){
        components += {
            "minecraft:shooter": {
                "def": shoot
            }
        }
    }
    def lazy spawnEntity(string entity, int time = 0, int quantity = 1, bool singleuse = true){
        components += {
            "minecraft:spawn_entity":{
                "entities": [
                    {
                    "max_wait_time": time,
                    "min_wait_time": time,
                    "num_to_spawn": quantity,
                    "single_use": singleuse,
                    "spawn_entity": entity
                    }
                ]
            }
        }
    }
    def lazy spawnItem(string item, int time = 0, int quantity = 1, bool singleuse = true){
        components += {
            "minecraft:spawn_entity":{
                "entities": [
                    {
                    "max_wait_time": time,
                    "min_wait_time": time,
                    "num_to_spawn": quantity,
                    "single_use": singleuse,
                    "spawn_item": item
                    }
                ]
            }
        }
    }
    def lazy scale(float scale){
        components += {
            "minecraft:scale": {
                "value": scale
            }
        }
    }
    def lazy transformation(string mob, float time = 0.0, bool keeplevel = false, bool dropinventory = false, bool equipement = false){
        components += {
            "minecraft:transformation": {
                "into": mob,
                "delay": time,
                "keep_level": keeplevel,
                "drop_inventory": dropinventory,
                "preserve_equipment": equipement
			}
        }
    }
    def lazy canTeleport(int maxtime = 30, int x = 64, int y = 32, int z = 64, int distance = 16, float chance = 0.05){
        components += {
            "minecraft:teleport": {
                "random_teleports": true,
                "max_random_teleport_time": maxtime,
                "random_teleport_cube": [ x, y, z ],
                "target_distance": distance,
                "target_teleport_chance": chance,
                "light_teleport_chance": chance
            }
        }
    }
    def lazy setAttack(int attack){
        components += {
            "minecraft:attack": {
                "damage": attack
            }
        }
    }
    def lazy entitySensor(string mob, string event, float range, int quantity){
        components += {
            "minecraft:entity_sensor": {
                "sensor_range": range,
                "relative_range": false,
                "minimum_count": quantity,
                "event_filters": {
                    "any_of": [
                        { "test": "is_family", "subject": "other", "value": mob }
                    ]
                },
                "event": event
            }
        }
    }
    def lazy setFamily(params family){
        components += {
            "minecraft:type_family": {
                "family": [ family ]
            }
        }
    }
    def lazy setMovement(float movement){
        components += {
            "minecraft:movement": {
                "value": movement
            }
        }
    }
    def lazy knockbackResistance(float value = 1.0){
        components += {
            "minecraft:knockback_resistance": {
                "value": value
            }
        }
    }
    def lazy lookAtPlayer(int priority = 7, float distance = 6.0, float probability = 0.02){
        components += {
            "minecraft:behavior.look_at_player": {
                "priority": priority,
                "look_distance": distance,
                "probability": probability
            }
        }
    }
    def lazy randomLookAround(float priority = 8){
        components += {
            "minecraft:behavior.random_look_around": {
                "priority": priority
            }
        }
    }
    def lazy setVariant(int value){
        components += {
            "minecraft:variant": {
                "value": value
            }
        }
    }
    def lazy onFatalDamage(string event){
        components += {
            "minecraft:damage_sensor": {
                "on_damage": {
                    "filters": {
                        "with_damage_fatal": true
                    },
                    "event": event
                }
            }
        }
    }
    def lazy onDamage(string event){
        components += {
            "minecraft:damage_sensor": {
                "on_damage": {
                    "cause": "lol",
                    "event": event
                }
            }
        }
    }
    def lazy onDamage(void=>void fct){
        event("sl:onDamage", fct)
        onDamage("sl:onDamage")
    }
    def lazy onFatalDamage(void=>void fct){
        event("sl:onFatalDamage", fct)
        onFatalDamage("sl:onFatalDamage")
    }
    def lazy mobEffect(string effect, float range, int time = 10, string mob = player){
        components += {
            "minecraft:mob_effect": {
                "effect_range": range,
                "mob_effect": effect,
                "effect_time": time,
                "entity_filter": {
                    "any_of": [
                        { "test": "is_family", "subject": "other", "value": mob }
                    ] 
                }
            }
        }
    }
    def lazy randomStroll(int priority = 4, float speed = 1){
        components += {
            "minecraft:behavior.random_stroll": {
                "priority": priority,
                "speed_multiplier": speed
            }
        }
    }
    def lazy componentGroup(string name, void=>void fct){
        lazy val old = components
        components = {}
        fct()
        lazy val eventComponent = components
        components = old
        Compiler.insert($name, name){
            componentGroups += {"$name" : eventComponent}
        }
    }
    def lazy addComponentGroup(string name){
        eventData += {"add":{"component_groups": [name]}}
    }
    def lazy removeComponentGroup(string name){
        eventData += {"remove":{"component_groups": [name]}}
    }
    def lazy removeEvent(string name){
        lazy val cpngName = "sl:"+name
        eventData += {"remove": {"component_groups": [cpngName]}}
    }
    def lazy event(string name, void=>void fct){
        lazy val cpngName = "sl:"+name
        eventData = {}
        componentGroup(cpngName, fct)
        lazy var newEventData = eventData
        newEventData += {"add": {"component_groups": [cpngName]}}
        Compiler.insert($name, name){
            events += {"$name" : newEventData}
        }
    }
    def lazy runCommand(void=>void fct){
        eventData +=  {"run_command": {
                "command": fct
            }
        }
    }
}
