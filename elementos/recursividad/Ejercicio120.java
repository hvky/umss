public class Ejercicio120 {
    public int divisibles(int n) {
        int resultado[] = {0};
        divisibles(n, 1, 1, resultado);
        return resultado[0];
    }

    private void divisibles(int n, int acu, int act, int res[]) {
        if (act <= n) {
            res[0] += (acu % 3 == 0) ? 1 : 0;
            act++;
            divisibles(n, acu+act, act, res);
        }
    }


    public static void main(String args[]) {
        Ejercicio120 e = new Ejercicio120();

        int nums[] = {7, 10};
        for (int x : nums)
            System.out.printf("%d -> %d\n", x, e.divisibles(x));
    }
}
