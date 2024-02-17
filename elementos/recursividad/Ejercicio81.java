public class Ejercicio81 {
    public int pares(int secuencia[], int li, int ls) {
        int respuesta;

        if (li == ls+1) {
            respuesta = 0;
        } else {
            respuesta = pares(secuencia, li+1, ls) + (secuencia[li]%2 == 0 ? 1 : 0);
        }

        return respuesta;
    }


    public static void main(String args[]) {
        Ejercicio81 e = new Ejercicio81();

        int secuencia[] = {1, 2, 3, 4, 6, 6, 0, 2, -2, 5, 8, 10, 46, 81, 20};
        int intervalos[][] = {{0, 14}, {4, 9}};

        for (int i[] : intervalos)
            System.out.printf("Hay '%d' pares en el intervalo [%d, %d]\n",
                    e.pares(secuencia, i[0], i[1]), i[0], i[1]);
    }
}

// li <= ls && ls < n; n = numero de elementos de la secuencia
