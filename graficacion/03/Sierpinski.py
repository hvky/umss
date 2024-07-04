from PyQt6.QtCore import QPoint


def draw_sierpinski(width, height, iterations, painter):
    points = [(width >> 1, 10), (10, height - 10),
              (width - 10, height - 10)]
    sierpinski(painter, points, iterations)


def sierpinski(painter, points, depth):
    if depth == 0:
        painter.drawPolygon(*[QPoint(*point) for point in points])
    else:
        midpoints = [
            ((points[0][0] + points[1][0]) >> 1,
             (points[0][1] + points[1][1]) >> 1),
            ((points[1][0] + points[2][0]) >> 1,
             (points[1][1] + points[2][1]) >> 1),
            ((points[2][0] + points[0][0]) >> 1,
             (points[2][1] + points[0][1]) >> 1)
        ]
        sierpinski(painter, [points[0], midpoints[0], midpoints[2]], depth - 1)
        sierpinski(painter, [points[1], midpoints[0], midpoints[1]], depth - 1)
        sierpinski(painter, [points[2], midpoints[1], midpoints[2]], depth - 1)
