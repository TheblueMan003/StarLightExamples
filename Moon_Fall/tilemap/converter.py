import os
import json
from PIL import Image

os.chdir("tilemap")

blocklist = [ "minecraft:white_wool", "minecraft:orange_wool", "minecraft:magenta_wool", "minecraft:light_blue_wool", "minecraft:yellow_wool", "minecraft:lime_wool", "minecraft:pink_wool", "minecraft:gray_wool", "minecraft:light_gray_wool", "minecraft:cyan_wool", "minecraft:purple_wool", "minecraft:blue_wool", "minecraft:brown_wool", "minecraft:green_wool", "minecraft:red_wool", "minecraft:black_wool",
             "minecraft:stone", "minecraft:granite", "minecraft:polished_granite", "minecraft:diorite", "minecraft:polished_diorite", "minecraft:andesite", "minecraft:polished_andesite",
             "minecraft:white_terracotta", "minecraft:orange_terracotta", "minecraft:magenta_terracotta", "minecraft:light_blue_terracotta", "minecraft:yellow_terracotta", "minecraft:lime_terracotta", "minecraft:pink_terracotta", "minecraft:gray_terracotta", "minecraft:light_gray_terracotta", "minecraft:cyan_terracotta", "minecraft:purple_terracotta", "minecraft:blue_terracotta", "minecraft:brown_terracotta", "minecraft:green_terracotta", "minecraft:red_terracotta", "minecraft:black_terracotta",
             "minecraft:white_concrete", "minecraft:orange_concrete", "minecraft:magenta_concrete", "minecraft:light_blue_concrete", "minecraft:yellow_concrete", "minecraft:lime_concrete", "minecraft:pink_concrete", "minecraft:gray_concrete", "minecraft:light_gray_concrete", "minecraft:cyan_concrete", "minecraft:purple_concrete", "minecraft:blue_concrete", "minecraft:brown_concrete", "minecraft:green_concrete", "minecraft:red_concrete", "minecraft:black_concrete",
             "minecraft:oak_planks", "minecraft:spruce_planks", "minecraft:birch_planks", "minecraft:jungle_planks", "minecraft:acacia_planks", "minecraft:dark_oak_planks", "minecraft:crimson_planks", "minecraft:warped_planks",
             "minecraft:stone_bricks", "minecraft:mossy_stone_bricks", "minecraft:cracked_stone_bricks", "minecraft:chiseled_stone_bricks", 
             "minecraft:iron_ore", "minecraft:gold_ore", "minecraft:coal_ore", "minecraft:lapis_ore", "minecraft:diamond_ore", "minecraft:emerald_ore", "minecraft:nether_gold_ore", "minecraft:nether_quartz_ore",
             "minecraft:iron_block", "minecraft:gold_block", "minecraft:diamond_block", "minecraft:emerald_block", "minecraft:lapis_block", "minecraft:coal_block", "minecraft:netherite_block",
             "minecraft:deepslate_iron_ore", "minecraft:deepslate_gold_ore", "minecraft:deepslate_coal_ore", "minecraft:deepslate_lapis_ore", "minecraft:deepslate_diamond_ore", "minecraft:deepslate_emerald_ore", "minecraft:deepslate_copper_ore",
             "minecraft:dead_fire_coral_block", "minecraft:dead_horn_coral_block", "minecraft:dead_tube_coral_block", "minecraft:dead_brain_coral_block", "minecraft:dead_bubble_coral_block", 
             "minecraft:dripstone_block", "minecraft:calcite", "minecraft:tuff", "minecraft:deepslate_bricks", "minecraft:deepslate_tiles", "minecraft:polished_deepslate", "minecraft:chiseled_deepslate", "minecraft:cracked_deepslate_bricks", "minecraft:cracked_deepslate_tiles", "minecraft:smooth_basalt", "minecraft:raw_iron_block", "minecraft:raw_copper_block", "minecraft:raw_gold_block", "minecraft:amethyst_block"
             ]

mapping = {}

if os.path.exists('mapping.txt'):
    mapping = json.load(open('mapping.txt'))

def exportImage(cell, block):
    img = Image.open('tileset.png', "r")
    cellSize = 16
    rowCount = img.size[0] / cellSize
    img.crop((cell % rowCount * cellSize, cell // rowCount * cellSize, cell % rowCount * cellSize + cellSize, cell // rowCount * cellSize + cellSize)).save('../java_resourcepack/assets/minecraft/textures/block/' + block + '.png')

def get():
    for block in blocklist:
        found = False
        for k in mapping:
            if mapping[k] == block:
                found = True
                break
        if not found:
            print("Found new block: " + block)
            return block


exportedImage = []
def convert(tilemap):
    file = open(tilemap, 'r')
    lines = file.readlines()
    file.close()

    output = open("../lib/levels/java_datapack/data/levels/functions/"+tilemap.replace('.csv', '.mcfunction'), 'w')

    x = 0
    y = 0
    empty = True
    for line in lines:
        cells = line.split(',')
        for cell in cells:
            cell = cell.strip()
            icell = int(cell)
            if icell > -1:
                if cell not in mapping:
                    mapping[cell] = get()
                if cell not in exportedImage:
                    exportedImage.append(cell)
                    exportImage(icell, mapping[cell].replace("minecraft:",""))
                output.write('setblock ~' + str(x) + ' ~' + str(-y) + ' ~ ' + mapping[cell] + '\n')
                empty = False
            else:
                output.write('setblock ~' + str(x) + ' ~' + str(-y) + ' ~ air\n')
            x += 1
        x = 0
        if not empty:
            y += 1
    
    output.close()

    # Save mapping
    json.dump(mapping, open('mapping.txt', 'w'))

if __name__ == "__main__":
    lst = os.listdir()
    lst.sort()
    for tilemap in lst:
        if tilemap.endswith('.csv'):
            convert(tilemap)
            print("Converted " + tilemap)
             