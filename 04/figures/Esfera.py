from figures.Figura import Figura
from OpenGL.GL import GL_TRUE
from OpenGL.GLU import (
    GLU_SMOOTH,
    gluDeleteQuadric,
    gluNewQuadric,
    gluQuadricNormals,
    gluQuadricTexture,
    gluSphere,
)


class Esfera(Figura):
    def __init__(self, radius=1.0, color=(0.0, 0.5, 1.0), texture=None, name=None):
        super().__init__(name, color, texture)
        self.radius = radius

    def draw_shape(self):
        quadric = gluNewQuadric()
        gluQuadricNormals(quadric, GLU_SMOOTH)
        if self.texture:
            gluQuadricTexture(quadric, GL_TRUE)
        gluSphere(quadric, self.radius, 32, 16)
        gluDeleteQuadric(quadric)
