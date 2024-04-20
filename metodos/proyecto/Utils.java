import java.awt.Dimension;
import java.awt.Point;
import java.util.ArrayList;
import java.util.concurrent.CompletableFuture;
import javax.swing.JComboBox;

import herramientas.grafico.animaciones.*;
import herramientas.grafico.figuras.Figura;
import herramientas.grafico.figuras.Imagen;
import herramientas.grafico.figuras.Circulo;
import herramientas.voz.Escucha;


abstract public class Utils {
    
    public static Figura crearFigura(String nombreFigura, Point posicion) {
        Figura figura = switch (nombreFigura.toLowerCase()) {
            case "acordeon" ->  new Imagen(posicion, "imagenes/acordeon.png", "Acordeon");
            case "corno" ->     new Imagen(posicion, "imagenes/corno.png", "Corno");
            case "electrica" -> new Imagen(posicion, "imagenes/electrica.png", "Electrica");
            case "flauta" ->    new Imagen(posicion, "imagenes/flauta.png", "Flauta");
            case "guitarra" ->  new Imagen(posicion, "imagenes/guitarra.png", "Guitarra");
            case "mandolina" -> new Imagen(posicion, "imagenes/mandolina.png", "Mandolina");
            case "maracas" ->   new Imagen(posicion, "imagenes/maracas.png", "Maracas");
            case "microfono" -> new Imagen(posicion, "imagenes/microfono.png", "Microfono");
            case "piano" ->     new Imagen(posicion, "imagenes/piano.png", "Piano");
            case "platillos" -> new Imagen(posicion, "imagenes/platillos.png", "Platillos");
            case "saxofon" ->   new Imagen(posicion, "imagenes/saxofon.png", "Saxofon");
            case "tambor" ->    new Imagen(posicion, "imagenes/tambor.png", "Tambor");
            case "teclado" ->   new Imagen(posicion, "imagenes/teclado.png", "Teclado");
            case "trompeta" ->  new Imagen(posicion, "imagenes/trompeta.png", "Trompeta");
            case "tuba" ->      new Imagen(posicion, "imagenes/tuba.png", "Tuba");
            case "violin" ->    new Imagen(posicion, "imagenes/violin.png", "Violin");
            case "xilofono" ->  new Imagen(posicion, "imagenes/xilofono.png", "Xilofono");
            default -> new Circulo(posicion);
        };

        return figura;
    }
    
    public static Animacion crearAnimacion(String nombreAnimacion, Point puntoInicial) {
        Animacion animacion = switch (nombreAnimacion.toLowerCase()) {
            case "rebote horizontal" ->        new ReboteHorizontal(puntoInicial);
            case "caida libre" ->              new CaidaLibre(puntoInicial);
            case "movimientos horizontales" -> new MovHorizontales(puntoInicial);
            case "movimientos laterales" ->    new MovLaterales(puntoInicial);
            case "trayectoria cruz" ->         new TrayectoriaCruz(puntoInicial);
            case "trayectoria cuadrada" ->     new TrayectoriaCuadrada(puntoInicial);
            default -> null;
        };
        
        return animacion;
    }
    
    public static Point crearPosicion(String x, String y) {
        int posX = Integer.parseInt(x);
        int posY = Integer.parseInt(y);
        return new Point(posX, posY);
    }
    
    public static Dimension crearDimension(String width, String height) {
        int w = Integer.parseInt(width);
        int h = Integer.parseInt(height);
        return new Dimension(w, h);
    }
    
    public static void validarCampoSoloDigito(java.awt.event.KeyEvent e) {
        //Si el caracter introducido no es un digito...
        if (!Character.isDigit(e.getKeyChar())) {
            //... no lo escribe
            e.consume();
        }
    }
    
    public static void vozFiguras(JComboBox<String> comboBox) {
        CompletableFuture<String> resultadoFuture = new Escucha().arrancar();

        resultadoFuture.thenAccept(resultado -> {
            if (resultado != null) {
                System.out.println("Palabra reconocida: " + resultado);
                comboBox.setSelectedItem(resultado);
            } else {
                System.out.println("No se reconoció ninguna palabra.");
                comboBox.setSelectedItem(".");
            }
        });
    }
}
