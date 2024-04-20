package herramientas.grafico.figuras;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Point;
import javax.swing.JPanel;

abstract public class Simple extends Figura {
    protected Color color;
    
    public Simple(Point posicion, Dimension dimension, Color color, JPanel panel, String nombre) {
        super(posicion, dimension, panel, nombre);
        this.color = (color == null) ? Color.black : color;
    }

    public Simple(Point posicion, String nombre) {
        super(posicion, nombre);
        color = Color.black;
    }
    
    abstract public void dibujarContorno(Graphics g);
    
    public Color getColor() {
        return color;
    }
    
    public void setColor(Color color) {
        this.color = color;
        repintarPanel();
    }
}
