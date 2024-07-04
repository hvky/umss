import javax.swing.JFrame;


public class Main extends JFrame {
  private Panel canvas;

  public Main() {
    super("Main");
    canvas = new Panel(300, 150, 3);

    add(canvas);
    pack();
    setDefaultCloseOperation(EXIT_ON_CLOSE);
    setLocationRelativeTo(null);
    setVisible(true);
  }

  public static void main(String[] args) {
    Main root = new Main();
    Grafico c = new Circunferencia(new Punto(150, 75), 50, root.canvas),
            t = new Triangulo(
              new Punto(100, 20), new Punto(30, 100), new Punto(280, 20), root.canvas);

    c.dibujarContorno(1, new Estilo(4, 4), new XColor(255, 0, 0), 200);
    t.dibujarContorno(1, new Estilo(6, 3), new XColor(0, 0, 255), 20);
  }
}
