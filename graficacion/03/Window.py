from FractalCanvas import Canvas
from PyQt6.QtCore import Qt
from PyQt6.QtGui import QFont
from PyQt6.QtWidgets import (
    QHBoxLayout,
    QLabel,
    QListWidget,
    QMainWindow,
    QPushButton,
    QSizePolicy,
    QSlider,
    QSpacerItem,
    QVBoxLayout,
    QWidget,
)


class MainWindow(QMainWindow):
    def __init__(self, w, h, fractals: dict = {}):
        super().__init__()
        self.iterations = 1
        self.fractals = fractals
        self.listTextFractals = [
            x.replace("_", " ").capitalize() for x in fractals.keys()]

        self.setWindowTitle("FRACTALES")
        self.setFixedSize(w, h)
        self.labelFractal = QLabel()
        self.listFractals = QListWidget()
        self.slider = QSlider(Qt.Orientation.Horizontal)
        self.labelSlider = QLabel(str(self.iterations))
        self.btnAceptar = QPushButton(text="Graficar")
        self.canvas = Canvas(self.fractals)

        self.init()


    def init(self):
        self.labelFractal.setFont(QFont("Verdana", 14))
        self.labelFractal.setAlignment(Qt.AlignmentFlag.AlignCenter)

        self.listFractals.clicked.connect(self.listSelect)
        self.listFractals.setFont(QFont("Verdana", 12))
        self.listFractals.addItems(self.listTextFractals)
        self.listFractals.setSpacing(5)

        self.slider.valueChanged.connect(self.sliderChange)
        self.slider.setMinimum(1)
        self.slider.setMaximum(9)

        self.labelSlider.setFont(QFont("Verdana", 14))
        self.labelSlider.setAlignment(Qt.AlignmentFlag.AlignCenter)

        self.btnAceptar.clicked.connect(self.btnConfirm)
        self.btnAceptar.setFixedHeight(40)
        self.btnAceptar.setFont(QFont("Verdana", 14))
        self.btnAceptar.setEnabled(False)

        layoutLeft = QVBoxLayout()
        layoutLeft.setContentsMargins(0, 40, 0, 40)
        layoutLeft.addWidget(self.labelFractal)
        layoutLeft.addItem(QSpacerItem(
            0, 40, QSizePolicy.Policy.Fixed, QSizePolicy.Policy.Fixed))
        layoutLeft.addWidget(self.listFractals)
        layoutLeft.addItem(QSpacerItem(
            0, 40, QSizePolicy.Policy.Fixed, QSizePolicy.Policy.Fixed))
        layoutLeft.addWidget(self.slider)
        layoutLeft.addWidget(self.labelSlider)
        layoutLeft.addItem(QSpacerItem(
            0, 40, QSizePolicy.Policy.Fixed, QSizePolicy.Policy.Fixed))
        layoutLeft.addWidget(self.btnAceptar)

        layoutRight = QHBoxLayout()
        layoutRight.addWidget(self.canvas)

        layout = QHBoxLayout()
        layout.addLayout(layoutLeft, 20)
        layout.addLayout(layoutRight, 80)

        widget = QWidget()
        widget.setLayout(layout)
        self.setCentralWidget(widget)


    def listSelect(self):
        self.iterations = 1
        self.slider.setValue(1)
        self.btnAceptar.setEnabled(True)
        idxFractal = self.listFractals.currentRow()
        self.labelFractal.setText(self.listTextFractals[idxFractal])


    def sliderChange(self):
        self.iterations = self.slider.value()
        self.labelSlider.setText(str(self.iterations))


    def btnConfirm(self):
        fractalName = self.labelFractal.text().replace(" ", "_").lower()
        self.canvas.drawFractal(fractalName, self.iterations)
