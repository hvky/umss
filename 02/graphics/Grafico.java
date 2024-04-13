package graphics;

import java.awt.Point;
import java.util.ArrayList;


abstract public class Grafico {
  protected ArrayList<Point> ptsContorno, ptsRelleno;
  protected int width, height, grosor, matriz[][];
  protected Estilo estilo;

  public Grafico(int widht, int height, int grosor, Estilo estilo) {
    ptsContorno = new ArrayList<Point>();
    ptsRelleno = new ArrayList<Point>();
    this.width = widht;
    this.height = height;
    this.grosor = grosor;
    this.estilo = estilo;
  }

  abstract protected void initContorno();

  abstract protected void initRelleno();

  public ArrayList<Point> getContorno() {
    return ptsContorno;
  }

  public ArrayList<Point> getRelleno() {
    return ptsRelleno;
  }

  public int[][] getMatriz() {
    return matriz;
  }

  protected void reset() {
    matriz = new int[width][height];
    ptsContorno.clear();
    ptsRelleno.clear();
    initContorno();
    initRelleno();
  }

  abstract public void trasladar(int dx, int dy);

  abstract public void escalar(int aumento);

  abstract public void rotar(int angulo);
}
