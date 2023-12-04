package other

import standard.debug
import mc.bedrock.Block

lazy json blocks = ["white_terracotta",
                    "orange_terracotta",
                    "magenta_terracotta",
                    "light_blue_terracotta",
                    "yellow_terracotta",
                    "lime_terracotta",
                    "pink_terracotta",
                    "gray_terracotta",
                    "light_gray_terracotta",
                    "cyan_terracotta",
                    "purple_terracotta",
                    "blue_terracotta",
                    "brown_terracotta",
                    "green_terracotta",
                    "red_terracotta",
                    "black_terracotta",
                    "white_concrete",
                    "orange_concrete",
                    "magenta_concrete",
                    "light_blue_concrete",
                    "yellow_concrete",
                    "lime_concrete",
                    "pink_concrete",
                    "gray_concrete",
                    "light_gray_concrete",
                    "cyan_concrete",
                    "purple_concrete",
                    "blue_concrete",
                    "brown_concrete",
                    "green_concrete",
                    "red_concrete",
                    "black_concrete",
                    "white_wool",
                    "orange_wool",
                    "magenta_wool",
                    "light_blue_wool",
                    "yellow_wool",
                    "lime_wool",
                    "pink_wool",
                    "gray_wool",
                    "light_gray_wool",
                    "cyan_wool",
                    "purple_wool",
                    "blue_wool",
                    "brown_wool",
                    "green_wool",
                    "red_wool",
                    "black_wool",
                    "purple_glazed_terracotta"]

Template block{
    foreach(block in blocks){
        Block block{
            setName(block)
            setNamespace("sl")
            setTexture("blocks/"+block)
        }
    }
}