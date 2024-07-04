from PyQt6.QtGui import QPainter, QPixmap, QColor
from PyQt6.QtWidgets import QWidget


class Canvas(QWidget):
    def __init__(self, fractals):
        super().__init__()
        self.fractalName = ""
        self.iterations = 1
        self.fractals = fractals


    def drawFractal(self, fractalName, iterations):
        self.fractalName = fractalName
        self.iterations = iterations
        self.update()


    def paintEvent(self, event):
        pixmap = QPixmap(self.size())
        pixmap.fill(QColor("black"))
        painter = QPainter(pixmap)
        painter.setPen(QColor("white"))

        if self.fractalName in self.fractals:
            self.fractals[self.fractalName](
                pixmap.width(), pixmap.height(), self.iterations, painter)

        painter.end()
        screenPainter = QPainter(self)
        screenPainter.drawPixmap(0, 0, pixmap)
        screenPainter.end()
