package herramientas.grafico.animaciones;


import java.util.ArrayList;
import java.awt.Point;

public class MovLaterales extends Animacion {
    public MovLaterales(Point puntoInicial) {
        super(puntoInicial,new ArrayList<Point>(), true,"Movimientos_Laterales");
        cargarPuntos();
    }

    private void cargarPuntos() {

        int g = puntoInicial.x;
        int h = puntoInicial.y;

        puntos.add(new Point(g+40, h));
        puntos.add(new Point(g-40, h));
        
    }
}