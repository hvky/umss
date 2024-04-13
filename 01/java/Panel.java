import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import javax.swing.JPanel;


public class Panel extends JPanel {
  private BufferedImage img;
  private int w, h, escala;
  private Image scaledImage;

  public Panel(int widht, int height, int escala) {
    this.w = widht;
    this.h = height;
    this.escala = escala;
    this.img = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
    setPreferredSize(new Dimension(w * escala, h * escala));
  }

  @Override
  public void paintComponent(Graphics g) {
    super.paintComponent(g);
    scaledImage = img.getScaledInstance(w * escala, h * escala, Image.SCALE_DEFAULT);
    g.drawImage(scaledImage, 0, 0, this);
  }

  public void drawPixel(int x, int y, int color) {
    if (x < 0 || x >= w || y < 0 || y >= h) return;

    img.setRGB(x, y, color);
    repaint();
  }

  public void limpiar() {
    this.img = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
    repaint();
  }
}
