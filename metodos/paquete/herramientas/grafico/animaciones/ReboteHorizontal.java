package herramientas.grafico.animaciones;

import java.util.ArrayList;
import java.awt.Point;

public class ReboteHorizontal extends Animacion {
    public ReboteHorizontal(Point puntoInicial) {
        super(puntoInicial, new ArrayList<Point>(), true, "Rebote_Horizontal");
        cargarPuntos();
    }
    
    private void cargarPuntos() {
        puntos.add(new Point(900, puntoInicial.y));
        puntos.add(new Point(0, puntoInicial.y));
    }
}
