package herramientas.grafico.figuras;  

import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.Point;
import java.io.Serializable;
import java.util.ArrayList;
import javax.swing.JPanel;

import herramientas.grafico.animaciones.Animacion;

abstract public class Figura implements Serializable {
    private String nombre;
    protected Dimension dimension;
    protected Point posicion;
    protected transient JPanel panel;
    private transient Thread hiloAnimacion;
    private Animacion animacion;

    public Figura(Point posicion, Dimension dimension, JPanel panel, String nombre) {
        this.nombre = (nombre == null) ? "sin nombre" : nombre;
        this.posicion = (posicion == null) ? new Point() : posicion;
        this.dimension = (dimension == null)? new Dimension() : dimension;
        this.panel = panel;
        animacion = null;
    }

    public Figura(Point posicion, String nombre) {
        this(posicion, new Dimension(100, 100), null, nombre);
    }

    abstract public void dibujar(Graphics2D g2d);

    public void repintarPanel() {
        if (panel != null) panel.repaint();
    }

    public void mover(Point p) {
        setPosicion(p);
        repintarPanel();
    }

    public void animar() {
        if (hiloAnimacion == null) hiloAnimacion = new Thread();
        if (animacion == null) return;
        
        ArrayList<Point> puntos = animacion.getPuntos();
        boolean infinito = animacion.getInfinito();
        
        if (hiloAnimacion.isAlive() || puntos == null) return;

        hiloAnimacion = new Thread(new Runnable() {
                int deltaX, deltaY;
            
                @Override
                public void run() {
                    do {
                        for (Point p : puntos) {
                            if (p == null) continue;
                            
                            deltaX = (p.x > posicion.x) ? 1 : -1;
                            deltaY = (p.y > posicion.y) ? 1 : -1;
                            
                            while (posicion.x != p.x || posicion.y != p.y) {
                                if (posicion.x != p.x) setPosicionX(posicion.x + deltaX);
                                if (posicion.y != p.y) setPosicionY(posicion.y + deltaY);

                                repintarPanel();

                                try {
                                    Thread.sleep(3);
                                } catch (InterruptedException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    } while (infinito);
                }
            });
        hiloAnimacion.start();
    }
    
    public void detenerAnimacion() {
        if (hiloAnimacion != null)
            hiloAnimacion.stop();
    }

    public Point getPosicion() {
        return posicion;
    }

    public Dimension getDimension() {
        return dimension;
    }

    public JPanel getPanel() {
        return panel;
    }

    public String getNombre() {
        return nombre;
    }
    
    public Animacion getAnimacion() {
        return animacion;
    }

    public void setPosicion(Point posicion) {
        this.posicion = posicion;
    }

    public void setPosicionX(int x) {
        posicion.x = x;
    }

    public void setPosicionY(int y) {
        posicion.y = y;
    }

    public void setDimension(Dimension dimension) {
        this.dimension = dimension;
    }

    public void setPanel(JPanel panel) {
        this.panel = panel;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public void setAnimacion(Animacion animacion) {
        this.animacion = animacion;
    }

    @Override
    public String toString() {
        return nombre + " -> x: " + posicion.x + " y: " + posicion.y;
    }
}
