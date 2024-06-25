import numpy as np
from OpenGL.GL import (
    GL_LINEAR,
    GL_RGBA,
    GL_TEXTURE_2D,
    GL_TEXTURE_MAG_FILTER,
    GL_TEXTURE_MIN_FILTER,
    GL_UNSIGNED_BYTE,
    glBindTexture,
    glGenTextures,
    glColor3f,
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
            glBindTexture(GL_TEXTURE_2D, self.texture)
        else:
            glColor3f(*self.color)
        self.draw_shape()
        glPopMatrix()

    def draw_shape(self):
        raise NotImplementedError("No se implemento!")

    def load_texture(self, path):
        if path is None:
            return

        image = Image.open(path)
        image = image.transpose(Image.Transpose.FLIP_TOP_BOTTOM)
        img_data = np.array(image.convert("RGBA"))
        texture_id = glGenTextures(1)
        glBindTexture(GL_TEXTURE_2D, texture_id)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, img_data.shape[1],
                     img_data.shape[0], 0, GL_RGBA, GL_UNSIGNED_BYTE, img_data)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
        self.texture = texture_id
