from PIL import Image, ImageDraw, ImageEnhance, ImageChops
import sys

path = "lib/theblueman_screen/java_resourcepack/assets/minecraft/textures/item/"

if (__name__ == "__main__"):
    img = Image.open(path+sys.argv[1]+".png").convert("RGBA")
    img = img.resize((256, 256), Image.NEAREST)
    img.save(path+sys.argv[1]+".png")

    # add lime border
    img2 = Image.new("RGBA", size=(256,256))
    img2.paste(img, (0,0),img)
    draw = ImageDraw.Draw(img2)
    draw.rectangle([(0,0),(255,143)], outline=(0,255,0,255), width=2)
    img2.save(path+sys.argv[1]+"_selected.png")

    # add aqua border
    img2 = Image.new("RGBA", size=(256,256))
    img2.paste(img, (0,0),img)
    draw = ImageDraw.Draw(img2)
    draw.rectangle([(0,0),(255,143)], outline=(0,255,255,255), width=2)
    img2.save(path+sys.argv[1]+"_clicked.png")

    # grayscale
    img2 = Image.new("RGBA", size=(128,128))
    img2.paste(img, (0,0),img)
    img2 = img2.convert("L")
    img2.save(path+sys.argv[1]+"_disabled.png")