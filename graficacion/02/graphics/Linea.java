package graphics;

import java.awt.Point;
import java.util.ArrayList;


public class Linea {
  private Point origen, destino;
  private int grosor, matriz[][];
  private Estilo estilo;
  private ArrayList<Point> pts;

  public Linea(Point p1, Point p2, int grosor, Estilo estilo, int[][] matriz) {
    this.origen = p1;
    this.destino = p2;
    this.grosor = grosor;
    this.estilo = estilo;
    this.matriz = matriz;
    this.pts = new ArrayList<Point>();
    init();
  }

  // IMPLEMENTADO CON EL ALGORITMO DE BRESENHAM
  private void init() {
    int incYi, incXi, incXr, incYr;
    int dx = destino.x - origen.x;
    int dy = destino.y - origen.y;
  
    if (dy >= 0) {
      incYi = 1;
    } else {
      incYi = -1;
      dy = -dy;
    }
  
    if (dx >= 0) {
      incXi = 1;
    } else {
      incXi = -1;
      dx = -dx;
    }
  
    if (dx >= dy) {
      incYr = 0;
      incXr = incXi;
    } else {
      incXr = 0;
      incYr = incYi;
  
      int tmp = dx;
      dx = dy;
      dy = tmp;
    }
  
    int x = origen.x;
    int y = origen.y;
    int avR = dy << 1;
    int av = avR - dx;
    int avI = av - dx;

    int pintar = -1;
    int noPintar = -1;
    int cnt = 1;

    if (estilo != null)
      pintar = estilo.pintar;
  
    while (true) {
      addPoints(x, y, cnt);

      if (av >= 0) {
        x += incXi;
        y += incYi;
        av += avI;
      } else{
        x += incXr;
        y += incYr;
        av += avR;
      }
  
      if (x == destino.x && y == destino.y)
        break;

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
    int x_, y_;

    for (int i = 0; i < grosor; i++) {
      x_ = x + i;

      for (int j = 0; j < grosor; j++) {
        y_ = y + j;

        if (x_ >= 0 && x_ < matriz.length && y_ >= 0 && y_ < matriz[0].length)
          if (matriz[x_][y_] == 0) {
            if (cnt == 1)
              pts.add(new Point(x_, y_));
            matriz[x_][y_] = cnt;
          }
      }
    }
  }

  public ArrayList<Point> getPuntos() {
    return pts;
  }
}
