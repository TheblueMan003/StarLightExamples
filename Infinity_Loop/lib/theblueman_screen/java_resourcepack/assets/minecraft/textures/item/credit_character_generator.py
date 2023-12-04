from PIL import Image, ImageDraw, ImageEnhance, ImageChops 
import requests
import io

import sys
import json
import shutil
from PIL import Image, ImageDraw, ImageEnhance

from base64 import b64decode
import textwrap
import urllib.request
import os

DEBUG = False
SIMULATE = False

userid_url = "https://api.mojang.com/users/profiles/minecraft/{username}"
userinfo_url = "https://sessionserver.mojang.com/session/minecraft/profile/{userid}"
path = "lib/theblueman_screen/java_resourcepack/assets/minecraft/textures/item/"
path2 = "lib/theblueman_screen/bedrock_resourcepack/textures/entities/"

class SimulatedResponse(object):
    def __init__(self, content, is_json, raw=None):
        self.content = content
        self.is_json = is_json
        self.status_code = 200
        self.raw = raw

    def json(self):
        if self.is_json:
            return json.loads(self.content)
        return None

def fail(msg, verbose_msg):
    print(msg, file=sys.stderr)
    if DEBUG:
        print(verbose_msg, file=sys.stderr)

def find_texture_info(properties):
    for prop in properties:
        if prop['name'] == 'textures':
            return json.loads(b64decode(prop['value'], validate=True).decode('utf-8'))
    return None
    
def get_url(url, **kwargs):
    if SIMULATE:
        content = None
        is_json = False
        raw = None
        # These files are not provided in the git repo because I consider them
        # kind of sensitive.  Feel free to provide your own in their place.
        if url.startswith('https://api.mojang.com/users/profiles/minecraft/'):
            with open('simulated_userid_response.json', 'r') as f:
                content = f.read()
            is_json = True
        elif url.startswith('https://sessionserver.mojang.com/session/minecraft/profile/'):
            with open('simulated_userinfo_response.json', 'r') as f:
                content = f.read()
            is_json = True
        else:
            with open('simulated_skin_response.png', 'rb') as f:
                content = f.read()
            is_json = False
            raw = io.BytesIO(content)
        return SimulatedResponse(content, is_json, raw)
    else:
        return requests.get(url, **kwargs)

def download(username):
    r = get_url(userid_url.format(username=username))
    if r.status_code != 200:
        shutil.copyfile("tmpIN.png", "tmp.png")
        fail("Could not retrieve user ID for {username}".format(username=username),
             "{0} {1}".format(r.status_code, userid_url.format(username=username)))
    else:
       userid = r.json()['id']

       r = get_url(userinfo_url.format(userid=userid))
       if r.status_code != 200:
           fail("Failed to download user info for {username}".format(username=username),
                "{0} {1}".format(r.status_code, userinfo_url.format(userid=userid)))
                
       userinfo = r.json()
       texture_info = find_texture_info(userinfo['properties'])
       if texture_info is None:
           fail("Failed to find texture info for {username}".format(username=username),
                userinfo)

       try:
           skin_url = texture_info['textures']['SKIN']['url']
       except:
           fail("Failed to find texture info for {username}".format(username=username),
                texture_info)
       r = get_url(skin_url, stream=True)
       if r.status_code != 200:
           fail("Could not download skin for {username}".format(username=username),
                "{0} {1}".format(r.status_code, skin_url))
       if DEBUG:
           print("{0} {1}".format(r.status_code, skin_url), file=sys.stderr)

       with open("tmp.png", 'wb') as f:
           shutil.copyfileobj(r.raw, f)
    img = Image.open("tmp.png")
    try:
      if img.size[1] < 64 or img.getpixel((32,52))[3] == 0:
         print("resize")
         img2 = Image.new("RGBA", size=(64,64))
         arm = img.crop((40,16,40+16,32))
         leg = img.crop((0,16,16,32))
         img2.paste(img, (0,0),img)
         img2.paste(arm, (32,48),arm)
         img2.paste(leg, (16,48),leg)
         img2.save("tmp.png")
    except Exception as e:
      print(e)

def generate(file, name):
    skin = Image.open(file)
    base = Image.open(path + "credit_character_base.png")
    final = Image.open(path + "credit_character_base.png")
    mask = Image.open(path + "credit_character_base_mask.png")
    overlay = Image.open(path + "credit_character_base_overlay.png").convert("RGBA")
    overlayClicked = Image.open(path + "credit_character_base_overlay_clicked.png").convert("RGBA")
    overlaySelected = Image.open(path + "credit_character_base_overlay_selected.png").convert("RGBA")
    overlayDisabled = Image.open(path + "credit_character_base_overlay_disabled.png").convert("RGBA")
    
    def copy_from_to(source, target, x, y, w, h, x1, y1):
        img2 = Image.new("RGBA", size=(19,28))
        side = source.crop((x,y,x+w,y+h))
        img2.paste(side, (x1, y1))
        return Image.alpha_composite(target, img2)
    def copy_from_to2(source, target, x, y, w, h, x1, y1, w1, h1):
        img2 = Image.new("RGBA", size=(19,28))
        side = source.crop((x,y,x+w,y+h)).resize((w1, h1), resample=Image.NEAREST)
        img2.paste(side, (x1, y1))
        return Image.alpha_composite(target, img2)
    def apply_mask(source):
        return ImageChops.multiply(source, mask)
    def center(image):
        img = Image.new("RGBA", size=(32,32))
        img.paste(image, (16 - image.size[0] // 2, 16 - image.size[1] // 2))
        return img
    def bedrock(image):
        img = Image.new("RGBA", size=(64,64))
        img.paste(image, (16 - image.size[0] // 2, 16 - image.size[1] // 2))
        return img

    image = Image.new("RGBA", size=(36,36))
    image = copy_from_to(skin, final, 8, 8, 8, 8, 7, 3) # head
    image = copy_from_to(skin, image, 8+32, 8, 8, 8, 7, 3) # head 2
    image = copy_from_to2(skin, image, 0, 8, 8, 8, 4, 3, 3, 8) # side
    image = copy_from_to(skin, image, 16, 7, 8, 1, 7, 11) # neck
    image = copy_from_to(skin, image, 16+32, 7, 8, 1, 7, 11) # neck
    image = copy_from_to2(skin, image, 20, 20, 8, 12, 6, 12, 8, 9) # body
    image = copy_from_to2(skin, image, 20, 36, 8, 12, 6, 12, 8, 9) # vest
    image = copy_from_to(skin, image, 40, 23, 4, 9, 2, 12) # hand 1
    image = copy_from_to(skin, image, 40, 39, 4, 9, 2, 12) # hand 1 top
    image = copy_from_to(skin, image, 36, 55, 3, 9, 14, 12) # hand 2
    image = copy_from_to(skin, image, 52, 55, 3, 9, 14, 12) # hand 2 top
    image = copy_from_to(skin, image, 4, 26, 3, 5, 7, 21) # leg 1
    image = copy_from_to(skin, image, 4, 26+16, 3, 5, 7, 21) # leg 1 top
    image = copy_from_to(skin, image, 20, 58, 3, 5, 11, 21) # leg 2
    image = copy_from_to(skin, image, 4, 58, 3, 5, 11, 21) # leg 2 top
    image = apply_mask(image)

    center(Image.alpha_composite(image, overlay)).save(path + "credit_character_"+name.lower()+".png")
    bedrock(Image.alpha_composite(image, overlay)).save(path2 + "credit_character_"+name.lower()+".png")

    center(Image.alpha_composite(image, overlayClicked)).save(path + "credit_character_"+name.lower()+"_clicked.png")
    bedrock(Image.alpha_composite(image, overlayClicked)).save(path2 + "credit_character_"+name.lower()+"_clicked.png")

    center(Image.alpha_composite(image, overlaySelected)).save(path + "credit_character_"+name.lower()+"_selected.png")
    bedrock(Image.alpha_composite(image, overlaySelected)).save(path2 + "credit_character_"+name.lower()+"_selected.png")

    center(Image.alpha_composite(image, overlayDisabled)).save(path + "credit_character_"+name.lower()+"_disabled.png")
    bedrock(Image.alpha_composite(image, overlayDisabled)).save(path2 + "credit_character_"+name.lower()+"_disabled.png")

if (__name__ == "__main__"):
    for name in sys.argv[1::]:
        download(name)
        generate("tmp.png", name)
    os.remove("tmp.png")