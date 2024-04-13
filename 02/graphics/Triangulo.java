package graphics;

import java.awt.Point;
import java.util.ArrayList;

import utilities.Utils;


public class Triangulo extends Grafico {
  private Point p1, p2, p3;

  public Triangulo(Point p1, Point p2, Point p3, int width, int height) {
    this(p1, p2, p3, width, height, 1, null);
  }

  public Triangulo(Point p1, Point p2, Point p3, int width, int height, int grosor, Estilo estilo) {
    super(width, height, grosor, estilo);
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    reset();
  }

  @Override
  public void initContorno() {
    ptsContorno.clear();
    ptsContorno.addAll(new Linea(p1, p2, grosor, estilo, matriz).getPuntos());
    ptsContorno.addAll(new Linea(p2, p3, grosor, estilo, matriz).getPuntos());
    ptsContorno.addAll(new Linea(p3, p1, grosor, estilo, matriz).getPuntos());
  }

  // IMPLEMENTADO CON SCAN-LINE
  // TODO: MEJORAR, SOLO FUNCIONA DENTRO EL LIENZO
  @Override
  public void initRelleno() {
    if (ptsContorno.size() == 0) return;

    int x_min = Utils.min(new int[] { p1.x, p2.x, p3.x });
    int y_min = Utils.min(new int[] { p1.y, p2.y, p3.y });
    int x_max = Utils.max(new int[] { p1.x, p2.x, p3.x });
    int y_max = Utils.max(new int[] { p1.y, p2.y, p3.y });

    ArrayList<int[]> extremos = new ArrayList<int[]>();
    int x1, x2, cnt;

    for (int y = y_min + 1; y < y_max; y++) {
      x1 = x2 = cnt = -1;

      for (int x = x_min; x <= x_max; x++) {
        if (matriz[x][y] != 0) {
          if (x1 == -1 || cnt == x1) {
            x1 = x;
          } else {
            x2 = x;
            x = x_max + 1;
          }
        }

        cnt = x;
      }

      if (x2 != -1)
        extremos.add(new int[] {x1, x2, y});
    }

    for (int[] extremo : extremos)
      for (int x = extremo[0] + 1; x < extremo[1]; x++) {
        ptsRelleno.add(new Point(x, extremo[2]));
        matriz[x][extremo[2]] = 2;
      }
  }

  @Override
  public void trasladar(int dx, int dy) {
    p1.x += dx;
    p2.x += dx;
    p3.x += dx;
    p1.y += dy;
    p2.y += dy;
    p3.y += dy;

    reset();
  }

  @Override
  public void escalar(double aumento) {
    double cx = (p1.x + p2.x + p3.x) / 3.0;
    double cy = (p1.y + p2.y + p3.y) / 3.0;

    p1.x = (int) (cx + (p1.x - cx) * aumento);
    p1.y = (int) (cy + (p1.y - cy) * aumento);
    p2.x = (int) (cx + (p2.x - cx) * aumento);
    p2.y = (int) (cy + (p2.y - cy) * aumento);
    p3.x = (int) (cx + (p3.x - cx) * aumento);
    p3.y = (int) (cy + (p3.y - cy) * aumento);

    reset();
  }


  @Override
  public void rotar(int angulo) {
    double radianes = Math.toRadians(angulo);
    double coseno = Math.cos(radianes);
    double seno = Math.sin(radianes);
    double x1 = p1.x, y1 = p1.y;
    double x2 = p2.x, y2 = p2.y;
    double x3 = p3.x, y3 = p3.y;
    double cx = (x1 + x2 + x3) / 3.0;
    double cy = (y1 + y2 + y3) / 3.0;

    p1.x = (int) (cx + (x1 - cx) * coseno - (y1 - cy) * seno);
    p1.y = (int) (cy + (x1 - cx) * seno + (y1 - cy) * coseno);
    p2.x = (int) (cx + (x2 - cx) * coseno - (y2 - cy) * seno);
    p2.y = (int) (cy + (x2 - cx) * seno + (y2 - cy) * coseno);
    p3.x = (int) (cx + (x3 - cx) * coseno - (y3 - cy) * seno);
    p3.y = (int) (cy + (x3 - cx) * seno + (y3 - cy) * coseno);

    reset();
  }
}
