import numpy as np
from OpenGL.GL import (
    GL_LINEAR,
    GL_REPEAT,
    GL_RGBA,
    GL_TEXTURE_2D,
    GL_TEXTURE_MAG_FILTER,
    GL_TEXTURE_MIN_FILTER,
    GL_TEXTURE_WRAP_S,
    GL_TEXTURE_WRAP_T,
    GL_UNSIGNED_BYTE,
    glBindTexture,
    glGenTextures,
    glColor3f,
    glDisable,
    glEnable,
    glPopMatrix,
    glPushMatrix,
    glRotatef,
    glScalef,
    glTexImage2D,
    glTexParameteri,
    glTranslatef,
)
from PIL import Image


class Figura:
    def __init__(self, name, color, pathTexture):
        self.name = name
        self.color = color
        self.texture = None
        self.position = np.array([0.0, 0.0, 0.0])
        self.rotation = np.array([0.0, 0.0, 0.0])
        self.scale = 1.0
        self.load_texture(pathTexture)

    def draw(self):
        glPushMatrix()
        glTranslatef(*self.position)
        glScalef(self.scale, self.scale, self.scale)
        glRotatef(self.rotation[0] / 16, 1, 0, 0)
        glRotatef(self.rotation[1] / 16, 0, 1, 0)
        glRotatef(self.rotation[2] / 16, 0, 0, 1)
        if self.texture:
            glEnable(GL_TEXTURE_2D)
            glBindTexture(GL_TEXTURE_2D, self.texture)
            glColor3f(1.0, 1.0, 1.0)
        else:
            glDisable(GL_TEXTURE_2D)
            glColor3f(*self.color)
        self.draw_shape()
        glPopMatrix()

    def draw_shape(self):
        raise NotImplementedError("No se implemento!")

    def load_texture(self, path):
        if path is None:
            return

        image = Image.open(path)
        image = image.transpose(Image.FLIP_TOP_BOTTOM)
        image_data = image.convert("RGBA").tobytes()
        width, height = image.size
        texture_id = glGenTextures(1)
        glBindTexture(GL_TEXTURE_2D, texture_id)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, image_data)
        glBindTexture(GL_TEXTURE_2D, 0)
        self.texture = texture_id
