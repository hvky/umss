package herramientas.grafico.animaciones;

import java.awt.Point;
import java.io.Serializable;
import java.util.ArrayList;

public class Animacion implements Serializable {
    private String nombre;
    private boolean infinito;
    protected ArrayList<Point> puntos;
    protected Point puntoInicial, puntoFinal;

    public Animacion(Point puntoInicial, ArrayList<Point> puntos, boolean infinito, String nombre) {
        this.puntoInicial = (puntoInicial == null) ? new Point() : puntoInicial;
        this.puntos = (puntos == null) ? new ArrayList<Point>() : puntos;
        this.nombre = (nombre == null) ? "sin nombre" : nombre;
        this.infinito = infinito;
        puntoFinal = null;
    }

    public Animacion(ArrayList<Animacion> animaciones, boolean infinito, String nombre) {
        this.infinito = infinito;
        this.nombre = (nombre == null) ? "sin nombre" : nombre;
        crearAnimacionCompuesta(animaciones);
    }

    private void crearAnimacionCompuesta(ArrayList<Animacion> animaciones) {
        Animacion animacion, ant;
        for (int i = 0; i < animaciones.size(); i++) {
            animacion = animaciones.get(i);
            animacion.setInfinito(false);
            if (i == 0) continue;

            ant = animaciones.get(i - 1);
            animacion.setPuntoInicial(ant.getPuntoFinal());
        }

        puntos = new ArrayList<Point>();
        for (Animacion a : animaciones) {
            puntos.addAll(a.getPuntos());
        }
    }
    
    public boolean getInfinito() {
        return infinito;
    }
    
    public ArrayList<Point> getPuntos() {
        //if (puntoInicial != null) puntos.add(0, puntoInicial);
        if (puntoFinal != null) {
            puntos.add(puntoFinal);
            infinito = false;
        }

        return puntos;
    }

    public Point getPuntoInicial() {
        return puntoInicial;
    }

    public Point getPuntoFinal() {
        return puntoFinal;
    }

    public String getNombre() {
        return nombre;
    }

    public void setInfinito(boolean infinito) {
        this.infinito = infinito;
    }

    public void setPuntoInicial(Point puntoInicial) {
        this.puntoInicial = puntoInicial;
    }

    public void setPuntoFinal(Point puntoFinal) {
        this.puntoFinal = puntoFinal;
    }

    @Override
    public String toString() {
        return nombre + " -> infinito: " + infinito;
    }
}
