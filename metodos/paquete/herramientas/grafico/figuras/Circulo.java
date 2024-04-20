package herramientas.grafico.figuras;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Point;
import javax.swing.JPanel;

public class Circulo extends Simple {
    public Circulo(Point posicion, Dimension dimension, Color color, JPanel panel) {
        super(posicion, dimension, color, panel, "Circulo");
    }

    public Circulo(Point posicion) {
        super(posicion, "Circulo");
    }
    
    @Override
    public void dibujar(Graphics2D g2d) {
        g2d.setColor(color);
        g2d.fillOval(posicion.x, posicion.y, dimension.width, dimension.height);
    }
    
    @Override
    public void dibujarContorno(Graphics g) {
        g.setColor(color);
        g.drawOval(posicion.x, posicion.y, dimension.width, dimension.height);
    }
}
