import java.awt.Color;


// FALTA DEFINIR ESTA CLASE
public class XColor {
  public int a, b, c;

  public XColor(int r, int g, int b) {
    this.a = r;
    this.b = g;
    this.c = b;
  }

  public int getValor() {
    return new Color(a, b, c).getRGB();
  }
}
