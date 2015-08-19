import subprocess


def resize_image(input_path, output_path, width, height):
    thumbnail_size = "%dx%d" % (width, height)
    return subprocess.call([
        "convert",
        input_path,
        "-thumbnail",
        # the > below means don't enlarge images that fit in the 64x64 box
        thumbnail_size + ">",
        "-background",
        "transparent",
        "-gravity",
        "center",
        # fill the 64x64 box with the background color (which
        # is transparent) so all the thumbnails are exactly the
        # same size
        "-extent",
        thumbnail_size,
        output_path
    ])
