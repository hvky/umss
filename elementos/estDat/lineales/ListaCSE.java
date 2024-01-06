package estDat.lineales;


public class ListaCSE<T> implements Lista<T> {
    private NodoSE<T> ini;

    public ListaCSE() {
        ini = null;
    }

    public boolean esVacia() {
        return ini == null;
    }

    public void insertar(T dato) {
        NodoSE<T> nuevo = new NodoSE<T>(dato);

        if (esVacia())
            ini = nuevo;
        else {
            NodoSE<T> ult = acceder(longitud()-1, ini);
            ult.setSig(nuevo);
        }

        nuevo.setSig(ini);
    }

    public T eliminar(int pos) {
        T ans; int tam = longitud();

        if (pos >= 0 && pos < tam) {
            NodoSE<T> tmp;

            if (pos == 0) {
                ans = ini.getDato();

                if (tam == 1)
                    ini = null;
                else {
                    tmp = acceder(tam-1, ini);
                    tmp.setSig(ini.getSig());
                    ini = ini.getSig();
                }
            } else {
                tmp = acceder(pos-1, ini);
                NodoSE<T> cnt = tmp.getSig();
                tmp.setSig(cnt.getSig());
                ans = cnt.getDato();
            }
        } else
            ans = null;

        return ans;
    }

    public T acceder(int pos) {
        T ans;

        if (pos >= 0 && pos < longitud())
            ans = acceder(pos, ini).getDato();
        else
            ans = null;

        return ans;
    }

    public boolean buscar(T dato) {
        return buscar(dato, ini);
    }

    public int longitud() {
        return longitud(ini);
    }

    public void eliminarTodas(T dato) {
        if (!esVacia()) {
            eliminarTodas(dato, ini);

            if (ini.getDato().equals(dato))
                ini = (ini.getSig().equals(ini)) ? null : ini.getSig();
        }
    }

    public void vaciar() {
        ini = null;
    }

    public void reemplazar(int pos, T dato) {
        if (pos >= 0 && pos < longitud())
            acceder(pos, ini).setDato(dato);;
    }

    public String toString() {
        String ans;

        if (!esVacia())
            ans = "["+ ini.getDato() + toString(ini.getSig()) + "]";
        else
            ans = "";

        return ans;
    }

    public Lista<T> subLista(int ini, int fin) {
        Lista<T> ans = new ListaCSE<T>();

        if (ini >= 0 && ini < longitud() && ini <= fin)
            subLista(acceder(ini, this.ini), fin, ans);

        return ans;
    }

    public boolean equals(Lista<T> otra) {
        boolean ans;

        if (longitud() == otra.longitud())
            ans = equals(ini, otra, 0);
        else
            ans = false;

        return ans;
    }

    public void intercambiar(int pos1, int pos2) {
        int tam = longitud();

        if (pos1 >= 0 && pos1 < tam && pos2 >= 0 && pos2 < tam) {
            NodoSE<T> aux1 = acceder(pos1, ini),
                      aux2 = acceder(pos2, ini);
            T tmp = aux1.getDato();
            aux1.setDato(aux2.getDato());
            aux2.setDato(tmp);
        }
    }


    public void insertarTodos(Lista<T> otra) { return; }
    public void insertarTodos(Lista<T> otra, int pos) { return; }
    public void insertar(int pos, T dato) { return; }
    public T eliminar(T dato) { return null; }
    public T acceder(T dato) { return null; }
    public int indiceDe(T dato) { return 0; }
    public int indiceDe(T dato, int pos) { return 0; }
    public void invertir() { return; }
    public void eliminarTodos(int pos) { return; }


    /*** metodos auxiliares (recursivos) ***/

    private NodoSE<T> acceder(int pos, NodoSE<T> cnt) {
        return (pos == 0) ? cnt : acceder(pos-1, cnt.getSig());
    }

    private boolean buscar(T dato, NodoSE<T> cnt) {
        return (cnt.equals(ini)) ? false : (cnt.getDato().equals(dato))
                ? true
                : buscar(dato, cnt.getSig());
    }

    private int longitud(NodoSE<T> cnt) {
        return (cnt.equals(ini)) ? 0 : 1 + longitud(cnt.getSig());
    }

    private void eliminarTodas(T dato, NodoSE<T> cnt) {
        if (!cnt.equals(ini)) {
            if (cnt.getSig().getDato().equals(dato))
                cnt.setSig(cnt.getSig().getSig());
            else
                cnt = cnt.getSig();

            eliminarTodas(dato, cnt);
        }
    }

    private String toString(NodoSE<T> cnt) {
        return (cnt.equals(ini))
                ? ""
                : " " + cnt.getDato() + toString(cnt.getSig());
    }

    private void subLista(NodoSE<T> cnt, int fin, Lista<T> ans) {
        if (fin > 0 && !cnt.equals(ini)) {
            ans.insertar(cnt.getDato());
            subLista(cnt.getSig(), fin-1, ans);
        }
    }

    private boolean equals(NodoSE<T> cnt, Lista<T> l, int pos) {
        return (cnt.equals(ini)) ? true : !(cnt.getDato().equals(l.acceder(pos)))
                ? false
                : equals(cnt.getSig(), l, pos+1);
    }
}
