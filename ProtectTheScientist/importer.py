#
# This script is used to convert tileset to list of image.
#

from PIL import Image

def resize(img):
    w, h = img.size
    if w == h:
        return img
    elif w > h:
        img2 = Image.new('RGBA', (w, w), (0, 0, 0, 0))
        img2.paste(img, (0, (w - h)))
        return img2
    else:
        img2 = Image.new('RGBA', (h, h), (0, 0, 0, 0))
        img2.paste(img, ((h - w) // 2, 0))
        return img2
    
if __name__ == '__main__':
    mod = input('Mod: ')
    if mod == 'grid':
        w = int(input('Width: '))
        h = int(input('Height: '))
        path = input('Path: ')
        img = Image.open(path)

        while True:
            x = int(input('X: '))
            y = int(input('Y: '))
            name = input('Name: ')
            if "*" in name:
                count = int(input('Count: '))
                for i in range(count):
                    resize(img.crop((w*(x+i), h*y, w*(x+i) + w, h*y + h))).save("java_resourcepack/assets/minecraft/textures/item/" + name.replace('*', str(i)) + ".png")
            else:
                resize(img.crop((w*x, h*y, w*x + w, h*y + h))).save("java_resourcepack/assets/minecraft/textures/item/" + name + ".png")
    elif mod == 'single':
        name = input('Name: ')
        x = int(input('X: '))
        y = int(input('Y: '))
        w = int(input('Width: '))
        h = int(input('Height: '))
        path = input('Path: ')
        img = Image.open(path)
        resize(img.crop((x, y, x + w, y + h))).save("java_resourcepack/assets/minecraft/textures/item/" + name + ".png")