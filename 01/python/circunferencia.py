from canvas import Canvas
import time; delay = .01


class Circunferencia:
  def __init__(self, punto_c: tuple, radio: int) -> None:
    self.x_c, self.y_c = punto_c
    self.r = radio


  def midpoint(self, l: Canvas, color: str = '#fff', delay=.01) -> list:
    out = []
    x = self.r
    y = 0
    P = 1 - self.r

    # time.sleep(delay)
    # l.draw_pixel(x + self.x_c, y + self.y_c, c=color)
    # out.append((x + self.x_c, y + self.y_c))

    while x > y:
      y += 1

      if P <= 0:
        P = P + (y << 1) + 1
      else:
        x -= 1
        P = P + (y << 1) - (x << 1) + 1

      if x < y:
        break

      tmp = [
        (self.x_c + x, self.y_c + y), (self.x_c - x, self.y_c + y),
        (self.x_c + x, self.y_c - y), (self.x_c - x, self.y_c - y),
      ]

      if x != y:
        tmp.extend([
          (self.x_c + y, self.y_c + x), (self.x_c - y, self.y_c + x),
          (self.x_c + y, self.y_c - x), (self.x_c - y, self.y_c - x),
        ])

      for x_, y_ in tmp:
        time.sleep(delay)
        l.draw_pixel(x_, y_, c=color)
        out.append((x_, y_))

    return out


  def bresenham(self, l: Canvas, color: str = '#fff', delay=.01) -> list:
    out = []

    def draw(x, y) -> None:
      tmp = [
        (self.x_c + x, self.y_c + y), (self.x_c - x, self.y_c + y),
        (self.x_c + x, self.y_c - y), (self.x_c - x, self.y_c - y),
        (self.x_c + y, self.y_c + x), (self.x_c - y, self.y_c + x),
        (self.x_c + y, self.y_c - x), (self.x_c - y, self.y_c - x),
      ]

      for x_, y_ in tmp:
        time.sleep(delay)
        l.draw_pixel(x_, y_, c=color)
        out.append((x_, y_))

    x = 0
    y = self.r
    d = 3 - (self.r << 1)
    draw(x, y)

    while y >= x:
      x += 1

      if d > 0:
        y -= 1
        d = d + ((x - y) << 2) + 10
      else:
        d = d + (x << 2) + 6

      draw(x, y)

    return out
