package herramientas.grafico.figuras;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Point;
import javax.swing.JPanel;

public class Rectangulo extends Simple {
    public Rectangulo(Point posicion, Dimension dimension, Color color, JPanel panel) {
        super(posicion, dimension, color, panel, "Rectangulo");
    }

    public Rectangulo(Point posicion) {
        super(posicion, "Rectangulo");
    }
    
    @Override
    public void dibujar(Graphics2D g2d) {
        g2d.setColor(color);
        g2d.fillRect(posicion.x, posicion.y, dimension.width, dimension.height);
    }
    
    @Override
    public void dibujarContorno(Graphics g) {
        g.setColor(color);
        g.drawRect(posicion.x, posicion.y, dimension.width, dimension.height);
    }
}
