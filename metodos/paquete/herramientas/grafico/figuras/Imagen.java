package herramientas.grafico.figuras;

import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.Point;
import javax.swing.JPanel;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class Imagen extends Figura {
    private String ruta;
    private transient BufferedImage imagen;
    
    public Imagen(Point posicion, Dimension dimension, String ruta, JPanel panel, String nombre) {
        super(posicion, dimension, panel, nombre);
        this.ruta = ruta;
    }

    public Imagen(Point posicion, String ruta, String nombre) {
        super(posicion, nombre);
        this.ruta = ruta;
    }
    
    @Override
    public void dibujar(Graphics2D g2d) {
        cargarImagen(ruta);
        g2d.drawImage(imagen, posicion.x, posicion.y, dimension.width, dimension.height, null);
    }

    private void cargarImagen(String ruta) {
        imagen = null;
        try {
            imagen = ImageIO.read(new File(ruta));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
