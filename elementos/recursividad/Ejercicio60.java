public class Ejercicio60 {
    public boolean siames(int n) {
        int tam = tam(n),
            aux = tam / 2,
            num = generarNumero(n, aux + (tam%2));

        // System.out.printf("%d %d\n", n/elevar(aux), num);
        return n/elevar(aux) == num;
    }

    private int generarNumero(int n, int aux) {
        int numero;

        if (aux == 0) {
            numero = 0;
        } else {
            numero = generarNumero(n/10, aux-1) * 10 + (n % 10);
        }

        return numero;
    }

    private int elevar(int exp) {
        return (exp == 0) ? 1 : 10 * elevar(exp - 1);
    }

    private int tam(int num) {
        return (num == 0) ? 0 : 1 + tam(num / 10);
    }


    public static void main(String[] args) {
        Ejercicio60 e = new Ejercicio60();

        int valores[] = {123123, 343, 444};
        for (int x : valores)
            System.out.printf("Es siames %d: %s\n", x, (e.siames(x) ? "Si" : "No"));
    }
}
