from figures.Esfera import Esfera
from figures.Plano import Plano
from Canvas import Canvas

from PyQt6.QtCore import QSize, Qt
from PyQt6.QtGui import QColor, QIcon, QPixmap
from PyQt6.QtWidgets import (
    QColorDialog,
    QFileDialog,
    QHBoxLayout,
    QLabel,
    QListWidget,
    QMainWindow,
    QPushButton,
    QRadioButton,
    QToolButton,
    QVBoxLayout,
    QWidget,
)


class MainWindow(QMainWindow):
    def __init__(self, w, h):
        super().__init__()
        self.setWindowTitle("Modelador 3D")
        self.setFixedSize(w, h)

        self.ult_item = 0
        self.idx = -1
        self.color_selected = QColor(12, 183, 242)
        self.texture_selected = None

        self.canvas = Canvas()
        layout = QHBoxLayout()
        central_widget = QWidget()
        right_layout = QVBoxLayout()
        right_widget = QWidget()
        layout_btns = QHBoxLayout()
        layout_radio = QHBoxLayout()
        layout_bdisplay = QHBoxLayout()
        layout_display = QHBoxLayout()
        self.btn_sphera = QToolButton()
        self.btn_plane = QToolButton()
        self.btnr_color = QRadioButton("Color")
        self.btnr_texture = QRadioButton("Textura")
        self.btn_color = QPushButton("Seleccionar Color")
        self.btn_texture = QPushButton("Seleccionar Textura")
        self.color_display = QLabel()
        self.texture_display = QLabel()
        self.btn_focus = QPushButton("Agregar Foco")
        self.btn_del = QPushButton("Eliminar Figura")
        self.list_widget = QListWidget()
        self.btn_accept = QPushButton("GRAFICAR")

        self.btn_sphera.setText("Esfera")
        self.btn_plane.setText("Plano")
        self.btn_sphera.setIcon(QIcon(QPixmap("icons/esfera.svg")))
        self.btn_plane.setIcon(QIcon(QPixmap("icons/plano.svg")))
        self.btn_sphera.setIconSize(self.btn_sphera.sizeHint())
        self.btn_plane.setIconSize(self.btn_plane.sizeHint())
        self.btn_sphera.setToolButtonStyle(
            Qt.ToolButtonStyle.ToolButtonTextUnderIcon)
        self.btn_plane.setToolButtonStyle(
            Qt.ToolButtonStyle.ToolButtonTextUnderIcon)
        self.btn_sphera.setIconSize(QSize(60, 60))
        self.btn_plane.setIconSize(QSize(60, 60))
        self.btn_sphera.setStyleSheet("width: 100")
        self.btn_plane.setStyleSheet("width: 100")
        self.btnr_color.setChecked(True)
        self.color_display.setFixedSize(QSize(50, 50))
        r = self.color_selected.red()
        g = self.color_selected.green()
        b = self.color_selected.blue()
        self.color_display.setStyleSheet(
            f"background-color: rgb({r}, {g}, {b});")
        self.texture_display.setFixedSize(QSize(50, 50))
        self.texture_display.setScaledContents(True)

        self.btn_color.clicked.connect(self.choose_color)
        self.btn_texture.clicked.connect(self.choose_texture)

        layout_btns.addWidget(self.btn_sphera)
        layout_btns.addWidget(self.btn_plane)
        layout_radio.addWidget(self.btnr_color)
        layout_radio.addWidget(self.btnr_texture)
        layout_bdisplay.addWidget(self.btn_color)
        layout_bdisplay.addWidget(self.btn_texture)
        layout_display.addWidget(self.color_display)
        layout_display.addWidget(self.texture_display)
        right_layout.addLayout(layout_btns)
        right_layout.addLayout(layout_radio)
        right_layout.addLayout(layout_bdisplay)
        right_layout.addLayout(layout_display)
        right_layout.addWidget(self.btn_focus)
        right_layout.addWidget(self.btn_del)
        right_layout.addWidget(self.list_widget)
        right_layout.addWidget(self.btn_accept)
        right_widget.setFixedWidth(int(w * 0.2))

        self.btn_sphera.clicked.connect(self.btn_sphera_clicked)
        self.btn_plane.clicked.connect(self.btn_plane_clicked)
        self.btn_focus.clicked.connect(self.btn_focus_clicked)
        self.btn_del.clicked.connect(self.btn_del_clicked)
        self.btn_accept.clicked.connect(self.btn_accept_clicked)
        self.list_widget.clicked.connect(self.btn_list_clicked)

        central_widget.setLayout(layout)
        right_widget.setLayout(right_layout)
        layout.addWidget(self.canvas)
        layout.addWidget(right_widget)
        self.setCentralWidget(central_widget)

    def btn_sphera_clicked(self):
        valid, texture = self.verify_texture()
        if not valid:
            return

        self.list_widget.addItem("Esfera")
        esfera = Esfera(color=self.get_color(), texture=texture)
        self.add_item(esfera)

    def btn_plane_clicked(self):
        valid, texture = self.verify_texture()
        if not valid:
            return

        print(texture)
        self.list_widget.addItem("Plano")
        plano = Plano(color=self.get_color(), texture=texture)
        self.add_item(plano)

    def btn_focus_clicked(self):
        self.list_widget.addItem("Foco")
        foco = Esfera(radius=0.1, color=(1.0, 1.0, 0.0), name='foco')
        self.add_item(foco)

    def add_item(self, figure):
        self.idx = self.ult_item
        self.list_widget.setCurrentRow(self.idx)
        self.canvas.add_figure(figure)
        self.canvas.selected = self.canvas.figures[self.idx]
        self.ult_item += 1

    def btn_del_clicked(self):
        if 0 <= self.idx < len(self.canvas.figures):
            self.list_widget.takeItem(self.idx)
            self.list_widget.setCurrentRow(-1)
            self.canvas.del_figure(self.idx)
            self.idx = -1
            self.ult_item -= 1

    def btn_list_clicked(self):
        self.idx = self.list_widget.currentRow()
        self.canvas.selected = self.canvas.figures[self.idx]

    def choose_color(self):
        color = QColorDialog.getColor(self.color_selected)

        if color.isValid():
            style = f"background-color: rgb({color.red()}, {color.green()}, {color.blue()});"
            self.color_display.setStyleSheet(style)
            self.color_selected = color

    def choose_texture(self):
        file_dialog = QFileDialog()
        img_path, _ = file_dialog.getOpenFileName(
            self, "Seleccionar Imagen", "", "Images (*.jpg *.png *.jpeg)")

        if img_path:
            pixmap = QPixmap(img_path)
            self.texture_display.setPixmap(pixmap)
            self.texture_selected = img_path

    def get_color(self):
        r = self.color_selected.redF()
        g = self.color_selected.greenF()
        b = self.color_selected.blueF()
        return (r, g, b)

    def verify_texture(self):
        ans = True
        x = None

        if self.btnr_texture.isChecked():
            ans = self.texture_selected != None
            if ans:
                x = self.texture_selected

        return (ans, x)

    def btn_accept_clicked(self):
        print('RAY TRACING EN FUNCIONALIDAD')
