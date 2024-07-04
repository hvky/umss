import random
from PyQt6.QtGui import QColor
from PyQt6.QtCore import QPointF


def draw_barnsley_fern(width, height, iterations, painter):
    painter.setPen(QColor("green"))
    iterations <<= 5
    x, y = 0, 0

    for _ in range(iterations * iterations):
        next_x, next_y = barnsley_fern(x, y)
        x, y = next_x, next_y
        screen_x = width / 2 + x * width / 10
        screen_y = height - y * height / 12
        painter.drawPoint(QPointF(screen_x, screen_y))


def barnsley_fern(x, y):
    r = random.random()

    if r < 0.01:
        ans = (0, 0.16 * y)
    elif r < 0.86:
        ans = (0.85 * x + 0.04 * y, -0.04 * x + 0.85 * y + 1.6)
    elif r < 0.93:
        ans = (0.2 * x - 0.26 * y, 0.23 * x + 0.22 * y + 1.6)
    else:
        ans = (-0.15 * x + 0.28 * y, 0.26 * x + 0.24 * y + 0.44)

    return ans
