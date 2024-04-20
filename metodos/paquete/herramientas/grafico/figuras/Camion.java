package herramientas.grafico.figuras;

import java.awt.Color;
import java.awt.Point;
import java.awt.Dimension;
import javax.swing.JPanel;

public class Camion extends Compuesto {
    public Camion(Point posicion, JPanel panel) {
        super(posicion, panel, "Camion");
        iniciar();
    }

    public Camion(Point posicion) {
        this(posicion, null);
    }

    private void iniciar() {
        dimension = new Dimension(780, 370);

        // referencia
        //componentes.encolar(new Rectangulo(new Point(posicion.x, posicion.y), new Dimension(dimension.width, dimension.height), null, panel), 10);

        agregarFigura(new Rectangulo(new Point(posicion.x, posicion.y + 10), new Dimension(380, 20), new Color(16, 92, 12), panel));
        agregarFigura(new Rectangulo(new Point(posicion.x, posicion.y + 30), new Dimension(380, 200), new Color(0, 120, 0), panel));
        agregarFigura(new Rectangulo(new Point(posicion.x, posicion.y + 230), new Dimension(380, 40), new Color(42, 48, 155), panel));
        agregarFigura(new Rectangulo(new Point(posicion.x, posicion.y + 30), new Dimension(30, 200), new Color(16, 92, 12), panel));
        agregarFigura(new Rectangulo(new Point(posicion.x + 70, posicion.y + 30), new Dimension(30, 200), new Color(16, 92, 12), panel));
        agregarFigura(new Rectangulo(new Point(posicion.x + 140, posicion.y + 30), new Dimension(30, 200), new Color(16, 92, 12), panel));
        agregarFigura(new Rectangulo(new Point(posicion.x + 210, posicion.y + 30), new Dimension(30, 200), new Color(16, 92, 12), panel));
        agregarFigura(new Rectangulo(new Point(posicion.x + 280, posicion.y + 30), new Dimension(30, 200), new Color(16, 92, 12), panel));
        agregarFigura(new Rectangulo(new Point(posicion.x + 350, posicion.y + 30), new Dimension(30, 200), new Color(16, 92, 12), panel));
        agregarFigura(new Rectangulo(new Point(posicion.x + 380, posicion.y), new Dimension(200, 270), new Color(38, 38, 204), panel));
        agregarFigura(new Rectangulo(new Point(posicion.x + 580, posicion.y + 110), new Dimension(180, 160), new Color(38, 38, 204), panel));
        agregarFigura(new Rectangulo(new Point(posicion.x + 400, posicion.y + 20), new Dimension(160, 100), new Color(135, 206, 235), panel));

        agregarFigura(new Circulo(new Point(posicion.x + 740, posicion.y + 140), new Dimension(40, 40), Color.YELLOW, panel));
        agregarFigura(new Circulo(new Point(posicion.x + 100, posicion.y + 240), new Dimension(130, 130), Color.BLACK, panel));
        agregarFigura(new Circulo(new Point(posicion.x + 560, posicion.y + 240), new Dimension(130, 130), Color.BLACK, panel));
        agregarFigura(new Circulo(new Point(posicion.x + 125, posicion.y + 265), new Dimension(80, 80), Color.darkGray, panel));
        agregarFigura(new Circulo(new Point(posicion.x + 585, posicion.y + 265), new Dimension(80, 80), Color.darkGray, panel));
    }
}