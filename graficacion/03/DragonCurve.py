from PyQt6.QtCore import QPointF


def draw_dragon_curve(width, height, iterations, painter):
    iterations <<= 1
    start_point = QPointF(width / 4, height / 2)
    end_point = QPointF(3 * width / 4, height / 2)
    dragon_curve(painter, start_point, end_point, iterations, True)


def dragon_curve(painter, start, end, depth, right):
    if depth == 0:
        painter.drawLine(start, end)
    else:
        mid = QPointF((start.x() + end.x()) / 2, (start.y() + end.y()) / 2)
        dx = (end.x() - start.x()) / 2
        dy = (end.y() - start.y()) / 2
        if right:
            mid = QPointF(mid.x() - dy, mid.y() + dx)
        else:
            mid = QPointF(mid.x() + dy, mid.y() - dx)
        dragon_curve(painter, start, mid, depth - 1, True)
        dragon_curve(painter, mid, end, depth - 1, False)
