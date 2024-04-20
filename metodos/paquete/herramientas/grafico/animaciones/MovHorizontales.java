package herramientas.grafico.animaciones;

import java.util.ArrayList;
import java.awt.Point;

public class MovHorizontales extends Animacion {
    public MovHorizontales(Point puntoInicial) {
        super(puntoInicial,new ArrayList<Point>(), true,"Movimientos_Horizontales");
        cargarPuntos();
    }

    private void cargarPuntos() {

        int g = puntoInicial.x;
        int h = puntoInicial.y;

        puntos.add(new Point(g, h+40));
        puntos.add(new Point(g, h));
        
    }
}