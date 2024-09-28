import java.awt.image.BufferedImage;
import java.awt.*;
import javax.swing.*;


public class Panel extends JPanel {
  private BufferedImage img;
  private int escala;
  private Image scaledImage;

  public Panel() {
    this.img = new BufferedImage(100, 100, BufferedImage.TYPE_INT_RGB);
    this.escala = 5;
    setPreferredSize(new Dimension(img.getWidth() * escala, img.getHeight() * escala));
  }

  @Override
  public void paintComponent(Graphics g) {
    super.paintComponent(g);
    scaledImage = img.getScaledInstance(
        img.getWidth() * escala, img.getHeight() * escala, Image.SCALE_DEFAULT);
    g.drawImage(scaledImage, 0, 0, this);
  }

  public void drawPixel(int x, int y) {
    img.setRGB(x, y, Color.WHITE.getRGB());
    repaint();
  }
}
