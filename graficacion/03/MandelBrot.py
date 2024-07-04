from PyQt6.QtGui import QColor


def draw_mandelbrot(width, height, iterations, painter):
    iterations *= 3

    for x in range(width):
        for y in range(height):
            a = (x - width / 2) * 4.0 / width
            b = (y - height / 2) * 4.0 / height
            c = complex(a, b)
            m = mandelbrot(c, iterations)

            if m == iterations:
                color = QColor(0, 0, 0)
            else:
                color = QColor(255 - int(m * 255 / iterations),
                               0, int(m * 255 / iterations))

            painter.setPen(color)
            painter.drawPoint(x, y)


def mandelbrot(c, iterations):
    z = 0
    n = 0
    while abs(z) <= 2 and n < iterations:
        z = z*z + c
        n += 1
    return n
