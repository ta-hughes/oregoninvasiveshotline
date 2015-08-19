import subprocess


def resize_image(input_path, output_path, width, height):
    size = "%dx%d" % (width, height)
    return subprocess.call([
        "convert",
        input_path,
        "-thumbnail",
        # the > below means don't enlarge images that fit in the box
        size + ">",
        "-background",
        "transparent",
        "-gravity",
        "center",
        # fill the box with the background color (which
        # is transparent)
        "-extent",
        size,
        output_path
    ])
