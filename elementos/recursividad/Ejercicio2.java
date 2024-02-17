public class Ejercicio2 {
    public boolean esPrimo(int n) {
        return n != 1 && esPrimo(n, 2);
    }

    private boolean esPrimo(int n, int aux) {
        boolean respuesta;

        if (aux > n/2) {
            respuesta = true;
        } else {
            if (n % aux == 0) {
                respuesta = false;
            } else {
                respuesta = esPrimo(n, aux+1);
            }
        }

        return respuesta;
    }


    public static void main(String[] args) {
        Ejercicio2 e = new Ejercicio2();

        int valores[] = {10, 2, 1, 123, 5, 29};
        for (int x : valores)
            System.out.printf("Es primo %d: %s\n", x, (e.esPrimo(x) ? "Si" : "No"));
    }
}
