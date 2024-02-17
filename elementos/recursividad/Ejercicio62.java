public class Ejercicio62 {
    public int sinRepeticion(int n) {
        boolean esta[] = new boolean[10];
        return generarNumero(n, esta);
    }

    private int generarNumero(int n, boolean esta[]) {
        int numero;

        if (n == 0) {
            numero = 0;
        } else {
            numero = generarNumero(n/10, esta);

            if (!esta[n % 10]) {
                esta[n % 10] = true;
                numero = numero * 10 + (n % 10);
            }
        }

        return numero;
    }


    public static void main(String[] args) {
        Ejercicio62 e = new Ejercicio62();

        int valores[] = {345436456, 44444, 1233123};
        for (int x : valores)
            System.out.printf("%d -> %d\n", x, e.sinRepeticion(x));
    }
}
