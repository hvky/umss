import java.awt.Color;
import java.awt.Point;
import javax.swing.JFrame;

import graphics.*;
import utilities.*;


public class Main {
  private static void init(JFrame frame, Panel panel) {
    frame.add(panel);
    frame.pack();
    frame.setLocationRelativeTo(null);
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.setResizable(false);
    frame.setVisible(true);
  }

  public static void main(String[] args) {
    int w = 1080, h = 720, escala = 1;
    JFrame frame = new JFrame("Graficacion");
    Panel panel = new Panel(w, h, escala);
    init(frame, panel);

    Grafico g;
    g = new Triangulo(new Point(200, 200), new Point(200, 400), new Point(400, 200), w, h, 10, new Estilo(5, 5));
    // g = new Circunferencia(new Point(150, 150), 100, w, h, 1, new Estilo(5, 5));

    graficar(g, panel);
    Utils.pausar(1000);

    g.trasladar(200, 50);
    graficar(g, panel);
    Utils.pausar(1000);

    g.escalar(1.5);
    graficar(g, panel);
    Utils.pausar(1000);

    g.rotar(90);
    graficar(g, panel);
  }
  
  private static void graficar(Grafico g, Panel panel) {
    panel.clear();
    panel.draw(g.getContorno(), Color.WHITE, 0);
    panel.draw(g.getRelleno(), Color.BLUE, 0);
  }
}
