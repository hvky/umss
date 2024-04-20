package herramientas.texto;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.Normalizer;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


abstract public class Texto {
    private static String[] conectores = {
            "Ante", "Bajo", "Cabe", "Contra", "Durante", "Entre", "Hacia", "Hasta", "Mediante",
            "Sobre", "Tras", "Versus", "Vía", "Ya bien", "Sin embargo",  "Con que", "Asi que",
            "Porque", "Puesto que", "Ya que", "Pues si", "Con tal que", "Siempre que",
            "Al menos que", "Por ejemplo", "Asi", "Ya", "Tal", "No", "A", "Y", "E", "Ni", "O",
            "U", "El", "La", "Los", "Las", "Un", "Una", "Unos", "Unas", "Sea", "Pero", "Mas",
            "Mi", "Sino", "Aunque", "De", "Con", "Que", "En", "Del", "Sin", "Si", "Tan", "Que",
            "Como", "Para", "Por", "Segun", "Luego", "Pues", "Desde"
    };

    public static int contarPalabrasFile(String rutaArchivo) {
        int res;

        try (BufferedReader bR = new BufferedReader(new FileReader(rutaArchivo))) {
            res = 0;
            String line;

            while ((line = bR.readLine()) != null) {
                res += contarPalabrasCadena(line);
            }
        } catch (IOException e) {
            res = -1;
            e.printStackTrace();
        }

        return res;
    }

    public static int contarPalabrasCadena(String cadena) {
        if (cadena == null) return -1;

        int res = 0;
        String[] palabras = normalizar(cadena).split("\\W+");
        Pattern pat = Pattern.compile("[a-zA-z]");
        Matcher mat;

        for (String p : palabras) {
            mat = pat.matcher(p);

            if (mat.find()) {
                res++;
            }
        }

        return res;
    }

    public static int contarRepeticionesFile(String rutaArchivo, String x) {
        int res;

        try (BufferedReader bR = new BufferedReader(new FileReader(rutaArchivo))) {
            res = 0;
            String line;

            while ((line = bR.readLine()) != null) {
                res += contarRepeticionesCadena(line, x);
            }
        } catch (IOException e) {
            res = -1;
            e.printStackTrace();
        }

        return res;
    }

    public static int contarRepeticionesCadena(String cadena, String x) {
        if (cadena == null || x == null) return -1;

        int res = 0;
        String[] palabras = normalizar(cadena.toLowerCase()).split("\\W+");
        x = normalizar(x.toLowerCase());

        for (String p : palabras) {
            if (x.equals(p)) {
                res++;
            }
        }

        return res;
    }

    public static boolean extraerConectoresFile(String rutaArchivo, String rutaDestino) {
        boolean res = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(rutaArchivo))) {
            File f = new File(rutaDestino);

            if (f.createNewFile()) {
                String line;
                BufferedWriter writer = new BufferedWriter(new FileWriter(f));

                while ((line = reader.readLine()) != null) {
                    writer.write(extraerConectoresCadena(line) + "\n");
                }

                writer.close();
                res = true;
            }
        } catch (IOException e) {
            res = false;
            e.printStackTrace();
        }

        return res;
    }

    public static String extraerConectoresCadena(String cadena) {
        if (cadena == null) return null;

        return cadena.replaceAll(generarRegExConectores(), "").replaceAll(" +", " ");
    }

    public static HashMap<String, Integer> numeroAparicionesFile(String rutaArchivo) {
        String cadena;

        try (BufferedReader bufferedReader = new BufferedReader(new FileReader(rutaArchivo))) {
            String line;
            cadena = "";

            while ((line = bufferedReader.readLine()) != null) {
                cadena += line + "\n";
            }
        } catch (IOException e) {
            cadena = null;
            e.printStackTrace();
        }

        return numeroAparicionesCadena(cadena);
    }

    public static HashMap<String, Integer> numeroAparicionesCadena(String cadena) {
        if (cadena == null) return null;

        HashMap<String, Integer> res = new HashMap<String, Integer>();
        String[] palabras = normalizar(cadena).split("\\W+");
        Pattern pat = Pattern.compile("[a-zA-z]");
        Matcher mat;

        for (String p : palabras) {
            mat = pat.matcher(p);

            if (mat.find()) {
                if (res.containsKey(p))
                    res.put(p, res.get(p) + 1);
                else
                    res.put(p, 1);
            }
        }

        return res;
    }


    private static String generarRegExConectores() {
        String con = conectores[0];
        String regEx = "\\b(" + con + "|" + con.toLowerCase() + "|" + con.toUpperCase();

        for (int i = 1; i < conectores.length; i++) {
            con = conectores[i];
            regEx += "|" + con + "|" + con.toLowerCase() + "|" + con.toUpperCase();
        }

        return regEx + ")\\b";
    }

    private static String normalizar(String cadena) {
        return Normalizer.normalize(cadena, Normalizer.Form.NFD)
                .replaceAll("\\p{InCombiningDiacriticalMarks}+", "")
                .replaceAll("[^\\p{ASCII}]", "");
    }
}
