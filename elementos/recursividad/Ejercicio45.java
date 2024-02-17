import java.util.HashMap;


public class Ejercicio45 {
    public HashMap<String, Integer> ocurrencias(String cad) {
        String palabras[] = cad.split("\\s+");
        HashMap<String, Integer> datos = new HashMap<String, Integer>();
        ocurrencias(palabras, 0, datos);
        return datos;
    }

    private void ocurrencias(String[] palabras, int idx, HashMap<String, Integer> datos) {
        if (idx < palabras.length) {
            if (datos.containsKey(palabras[idx])) {
                int act = datos.get(palabras[idx]);
                datos.put(palabras[idx], act+1);
            } else
                datos.put(palabras[idx], 1);

            ocurrencias(palabras, idx+1, datos);
        }
    }


    public static void main(String[] args) {
        Ejercicio45 e = new Ejercicio45();

        String cadenas[] = {
            "lo que no me mata me fortalece"
        };

        for (String x : cadenas) {
            HashMap<String, Integer> res = e.ocurrencias(x);
            for (String key : res.keySet())
                System.out.printf("%s -> %d\n", key, res.get(key));

            System.out.println();
        }
    }
}
