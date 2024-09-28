import java.util.ArrayList;


public class Linea {
  private int x1, x2, y1, y2;

  public Linea(int[] p1, int[] p2) {
    x1 = p1[0];
    x2 = p2[0];
    y1 = p1[1];
    y2 = p2[1];
  }

  public ArrayList<int[]> bresenham() {
    ArrayList<int[]> ans = new ArrayList<int[]>();

    if (sonIguales())
      ans.add(new int[] { x1, y1 });
    else {
      int dx = x2 - x1,
          dy = y2 - y1;

      int IncYi;
      if (dy >= 0) {
        IncYi = 1;
      } else {
        dy = -dy;
        IncYi = -1;
      }

      int IncXi;
      if (dx >= 0) {
        IncXi = 1;
      } else {
        dx = -dx;
        IncXi = -1;
      }

      int IncXr, IncYr;
      if (dx >= dy) {
        IncYr = 0;
        IncXr = IncXi;
      } else {
        IncXr = 0;
        IncYr = IncYi;

        int tmp = dx;
        dx = dy; dy = tmp;
      }

      int x, y, avR, av, avI;
      x = x1; y = y1;
      avR = dy << 1;
      av = avR - dx;
      avI = av - dx;

      do {
        ans.add(new int[] { x, y });

        if (av >= 0) {
          x += IncXi;
          y += IncYi;
          av += avI;
        } else {
          x += IncXr;
          y += IncYr;
          av += avR;
        }
      } while (x != x2);
    }

    return ans;
  }

  public ArrayList<int[]> dda() {
    ArrayList<int[]> ans = new ArrayList<int[]>();

    if (sonIguales())
      ans.add(new int[] { x1, y1 });
    else {
      int Dx = x2 - x1,
          Dy = y2 - y1,
          longitud = (abs(Dx) >= abs(Dy)) ? Dx : Dy;

      float dx = (float) Dx / longitud,
            dy = (float) Dy / longitud;

      float x = x1 + 0.5f * sign(dx),
            y = y1 + 0.5f * sign(dy);

      for (int i = 1; i <= longitud; i++) {
        ans.add(new int[] { Math.round(x), Math.round(y) });
        x += dx;
        y += dy;
      }
    }

    return ans;
  }


  private boolean sonIguales() {
    return (x1 == x2 && y1 == y2);
  }

  private int abs(int n) {
    return (n > 0) ? n : -n;
  }
  
  private int sign(float n) {
    return (n == 0)
    ? 0
    : (n > 0) ? 1 : -1;
  }
}
