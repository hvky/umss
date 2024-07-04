from OpenGL.GL import *
from OpenGL.GLU import *
from PyQt6.QtCore import Qt
from PyQt6.QtOpenGLWidgets import QOpenGLWidget


class Canvas(QOpenGLWidget):
    def __init__(self):
        super().__init__()
        self.figures = []
        self.selected = None
        self.lastPos = None
        self.setFocusPolicy(Qt.FocusPolicy.StrongFocus)

    def initializeGL(self):
        glClearColor(0.0, 0.0, 0.0, 1.0)
        glEnable(GL_DEPTH_TEST)
        glEnable(GL_LIGHTING)
        glEnable(GL_LIGHT0)
        glLightfv(GL_LIGHT0, GL_AMBIENT, [0.3, 0.3, 0.3, 1.0])
        glLightfv(GL_LIGHT0, GL_DIFFUSE, [0.7, 0.7, 0.7, 1.0])
        glEnable(GL_COLOR_MATERIAL)
        glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE)

    def resizeGL(self, width, height):
        glViewport(0, 0, width, height)
        glMatrixMode(GL_PROJECTION)
        glLoadIdentity()
        gluPerspective(45.0, width / height, 1.0, 100.0)
        glMatrixMode(GL_MODELVIEW)
        glLoadIdentity()

    def paintGL(self):
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
        glLoadIdentity()
        glTranslatef(0, 0, -10)

        for fig in self.figures:
            fig.draw()

    def add_figure(self, figure):
        self.figures.append(figure)
        self.update()

    def del_figure(self, idx):
        self.figures.pop(idx)
        self.selected = None
        self.update()

    def mousePressEvent(self, event):
        self.lastPos = event.position()

    def mouseMoveEvent(self, event):
        if self.lastPos is None or self.selected is None:
            return

        if self.selected.name is not None:
            return

        # ROTAR
        dx = event.position().x() - self.lastPos.x()
        dy = event.position().y() - self.lastPos.y()
        self.selected.rotation[0] += dy * 16
        self.selected.rotation[1] += dx * 16
        self.lastPos = event.position()
        self.update()

    def keyPressEvent(self, event):
        if self.selected is None:
            return

        # TRASLADAR
        if event.key() == Qt.Key.Key_W:
            self.selected.position[1] += 0.1
        elif event.key() == Qt.Key.Key_S:
            self.selected.position[1] -= 0.1
        elif event.key() == Qt.Key.Key_A:
            self.selected.position[0] -= 0.1
        elif event.key() == Qt.Key.Key_D:
            self.selected.position[0] += 0.1
        elif event.key() == Qt.Key.Key_Q:
            self.selected.position[2] += 0.1
        elif event.key() == Qt.Key.Key_E:
            self.selected.position[2] -= 0.1

        # ESCALAR
        elif event.key() == Qt.Key.Key_Plus and self.selected.name is None:
            self.selected.scale *= 1.1
        elif event.key() == Qt.Key.Key_Minus and self.selected.name is None:
            self.selected.scale /= 1.1
        self.update()
