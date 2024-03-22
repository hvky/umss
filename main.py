from canvas import Canvas
from circunferencia import Circunferencia
from linea import Linea
import threading
import time
import tkinter as tk


def draw_line() -> None:
  l = Linea((20, 457), (453, 33))

  def draw_bresenham() -> None:
    global time_bresenham_line
    time_bresenham_line = time.time()
    l.bresenham(canvas1, 'lightgreen')
    time_bresenham_line = time.time() - time_bresenham_line

  def draw_dda() -> None:
    global time_dda
    time_dda = time.time()
    l.dda(canvas2, 'yellow')
    time_dda = time.time() - time_dda

  thread_bresenham = threading.Thread(target=draw_bresenham)
  thread_dda = threading.Thread(target=draw_dda)
  thread_bresenham.start()
  thread_dda.start()


def draw_circle() -> None:
  c = Circunferencia((250, 250), 200)
  
  def draw_bresenham() -> None:
    global time_bresenham
    time_bresenham = time.time()
    c.bresenham(canvas1, 'cyan')
    time_bresenham = time.time() - time_bresenham

  def draw_midpoint() -> None:
    global time_midpoint
    time_midpoint = time.time()
    c.midpoint(canvas2, 'orange')
    time_midpoint = time.time() - time_midpoint

  thread_midpoint = threading.Thread(target=draw_midpoint)
  thread_bresenham = threading.Thread(target=draw_bresenham)
  thread_midpoint.start()
  thread_bresenham.start()


if __name__ == '__main__':
  root = tk.Tk()
  root.geometry("1005x505")

  global canvas1, canvas2
  canvas1 = Canvas(root, 500, 500)
  canvas2 = Canvas(root, 500, 500)
  canvas1.canvas.place(x=0, y=0)
  canvas2.canvas.place(x=500, y=0)

  draw_line()
  draw_circle()

  root.mainloop()
