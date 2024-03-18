import tkinter as tk
import time
from canvas import Canvas


def punto_medio(x_c, y_c, r, canvas, tam, color='#fff') -> None:
    x = r
    y = 0
    canvas.draw_pixel(x+x_c, y+y_c, tam, color)
    P = 1 - r

    while x > y:
        y += 1

        if P <= 0:
            P = P + (y << 1) + 1
        else:
            x -= 1
            P = P + (y << 1) - (x << 1) + 1

        if x < y: break

        canvas.draw_pixel(x + x_c, y + y_c, tam, color)
        canvas.draw_pixel(-x + x_c, y + y_c, tam, color)
        canvas.draw_pixel(x + x_c, -y + y_c, tam, color)
        canvas.draw_pixel(-x + x_c, -y + y_c, tam, color)

        if x != y:
            canvas.draw_pixel(y + x_c, x + y_c, tam, color)
            canvas.draw_pixel(-y + x_c, x + y_c, tam, color)
            canvas.draw_pixel(y + x_c, -x + y_c, tam, color)
            canvas.draw_pixel(-y + x_c, -x + y_c, tam, color)


def bresenham(x_c, y_c, r, canvas, tam, color='#fff') -> None:
    def draw_circle(x, y) -> None:
        canvas.draw_pixel(x_c+x, y_c+y, tam, color)
        canvas.draw_pixel(x_c-x, y_c+y, tam, color)
        canvas.draw_pixel(x_c+x, y_c-y, tam, color)
        canvas.draw_pixel(x_c-x, y_c-y, tam, color)
        canvas.draw_pixel(x_c+y, y_c+x, tam, color)
        canvas.draw_pixel(x_c-y, y_c+x, tam, color)
        canvas.draw_pixel(x_c+y, y_c-x, tam, color)
        canvas.draw_pixel(x_c-y, y_c-x, tam, color)

    x = 0
    y = r
    d = 3 - (r << 1)
    draw_circle(x, y)

    while y >= x:
        x += 1

        if d > 0:
            y -= 1
            d = d + ((x - y) << 2) + 10
        else:
            d = d + (x << 2) + 6

        draw_circle(x, y)


if __name__ == '__main__':
    root = tk.Tk()
    canvas = Canvas(root, 1280, 720)
    tam_pixel = 1

    t = time.time()
    punto_medio(300, 300, 240, canvas, tam_pixel, 'red')
    print(f'Punto-Medio tardo: {time.time() - t}')

    t = time.time()
    bresenham(900, 300, 240, canvas, tam_pixel, 'cyan')
    print(f'Bresenham tardo: {time.time() - t}')

    root.mainloop()
