from figures.Esfera import Esfera
from figures.Plano import Plano

from Canvas import Canvas
from PyQt6.QtCore import QSize, Qt
from PyQt6.QtGui import QIcon, QPixmap
from PyQt6.QtWidgets import (
    QHBoxLayout,
    QListWidget,
    QMainWindow,
    QPushButton,
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

        self.canvas = Canvas()
        layout = QHBoxLayout()
        central_widget = QWidget()
        right_layout = QVBoxLayout()
        right_widget = QWidget()
        layout_btns = QHBoxLayout()
        self.btn_sphera = QToolButton()
        self.btn_plane = QToolButton()
        self.btn_focus = QPushButton("Agregar Foco")
        self.btn_del = QPushButton("Eliminar Figura")
        self.list_widget = QListWidget()
        self.btn_accept = QPushButton("GRAFICAR")

        layout_btns.addWidget(self.btn_sphera)
        layout_btns.addWidget(self.btn_plane)
        self.btn_sphera.setText("Esfera")
        self.btn_plane.setText("Plano")
        self.btn_sphera.setIcon(QIcon(QPixmap("icons/esfera.svg")))
        self.btn_plane.setIcon(QIcon(QPixmap("icons/plano.svg")))
        self.btn_sphera.setIconSize(self.btn_sphera.sizeHint()) 
        self.btn_plane.setIconSize(self.btn_plane.sizeHint()) 
        self.btn_sphera.setToolButtonStyle(Qt.ToolButtonStyle.ToolButtonTextUnderIcon)
        self.btn_plane.setToolButtonStyle(Qt.ToolButtonStyle.ToolButtonTextUnderIcon)
        self.btn_sphera.setIconSize(QSize(60, 60))
        self.btn_plane.setIconSize(QSize(60, 60))
        self.btn_sphera.setStyleSheet("width: 100")
        self.btn_plane.setStyleSheet("width: 100")

        right_layout.addLayout(layout_btns)
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
        self.list_widget.addItem("Esfera")
        esfera = Esfera()
        self.add_item(esfera)

    def btn_plane_clicked(self):
        self.list_widget.addItem("Plano")
        plano = Plano()
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

    def btn_accept_clicked(self):
        print('RAY TRACING EN FUNCIONALIDAD')
