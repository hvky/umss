public class Triangulo extends Grafico {
  private Punto p1, p2, p3;

  public Triangulo(Punto p1, Punto p2, Punto p3, Panel canvas) {
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    this.canvas = canvas;
  }

  @Override
  public void dibujarContorno(int grosor, Estilo estilo, XColor color, int delay) {
    Linea l1 = new Linea(p1, p2, canvas),
          l2 = new Linea(p2, p3, canvas),
          l3 = new Linea(p3, p1, canvas);

    l1.dibujarContorno(grosor, estilo, color, delay);
    l2.dibujarContorno(grosor, estilo, color, delay);
    l3.dibujarContorno(grosor, estilo, color, delay);
  }

  @Override
  public void dibujarRelleno(XColor color, int delay) { }
}
