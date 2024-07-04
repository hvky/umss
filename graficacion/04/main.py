import sys
from Window import MainWindow
from PyQt6.QtWidgets import QApplication


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow(1280, 720)
    window.show()
    sys.exit(app.exec())
