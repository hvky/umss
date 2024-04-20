import java.util.HashMap;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;


abstract public class Archivo {
    public static HashMap<String, String> cargarUsuarios() {
        HashMap<String, String> usuarios = new HashMap<String, String>();
        
        try (BufferedReader br = new BufferedReader(new FileReader("users.txt"))) {
            String linea, valores[];
            while ((linea = br.readLine()) != null) {
                valores = linea.split("=");
                usuarios.put(valores[0], valores[1]);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return usuarios;
    }
    
    public static void borrarEstadisticas() {
        try (FileWriter writer = new FileWriter("estadisticaFigura.txt", false)) {
            
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        try (FileWriter writer = new FileWriter("estadisticaAnim.txt", false)) {
            
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public static void registrarUsuario(String cadena) {
        escribir(cadena, "users.txt");
    }
    
    public static void escribirEstadisticaFigura(String cadena) {
        escribir(cadena, "estadisticaFigura.txt");
    }
    
    public static void escribirEstadisticaAnimacion(String cadena) {
        escribir(cadena, "estadisticaAnim.txt");
    }
    
    private static void escribir(String cadena, String arch) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(arch, true))) {
            writer.write(cadena);
            writer.newLine();
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
