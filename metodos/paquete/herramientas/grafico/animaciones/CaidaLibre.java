package herramientas.grafico.animaciones;

import java.awt.Point;
import java.util.ArrayList;

public class CaidaLibre extends Animacion {
    public CaidaLibre(Point puntoInicial) {
        super(puntoInicial, new ArrayList<Point>(), false, "Caida_Libre");
        cargarPuntos();
    }
    
    private void cargarPuntos() {
        puntos.add(new Point(puntoInicial.x, 700));
    }
}
