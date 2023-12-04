from PIL import Image

# Open the source image
source_image = Image.open("source.png")

# Define the dimensions of each card
card_width = 79
card_height = 123

# Define the order of the card types
card_types = ["clover", "diamond", "heart", "spade"]

def close(a, b):
    return abs(a - b) < 50

# Loop through each card type and number
for card_type in card_types:
    for card_number in range(1, 14):
        # Calculate the coordinates of the top-left corner of the card
        x = (card_number - 1) * card_width
        y = card_types.index(card_type) * card_height
        
        # Crop the card from the source image
        card_image = source_image.crop((x, y, x + card_width, y + card_height))

        # Save the card image with the appropriate filename
        filename = f"card_{card_type}_{card_number}.png"
        card_image.save(filename)
        
        # Replace all white pixels with aqua pixels
        for i in range(card_width):
            for j in range(card_height):
                p = card_image.getpixel((i, j))
                if close(p[0], p[1]) and close(p[0], p[2]):
                    card_image.putpixel((i, j), (0, p[1], p[2], p[3]))
    
        # Save the alternative image with the appropriate filename
        alt_filename = f"card_selected_{card_type}_{card_number}.png"
        card_image.save(alt_filename)

        
