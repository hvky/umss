public class Ejercicio63 {
    public int transformaciones(int n) {
        int sum = (n / 10) + (n % 10),
            act = (n%10) * 10 + (sum%10);

        return transformaciones(n, act);
    }

    private int transformaciones(int n, int act) {
        int respuesta;

        // System.out.println(act);
        if (n == act) {
            respuesta = 1;
        } else {
            int sum = (act/10) + (act%10);
            act = (act%10) * 10 + (sum%10);
            respuesta = 1 + transformaciones(n, act);
        }

        return respuesta;
    }


    public static void main(String[] args) {
        Ejercicio63 e = new Ejercicio63();

        int valores[] = {26, 99, 0, 1, 2};
        for (int x : valores)
            System.out.printf("%d -> %d\n", x, e.transformaciones(x));
    }
}
