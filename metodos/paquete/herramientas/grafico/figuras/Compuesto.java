package herramientas.grafico.figuras;

import java.awt.Point;
import java.awt.Graphics2D;
import javax.swing.JPanel;

import estDat.lineales.ColaPrioridad;

public class Compuesto extends Figura {
    protected ColaPrioridad<Figura> componentes;
    
    public Compuesto(Point posicion, JPanel panel, String nombre) {
        super(posicion, null, panel, nombre);
        componentes = new ColaPrioridad<Figura>();
    }

    public Compuesto(Point posicion, String nombre) {
        this(posicion, null, nombre);
    }
    
    @Override
    public void dibujar(Graphics2D g2d) {
        for (Figura figura : componentes) {
            figura.dibujar(g2d);
        }
    }
    
    @Override
    public void setPosicion(Point p) {
        int deltaX, deltaY;
        
        for (Figura figura : componentes) {
            deltaX = figura.getPosicion().x - posicion.x;
            deltaY = figura.getPosicion().y - posicion.y;
            
            figura.setPosicionX(p.x + deltaX);
            figura.setPosicionY(p.y + deltaY);
        }
        
        posicion.x = p.x;
        posicion.y = p.y;
    }
    
    @Override
    public void setPosicionX(int x) {
        int deltaX;
        
        for (Figura figura : componentes) {
            deltaX = figura.getPosicion().x - posicion.x;
            figura.setPosicionX(x + deltaX);
        }
        
        posicion.x = x;
    }
    
    @Override
    public void setPosicionY(int y) {
        int deltaY;
        
        for (Figura figura : componentes) {
            deltaY = figura.getPosicion().y - posicion.y;
            figura.setPosicionY(y + deltaY);
        }
        
        posicion.y = y;
    }

    @Override
    public void setPanel(JPanel panel) {
        this.panel = panel;

        for (Figura f : componentes) {
            f.setPanel(panel);
        }
    }
    
    public void agregarFigura(Figura figura) {
        agregarFigura(figura, 10);
    }
    
    public void agregarFigura(Figura figura, int prioridad) {
        componentes.encolar(figura, prioridad);
    }
    
    public void eliminarFigura(int pos) {
        componentes.eliminar(pos);
    }

    public void eliminarTodo() {
        componentes.vaciar();
    }

    public ColaPrioridad<Figura> getComponentes() {
        return componentes;
    }

    public int getNroComponentes() {
        return componentes.getLongitud();
    }
}
