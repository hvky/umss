package herramientas.grafico.animaciones;

import java.util.ArrayList;
import java.awt.Point;

public class TrayectoriaCuadrada extends Animacion {
    public TrayectoriaCuadrada(Point puntoInicial) {
        super(puntoInicial,new ArrayList<Point>(), true,"Trayectoria_Cuadrada");
        cargarPuntos();
    }

    private void cargarPuntos() {

        int g = puntoInicial.x;
        int h = puntoInicial.y;

        puntos.add(new Point(g+100, h));
        puntos.add(new Point(g+100, h+100));
        puntos.add(new Point(g, h+100));
        puntos.add(new Point(g, h));
    }
}