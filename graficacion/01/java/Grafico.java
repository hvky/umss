abstract public class Grafico extends Primitiva {
  public void dibujarRelleno() {
    dibujarRelleno(new XColor(255, 255, 255), 0);
  }

  abstract public void dibujarRelleno(XColor color, int delay);
}
