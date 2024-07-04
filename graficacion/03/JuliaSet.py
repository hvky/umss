from PyQt6.QtGui import QColor


def draw_julia_set(width, height, iterations, painter):
    iterations *= 2
    c = complex(-0.7, 0.27015)

    for x in range(width):
        for y in range(height):
            zx = 1.5 * (x - width / 2) / (0.5 * width)
            zy = (y - height / 2) / (0.5 * height)
            z = complex(zx, zy)
            m = julia(z, c, iterations)

            if m == iterations:
                color = QColor(0, 0, 0)
            else:
                color = QColor(255 - int(m * 255 / iterations),
                               0, int(m * 255 / iterations))

            painter.setPen(color)
            painter.drawPoint(x, y)


def julia(z, c, iterations):
    n = 0
    while abs(z) <= 2 and n < iterations:
        z = z * z + c
        n += 1
    return n
