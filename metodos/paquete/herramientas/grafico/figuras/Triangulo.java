package herramientas.grafico.figuras;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Point;
import javax.swing.JPanel;


public class Triangulo extends Simple {
    private int[] puntosX, puntosY;
    
    public Triangulo(Point posicion, Dimension dimension, Color color, JPanel panel) {
        super(posicion, dimension, color, panel, "Triangulo");
    }

    public Triangulo(Point posicion) {
        super(posicion, "Triangulo");
    }
    
    @Override
    public void dibujar(Graphics2D g2d) {
        inicializar();
        posicionar();
        
        g2d.setColor(color);
        g2d.fillPolygon(puntosX, puntosY, 3);
    }
    
    @Override
    public void dibujarContorno(Graphics g) {
        inicializar();
        posicionar();
        
        g.setColor(color);
        g.drawPolygon(puntosX, puntosY, 3);
    }
    
    private void inicializar() {
        puntosX = new int[3];
        puntosY = new int[3];
        
        puntosX[0] = 0;
        puntosY[0] = dimension.height;
        
        puntosX[1] = dimension.width / 2;
        puntosY[1] = 0;
        
        puntosX[2] = dimension.width;
        puntosY[2] = dimension.height;
    }
    
    private void posicionar() {
        for (int i = 0; i < 3; i++) {
            puntosX[i] += posicion.x;
            puntosY[i] += posicion.y;
        }
    }
}