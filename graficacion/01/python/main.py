from canvas import Canvas
from circunferencia import Circunferencia
from linea import Linea
import threading
import time
import tkinter as tk


l = Linea((20, 20), (453, 337))
c = Circunferencia((250, 250), 200)


def draw_line() -> None:
  thread_bresenham = threading.Thread(target=l.bresenham, args=(canvas1, 'lightgreen'))
  thread_dda = threading.Thread(target=l.dda, args=(canvas2, 'yellow'))
  thread_bresenham.start()
  thread_dda.start()

def draw_circle() -> None:
  thread_midpoint = threading.Thread(target=c.midpoint, args=(canvas1, 'cyan'))
  thread_bresenham = threading.Thread(target=c.bresenham, args=(canvas2, 'orange'))
  thread_midpoint.start()
  thread_bresenham.start()


def draw_line_time(iteraciones) -> None:
  tmp = time.time()
  for _ in range(iteraciones):
    l.dda(canvas1, delay=0)
  time_dda = time.time() - tmp

  tmp = time.time()
  for _ in range(iteraciones):
    l.bresenham(canvas2, delay=0)
  time_bresenham = time.time() - tmp

  print(f'Tiempo DDA: {time_dda}\nTiempo Brensenham: {time_bresenham}')

def draw_circle_time(iteraciones) -> float:
  tmp = time.time()
  for _ in range(iteraciones):
    c.midpoint(canvas1, delay=0)
  time_minpoint = time.time() - tmp

  tmp = time.time()
  for _ in range(iteraciones):
    c.bresenham(canvas2, delay=0)
  time_bresenham = time.time() - tmp

  print(f'Tiempo Punto-Medio: {time_minpoint}\nTiempo Brensenham: {time_bresenham}')


if __name__ == '__main__':
  root = tk.Tk()
  root.geometry("1005x505")

  global canvas1, canvas2
  canvas1 = Canvas(root, 500, 500)
  canvas2 = Canvas(root, 500, 500)
  canvas1.canvas.place(x=0, y=0)
  canvas2.canvas.place(x=500, y=0)

  # Primer Punto
  draw_line()
  draw_circle()

  # Segundo punto -> comentar el root.mainloop()
  # draw_line_time(40)
  # draw_circle_time(40)

  root.mainloop()
