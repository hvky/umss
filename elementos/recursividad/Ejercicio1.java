public class Ejercicio1 {
    public int elevar(int a, int b) {
        int respuesta;

        if (b == 0) {
            respuesta = 1;
        } else {
            respuesta = elevar(a, b-1) * a;
        }

        return respuesta;
    }


    public static void main(String[] args) {
        Ejercicio1 e = new Ejercicio1();

        System.out.printf("%d ^ %d = %d\n", 3, 4, e.elevar(3, 4));
        System.out.printf("%d ^ %d = %d\n", 4, 0, e.elevar(4, 0));
    }
}
