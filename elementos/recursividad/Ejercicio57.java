public class Ejercicio57 {
    private static int INF_NEG = -1000000;

    public int autocontenciones(String numero, int base) {
        int res = autocontenciones(numero, base, 0, 0);
        return (res < 0) ? -1 : res;
    }

    private int autocontenciones(String numero, int base, int idx, int exp) {
        int respuesta;

        if (idx == numero.length()) {
            respuesta = 0;
        } else {
            int act = elevar(base, exp),
                tam = tam(act);

            if (idx+tam <= numero.length()) {
                int num = Integer.parseInt(numero.substring(idx, idx+tam));
                respuesta = (num == act)
                        ? autocontenciones(numero, base, idx+tam, exp+1) + 1
                        : INF_NEG;
            } else
                respuesta = INF_NEG;
        }

        return respuesta;
    }

    private int elevar(int a, int b) {
        return (b == 0) ? 1 : a * elevar(a, b-1);
    }

    private int tam(int num) {
        return (num == 0) ? 0 : 1 + tam(num / 10);
    }


    public static void main(String[] args) {
        Ejercicio57 e = new Ejercicio57();

        String numeros[] = {"1101001000100001000001000000", "1392781", "1248163254", "111111111111111"};
        int bases[] = {10, 3, 2, 1};

        for (int i = 0; i < bases.length; i++)
            System.out.printf("El numero '%s' tiene '%d' autocontenciones de base '%d'\n",
                    numeros[i], e.autocontenciones(numeros[i], bases[i]), bases[i]);
    }
}
