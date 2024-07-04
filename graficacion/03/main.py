import sys
from PyQt6.QtWidgets import QApplication
from Window import MainWindow

from Sierpinski import draw_sierpinski
from SnowFlake import draw_snowflake
from MandelBrot import draw_mandelbrot
from DragonCurve import draw_dragon_curve
from BarnsleyFern import draw_barnsley_fern
from JuliaSet import draw_julia_set


if __name__ == "__main__":
    fractals = {
        "triangulo_de_sierpinsky": draw_sierpinski,
        "copo_de_nieve": draw_snowflake,
        "curva_del_dragon": draw_dragon_curve,
        "helecho_de_barnsley": draw_barnsley_fern,

        "conjunto_de_julia_*": draw_julia_set,
        "mandelbrot_*": draw_mandelbrot,
    }

    app = QApplication(sys.argv)
    window = MainWindow(1280, 720, fractals)
    window.show()
    sys.exit(app.exec())
