import tkinter as tk
import time
from canvas import Canvas


def bresenham(a, b, canvas, tam, color='#fff') -> None:
    x1, y1 = a
    x2, y2 = b
    dY = y2 - y1
    dX = x2 - x1

    if dY >= 0:
        IncYi = 1
    else:
        dY = -dY
        IncYi = -1

    if dX >= 0:
        IncXi = 1
    else:
        dX = -dX
        IncXi = -1

    if dX >= dY:
        IncYr = 0
        IncXr = IncXi
    else:
        IncXr = 0
        IncYr = IncYi
        dY, dX = dX, dY

    avR = dY << 1
    av = avR - dX
    avI = av - dX
    x, y = x1, y1
    f = True

    while f:
        canvas.draw_pixel(x, y, tam, color)

        if av >= 0:
            x += IncXi
            y += IncYi
            av += avI
        else:
            x += IncXr
            y += IncYr
            av += avR

        if x == x2 and y == y2: f = False


def DDA(a, b, canvas, tam, color='#fff') -> None:
    x1, y1 = a
    x2, y2 = b
    dX = x2 - x1
    dY = y2 - y1
    l = abs(dX) if abs(dX) >= abs(dY) else abs(dY)

    deltaX = dX / l
    deltaY = dY / l
    
    x, y = x1, y1
    for _ in range(l):
        canvas.draw_pixel(x, y, tam, color)
        x += deltaX
        y += deltaY


def ecuacion(a, b, canvas, tam, color='#fff') -> None:
    x1, y1 = a
    x2, y2 = b
    dx = x2 - x1
    dy = y2 - y1

    if dx == 0:
        x = x1
        deltaY = 1 if dy >= 0 else -1

        for y in range(y1, y2, deltaY):
            canvas.draw_pixel(x, y, tam, color)

    else:
        m = dy / dx
        k = y1 - m * x1

        if abs(dx) >= abs(dy):
            steps = abs(dx)
        else:
            steps = abs(dy)

        deltaX = dx / steps
        x, y = x1, y1
        for _ in range(steps):
            canvas.draw_pixel(round(x), round(y), tam, color)
            x = x + deltaX
            y = m * x + k


if __name__ == '__main__':
    root = tk.Tk()
    canvas = Canvas(root, 1280, 720)
    tam_pixel = 1

    p1, p2 = [100, 30], [1000, 279]
    t = time.time()
    bresenham(p1, p2, canvas, tam_pixel)
    print(f'Bresenham tardo: {time.time() - t}')

    p1, p2 = [100, 130], [1000, 379]
    t = time.time()
    DDA(p1, p2, canvas, tam_pixel, '#1ff')
    print(f'DDA tardo: {time.time() - t}')

    p1, p2 = [100, 230], [1000, 479]
    t = time.time()
    ecuacion(p1, p2, canvas, tam_pixel, '#0f0')
    print(f'La Ecuacion tardo: {time.time() - t}')

    root.mainloop()
