import java.util.ArrayList;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import herramientas.grafico.animaciones.Animacion;
import herramientas.grafico.figuras.Figura;

abstract public class Serializado {
    
    public static void iniciar() {
        try {
            ArrayList<Animacion> animaciones = new ArrayList<Animacion>();
            FileOutputStream archivoSalida = new FileOutputStream("Animaciones.ser");
            ObjectOutputStream objetoSalida = new ObjectOutputStream(archivoSalida);
            objetoSalida.writeObject(animaciones);
            objetoSalida.close();
            archivoSalida.close();
            
            ArrayList<Figura> figuras = new ArrayList<Figura>();
            archivoSalida = new FileOutputStream("FigurasCompuestas.ser");
            objetoSalida = new ObjectOutputStream(archivoSalida);
            objetoSalida.writeObject(figuras);
            objetoSalida.close();
            archivoSalida.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static ArrayList<Animacion> getAnimaciones() {
        ArrayList<Animacion> animaciones = null;
        
        try {
            FileInputStream archivoEntrada = new FileInputStream("Animaciones.ser");
            ObjectInputStream objetoEntrada = new ObjectInputStream(archivoEntrada);
        
            animaciones = (ArrayList<Animacion>) objetoEntrada.readObject();
        
            objetoEntrada.close();
            archivoEntrada.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return animaciones;
    }
    
    public static ArrayList<Figura> getFiguras() {
        ArrayList<Figura> figuras = null;
        
        try {
            FileInputStream archivoEntrada = new FileInputStream("FigurasCompuestas.ser");
            ObjectInputStream objetoEntrada = new ObjectInputStream(archivoEntrada);
        
            figuras = (ArrayList<Figura>) objetoEntrada.readObject();
        
            objetoEntrada.close();
            archivoEntrada.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return figuras;
    }
    
    public static void serializarAnimacion(Animacion animacion) {
        if (animacion == null) return;
        
        ArrayList<Animacion> animaciones = getAnimaciones();
        if (animaciones == null) animaciones = new ArrayList<Animacion>();
        animaciones.add(animacion);
        
        try {
            FileOutputStream archivoSalida = new FileOutputStream("Animaciones.ser");
            ObjectOutputStream objetoSalida = new ObjectOutputStream(archivoSalida);
        
            objetoSalida.writeObject(animaciones);
        
            objetoSalida.close();
            archivoSalida.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void serializarFigura(Figura figura) {
        if (figura == null) return;
        
        ArrayList<Figura> figuras = getFiguras();
        if (figuras == null) figuras = new ArrayList<Figura>();
        figuras.add(figura);
        
        try {
            FileOutputStream archivoSalida = new FileOutputStream("FigurasCompuestas.ser");
            ObjectOutputStream objetoSalida = new ObjectOutputStream(archivoSalida);
        
            objetoSalida.writeObject(figuras);
        
            objetoSalida.close();
            archivoSalida.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}