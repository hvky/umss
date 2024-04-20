package herramientas.grafico.animaciones;

import java.util.ArrayList;
import java.awt.Point;

public class TrayectoriaCruz extends Animacion {
    public TrayectoriaCruz(Point puntoInicial) {
        super(puntoInicial,new ArrayList<Point>(), true,"Trayectoria_Cruz");
        cargarPuntos();
    }

    private void cargarPuntos() {

        int g = puntoInicial.x;
        int h = puntoInicial.y;

        puntos.add(new Point(g+50, h));
        puntos.add(new Point(g+50, h+150));
        puntos.add(new Point(g+200, h+150));
        puntos.add(new Point(g+200, h+200));
        puntos.add(new Point(g+50, h+200));
        puntos.add(new Point(g+50, h+350));
        puntos.add(new Point(g, h+350));
        puntos.add(new Point(g, h+200));
        puntos.add(new Point(g-150, h+200));
        puntos.add(new Point(g-150, h+150));
        puntos.add(new Point(g, h+150));
        puntos.add(new Point(g, h));
    }
}