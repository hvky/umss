public class Ejercicio67 {
    public boolean tautograma(String cad) {
        cad = cad.toUpperCase();
        return tautograma(cad, cad.charAt(0), 1);
    }

    private boolean tautograma(String cad, char ini, int idx) {
        boolean respuesta;

        if (idx == cad.length()) {
            respuesta = true;
        } else {
            respuesta = true;
            char act = cad.charAt(idx);
            if (act != ' ' && cad.charAt(idx-1) == ' ')
                respuesta = act == ini;

            if (respuesta)
                respuesta = tautograma(cad, ini, idx+1);
        }

        return respuesta;
    }


    public static void main(String[] args) {
        Ejercicio67 e = new Ejercicio67();

        String valores[] = {
            "Flowers Flourish from France",
            "Sam Simmonds speaks softly",
            "Peter EpIckEd PePPers"
        };

        for (String x : valores)
            System.out.printf("Es tautograma '%s' -> %s\n", x, (e.tautograma(x) ? "Si" : "No"));
    }
}
