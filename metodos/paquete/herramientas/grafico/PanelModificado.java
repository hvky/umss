package herramientas.grafico;

import java.awt.Graphics;
import java.awt.Graphics2D;
import java.util.ArrayList;
import javax.swing.JPanel;

import herramientas.grafico.figuras.Figura;

public class PanelModificado extends JPanel {
    private ArrayList<Figura> figuras;
    private Figura fondo;

    public PanelModificado() {
        figuras = new ArrayList<Figura>();
        fondo = null;
    }

    public void agregarFigura(Figura figura) {
        figuras.add(figura);
        repaint();
    }

    public void agregarFondo(Figura figura) {
        this.fondo = figura;
        repaint();
    }

    public void agregarFiguras(ArrayList<Figura> figuras) {
        this.figuras.addAll(figuras);
        repaint();
    }

    public void eliminarFigura(int pos) {
        figuras.remove(pos);
        repaint();
    }

    public void borrarTodo() {
        figuras.clear();
        repaint();
    }

    public Figura getFondo() {
        return fondo;
    }

    public Figura getFigura(int pos) {
        return figuras.get(pos);
    }

    public ArrayList<Figura> getFiguras() {
        return figuras;
    }

    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        Graphics2D g2d = (Graphics2D) g;

        if (fondo != null) fondo.dibujar(g2d);
        for (Figura figura : figuras) {
            figura.dibujar(g2d);
        }
    }
}
