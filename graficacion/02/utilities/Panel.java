package utilities;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Point;
import java.util.ArrayList;
import javax.imageio.ImageIO;
import javax.swing.JPanel;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;


public class Panel extends JPanel {
  private BufferedImage img;
  private int w, h, escala;

  public Panel(int width, int height) {
    this(width, height, 1);
  }

  public Panel(int widht, int height, int scale) {
    w = widht;
    h = height;
    escala = scale;
    img = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
    setPreferredSize(new Dimension(w * escala, h * escala));
  }

  @Override
  public void paintComponent(Graphics g) {
    super.paintComponent(g);
    Image scaledImage = img.getScaledInstance(w * escala, h * escala, Image.SCALE_DEFAULT);
    g.drawImage(scaledImage, 0, 0, this);
  }

  public void clear() {
    this.img = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
    repaint();
  }

  public void drawPixel(int x, int y, int color) {
    if (x < 0 || x >= w || y < 0 || y >= h) return;

    img.setRGB(x, y, color);
    repaint();
  }

  public void draw(ArrayList<Point> pts, Color color, int delay) {
    for (Point p : pts) {
      drawPixel(p.x, p.y, color.getRGB());
      Utils.pausar(delay);
    }
  }

  public void saveImage(String path) {
    try {
      File f = new File(path + "/image.png");
      ImageIO.write(img, "png", f);
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}
