import java.util.ArrayList;


public class Ejercicio34 {
    public ArrayList<Integer> subsecdes(int secuencia[]) {
        ArrayList<Integer> respuesta = new ArrayList<Integer>(),
                           temp = new ArrayList<Integer>();
        temp.add(secuencia[0]);

        subsecdes(secuencia, 1, temp, respuesta);
        return respuesta;
    }

    private void subsecdes(int secuencia[], int idx, ArrayList<Integer> temp, ArrayList<Integer> respuesta) {
        if (idx == secuencia.length) {
            if (temp.size() > respuesta.size()) {
                respuesta.clear();
                respuesta.addAll(temp);
            }
        } else {
            if (secuencia[idx] >= secuencia[idx-1]) {
                if (temp.size() > respuesta.size()) {
                    respuesta.clear();
                    respuesta.addAll(temp);
                }

                temp.clear();
            }

            temp.add(secuencia[idx]);
            subsecdes(secuencia, idx+1, temp, respuesta);
        }
    }


    public static void main(String args[]) {
        Ejercicio34 e = new Ejercicio34();

        int secuencia[] = {2, 3, 5, 4, 3, 4, 2};
        ArrayList<Integer> res = e.subsecdes(secuencia);
        System.out.println(res);
    }
}

// secuencia.length > 0
