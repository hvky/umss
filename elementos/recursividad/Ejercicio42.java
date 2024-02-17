public class Ejercicio42 {
    public int existen(String cad, String pat) {
        return existen(cad, pat, 0, 0);
    }

    private int existen(String cad, String pat, int pos1, int pos2) {
        int respuesta;

        if (pos2 == pat.length()) {
            respuesta = 1 + existen(cad, pat, pos1-pos2+1, 0);
        } else if (pos1 == cad.length()) {
            respuesta = 0;
        } else {
            if (cad.charAt(pos1) == pat.charAt(pos2)) {
                pos1++;
                pos2++;
            } else {
                pos1 -= pos2 - 1;
                pos2 = 0;
            }

            respuesta = existen(cad, pat, pos1, pos2);
        }

        return respuesta;
    }


    public static void main(String[] args) {
        Ejercicio42 e = new Ejercicio42();

        String[] cads = {"aaabbabbaa", "atatata", "aaaaaaa"},
                 pats = {"abba", "ata", "a"};

        for (int i = 0; i < cads.length; i++)
            System.out.printf("El patron '%s' se encuentra '%d' veces en: '%s'\n", 
                    pats[i], e.existen(cads[i], pats[i]), cads[i]);
    }
}
