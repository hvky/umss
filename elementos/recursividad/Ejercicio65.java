public class Ejercicio65 {
    public int cubo(int n) {
        return cubo(n, n * (n-1) + 1);
    }

    private int cubo(int n, int aux) {
        int respuesta;

        if (n == 0) {
            respuesta = 0;
        } else {
            respuesta = cubo(n-1, aux+2) + aux;
        }

        return respuesta;
    }


    public static void main(String[] args) {
        Ejercicio65 e = new Ejercicio65();

        int valores[] = {1, 2, 3, 4, 5};
        for (int x : valores)
            System.out.printf("%d ^ 3: %d\n", x, e.cubo(x));
    }
}
