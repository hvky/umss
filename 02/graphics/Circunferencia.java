package graphics;

import java.awt.Point;
import java.util.LinkedList;
import java.util.Queue;


public class Circunferencia extends Grafico {
  private Point centro;
  private int radio;

  public Circunferencia(Point puntoCentral, int radio, int width, int height) {
    this(puntoCentral, radio, width, height, 1, null);
  }

  public Circunferencia(Point puntoCentral, int radio, int width, int height, int grosor, Estilo estilo) {
    super(width, height, grosor, estilo);
    this.centro = puntoCentral;
    this.radio = radio;
    reset();
  }

  // IMPLEMENTADO CON EL ALGORITMO DE Point - MEDIO
  @Override
  public void initContorno() {
    int x = radio;
    int y = 0;
    int xChange = 1 - (radio << 1);
    int yChange = 1;
    int radiusError = 0;

    int pintar = -1;
    int noPintar = -1;
    int cnt = 1;

    if (estilo != null)
      pintar = estilo.pintar;

    while (x >= y) {
      addPoints(x, y, cnt);

      y++;
      radiusError += yChange;
      yChange += 2;

      if ((radiusError << 1) + xChange > 0) {
        x--;
        radiusError += xChange;
        xChange += 2;
      }

      if (estilo != null) {
        if (pintar > 0) {
          cnt = 1;
          pintar--;
        } else if (noPintar > 0) {
          cnt = 3;
          noPintar--;
        } else {
          pintar = estilo.pintar;
          noPintar = estilo.noPintar;
        }
      }
    }
  }

  private void addPoints(int x, int y, int cnt) {
    int x1_, x2_, x3_, x4_, y1_, y2_, y3_, y4_;
    int x1 = centro.x + x;
    int y1 = centro.y + y;
    int x2 = centro.x - x;
    int y2 = centro.y - y;
    int x3 = centro.x + y;
    int y3 = centro.y + x;
    int x4 = centro.x - y;
    int y4 = centro.y - x;

    for (int i = 0; i < grosor; i++) {
      x1_ = x1 + i;
      x2_ = x2 + i;
      x3_ = x3 + i;
      x4_ = x4 + i;

      for (int j = 0; j < grosor; j++) {
        y1_ = y1 + j;
        y2_ = y2 + j;
        y3_ = y3 + j;
        y4_ = y4 + j;

        if (x1_ >= 0 && x1_ < width) {
          if (y1_ >= 0 && y1_ < height)
            if (matriz[x1_][y1_] == 0) {
              if (cnt == 1)
                ptsContorno.add(new Point(x1_, y1_));
              matriz[x1_][y1_] = cnt;
            }
          if (y2_ >= 0 && y2_ < height)
            if (matriz[x1_][y2_] == 0) {
              if (cnt == 1)
                ptsContorno.add(new Point(x1_, y2_));
              matriz[x1_][y2_] = cnt;
            }
        }

        if (x2_ >= 0 && x2_ < width) {
          if (y1_ >= 0 && y1_ < height)
            if (matriz[x2_][y1_] == 0) {
              if (cnt == 1)
                ptsContorno.add(new Point(x2_, y1_));
              matriz[x2_][y1_] = cnt;
            }
          if (y2_ >= 0 && y2_ < height)
            if (matriz[x2_][y2_] == 0) {
              if (cnt == 1)
                ptsContorno.add(new Point(x2_, y2_));
              matriz[x2_][y2_] = cnt;
            }
        }

        if (x3_ >= 0 && x3_ < width) {
          if (y3_ >= 0 && y3_ < height)
            if (matriz[x3_][y3_] == 0) {
              if (cnt == 1)
                ptsContorno.add(new Point(x3_, y3_));
              matriz[x3_][y3_] = cnt;
            }
          if (y4_ >= 0 && y4_ < height)
            if (matriz[x3_][y4_] == 0) {
              if (cnt == 1)
                ptsContorno.add(new Point(x3_, y4_));
              matriz[x3_][y4_] = cnt;
            }
        }

        if (x4_ >= 0 && x4_ < width) {
          if (y3_ >= 0 && y3_ < height)
            if (matriz[x4_][y3_] == 0) {
              if (cnt == 1)
                ptsContorno.add(new Point(x4_, y3_));
              matriz[x4_][y3_] = cnt;
            }
          if (y4_ >= 0 && y4_ < height)
            if (matriz[x4_][y4_] == 0) {
              if (cnt == 1)
                ptsContorno.add(new Point(x4_, y4_));
              matriz[x4_][y4_] = cnt;
            }
        }
      }
    }
  }

  // IMPLEMENTADO CON EL ALGORITMO DE 4-VECINOS
  // TODO: IMPLEMENTAR ALGORITMO PARA LA BUSQUEDA DEL PUNTO INICIAL
  @Override
  public void initRelleno() {
    int[][] movs = { { 0, -1 }, { 1, 0 }, { 0, 1 }, { -1, 0 } };
    Point ini = centro;

    Queue<Point> cola = new LinkedList<Point>();
    cola.add(ini);

    while (!cola.isEmpty()) {
      Point p = cola.poll();
      if (matriz[p.x][p.y] != 0) continue;

      ptsRelleno.add(p);
      matriz[p.x][p.y] = 2;

      for (int[] idx : movs) {
        int x = p.x + idx[0];
        int y = p.y + idx[1];

        if (x >= 0 && x < width && y >= 0 && y < height)
          if (matriz[x][y] == 0)
            cola.add(new Point(x, y));
      }
    }
  }

  @Override
  public void trasladar(int dx, int dy) {
    centro.x += dx;
    centro.y += dy;
    reset();
  }

  @Override
  public void escalar(int aumento) {
    radio *= aumento;
    reset();
  }

  @Override
  public void rotar(int angulo) {
    return;
  }
}
