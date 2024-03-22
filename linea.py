from canvas import Canvas
import time; delay = .01


class Linea:
  def __init__(self, p1: tuple, p2: tuple) -> None:
    self.x1, self.y1 = p1
    self.x2, self.y2 = p2


  def bresenham(self, canvas: Canvas, color: str = '#fff') -> None:
    dY = self.y2 - self.y1
    dX = self.x2 - self.x1

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
    x, y = self.x1, self.y1

    while True:
      time.sleep(delay)
      canvas.draw_pixel(x, y, c=color)

      if av >= 0:
        x += IncXi
        y += IncYi
        av += avI
      else:
        x += IncXr
        y += IncYr
        av += avR

      if (x, y) == (self.x2, self.y2):
        break


  def dda(self, canvas: Canvas, color: str = '#fff') -> None:
    dX = self.x2 - self.x1
    dY = self.y2 - self.y1
    l = abs(dX) if abs(dX) >= abs(dY) else abs(dY)
    deltaX = dX / l
    deltaY = dY / l
    x, y = self.x1, self.y1

    for _ in range(l):
      time.sleep(delay)
      canvas.draw_pixel(x, y, c=color)
      x += deltaX
      y += deltaY


  # TODO: EVALUAR
  # def ecuacion(self, canvas: Canvas, color='#fff') -> None:
  #   m = (self.y2 - self.y1) / (self.x2 - self.x1) 
  
  #   for x in range(self.x1, self.x2 + 1): 
  #     y = round(m * x + c)
