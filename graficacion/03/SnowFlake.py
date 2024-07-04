from PyQt6.QtCore import QPointF


def draw_snowflake(width, height, iterations, painter):
    size = min(width, height)
    start_point = QPointF(width / 2 + size / 1.5, height / 1.5)
    end_point = QPointF(width / 2 - size / 1.5, height / 1.5)
    snowflake(painter, start_point, end_point, iterations)


def snowflake(painter, start_point, end_point, depth):
    if depth == 0:
        painter.drawLine(start_point, end_point)
    else:
        dx = (end_point.x() - start_point.x()) / 3
        dy = (end_point.y() - start_point.y()) / 3
        p1 = QPointF(start_point.x() + dx, start_point.y() + dy)
        p2 = QPointF(start_point.x() + 2 * dx, start_point.y() + 2 * dy)
        mid_x = (start_point.x() + end_point.x()) / 2
        mid_y = (start_point.y() + end_point.y()) / 2
        p3 = QPointF(mid_x - (dy * 3 ** 0.5) / 2, mid_y + (dx * 3 ** 0.5) / 2)

        snowflake(painter, start_point, p1, depth - 1)
        snowflake(painter, p1, p3, depth - 1)
        snowflake(painter, p3, p2, depth - 1)
        snowflake(painter, p2, end_point, depth - 1)
