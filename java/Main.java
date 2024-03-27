import java.awt.*;
import java.util.ArrayList;
import javax.swing.*;

public class Main extends JFrame {
  private Panel canvas1, canvas2;
  private int delay = 100;

  public Main() {
    super("Main");
    canvas1 = new Panel();
    canvas2 = new Panel();

    setLayout(new GridLayout(1, 2));
    add(canvas1);
    add(canvas2);
    getContentPane().add(new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, canvas1, canvas2));
    pack();
    setDefaultCloseOperation(EXIT_ON_CLOSE);
    setLocationRelativeTo(null);
    setVisible(true);
  }

  public static void main(String[] args) {
    Main root = new Main();
    Linea l = new Linea(new int[] { 5, 13 }, new int[] { 90, 77 });
    Circunferencia c = new Circunferencia(50, 50, 40);

    root.dibujarLineas(l);
    root.dubujarCircunferencias(c);

    // root.dispose();   // Cierra el frame principal
    // root.analizarLineas(l, 100);
    // root.analizarCircunferencias(c, 100);
  }

  private void dibujarLineas(Linea l) {
    ArrayList<int[]> ptsBresenham = l.bresenham(),
                     ptsDda = l.dda();

    Thread bresenham = new Thread(() -> {
      for (int[] p : ptsBresenham) {
        this.canvas1.drawPixel(p[0], p[1]);

        try {
          Thread.sleep(delay);
        } catch (InterruptedException e) {
          e.printStackTrace();
        }
      }
    });

    Thread dda = new Thread(() -> {
      for (int[] p : ptsDda) {
        this.canvas2.drawPixel(p[0], p[1]);

        try {
          Thread.sleep(delay);
        } catch (InterruptedException e) {
          e.printStackTrace();
        }
      }
    });

    bresenham.start();
    dda.start();
  }

  private void analizarLineas(Linea l, int n) {
    long startTime, endTime, totalBresenham, totalDda;

    startTime = System.nanoTime();
    for (int i = 0; i < n; i++)
      l.bresenham();
    endTime = System.nanoTime();
    totalBresenham = endTime - startTime;

    startTime = System.nanoTime();
    for (int i = 0; i < n; i++)
      l.dda();
    endTime = System.nanoTime();
    totalDda = endTime - startTime;

    System.out.printf("Con %d iteraciones\nBresenham Tardo: %d\nDDA tardo: %d\n", n, totalBresenham / 10000,
        totalDda / 10000);
  }

  private void dubujarCircunferencias(Circunferencia c) {
    ArrayList<int[]> ptsBresenham = c.bresenham(),
                     ptsMidPoint = c.midpoint();

    Thread bresenham = new Thread(() -> {
      for (int[] p : ptsBresenham) {
        this.canvas1.drawPixel(p[0], p[1]);

        try {
          Thread.sleep(delay);
        } catch (InterruptedException e) {
          e.printStackTrace();
        }
      }
    });

    Thread midpoint = new Thread(() -> {
      for (int[] p : ptsMidPoint) {
        this.canvas2.drawPixel(p[0], p[1]);

        try {
          Thread.sleep(delay);
        } catch (InterruptedException e) {
          e.printStackTrace();
        }
      }
    });

    bresenham.start();
    midpoint.start();
  }

  private void analizarCircunferencias(Circunferencia c, int n) {
    long startTime, endTime, totalBresenham, totalMidPoint;

    startTime = System.nanoTime();
    for (int i = 0; i < n; i++)
      c.bresenham();
    endTime = System.nanoTime();
    totalBresenham = endTime - startTime;

    startTime = System.nanoTime();
    for (int i = 0; i < n; i++)
      c.midpoint();
    endTime = System.nanoTime();
    totalMidPoint = endTime - startTime;

    System.out.printf("Con %d iteraciones\nBresenham Tardo: %d\nPunto-Medio tardo: %d\n", n, totalBresenham / 10000,
        totalMidPoint / 10000);
  }
}
