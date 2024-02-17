package estDat.lineales;


public class ListaCDE<T> implements Lista<T> {
    private NodoDE<T> ini;

    public ListaCDE() {
        ini = null;
    }

    public boolean esVacia() {
        return ini == null;
    }

    public void insertar(T dato) {
        NodoDE<T> nuevo = new NodoDE<T>(dato);

        if (esVacia())
            ini = nuevo;
        else {
            NodoDE<T> ult = acceder(longitud()-1, ini);
            ult.setSig(nuevo);
            nuevo.setAnt(ult);
        }

        nuevo.setSig(ini);
        ini.setAnt(nuevo);
    }

    public T eliminar(int pos) {
        T ans; int tam = longitud();

        if (pos >= 0 && pos < tam) {
            NodoDE<T> tmp;

            if (pos == 0) {
                ans = ini.getDato();

                if (tam == 1)
                    ini = null;
                else {
                    tmp = ini.getAnt();
                    ini = ini.getSig();
                    tmp.setSig(ini);
                    ini.setAnt(tmp);
                }
            } else {
                tmp = acceder(pos, ini);
                ans = tmp.getDato();
                tmp.getAnt().setSig(tmp.getSig());
                tmp.getSig().setAnt(tmp.getAnt());
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
            eliminarTodas(dato, ini.getSig());

            if (ini.getDato().equals(dato)) {
                if (ini.getSig().equals(ini))
                    ini = null;
                else {
                    ini.getAnt().setSig(ini.getSig());
                    ini.getSig().setAnt(ini.getAnt());
                    ini = ini.getSig();
                }
            }
        }
    }

    public void vaciar() {
        ini = null;
    }

    public void reemplazar(int pos, T dato) {
        if (pos >= 0 && pos < longitud())
            acceder(pos, ini).setDato(dato);
    }

    public String toString() {
        String ans;

        if (!esVacia())
            ans = "[" + ini.getDato() + toString(ini.getSig()) + "]";
        else
            ans = "";

        return ans;
    }

    public Lista<T> subLista(int ini, int fin) {
        Lista<T> ans = new ListaCDE<T>();

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
            NodoDE<T> aux1 = acceder(pos1, ini),
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

    private NodoDE<T> acceder(int pos, NodoDE<T> cnt) {
        return (pos == 0) ? cnt : acceder(pos-1, cnt.getSig());
    }

    private boolean buscar(T dato, NodoDE<T> cnt) {
        return (cnt.equals(ini)) ? false : (cnt.getDato() == cnt)
                ? true
                : buscar(dato, cnt.getSig());
    }

    private int longitud(NodoDE<T> cnt) {
        return (cnt.equals(ini)) ? 0 : 1 + longitud(cnt.getSig());
    }

    private void eliminarTodas(T dato, NodoDE<T> cnt) {
        if (!cnt.equals(ini)) {
            if (cnt.getDato().equals(dato)) {
                cnt.getAnt().setSig(cnt.getSig());
                cnt.getSig().setAnt(cnt.getAnt());
            }

            eliminarTodas(dato, cnt.getSig());
        }
    }

    private String toString(NodoDE<T> cnt) {
        return (cnt.equals(ini))
                ? ""
                : " " + cnt.getDato() + toString(cnt.getSig());
    }

    private void subLista(NodoDE<T> cnt, int fin, Lista<T> ans) {
        if (fin > 0 && !cnt.equals(ini)) {
            ans.insertar(cnt.getDato());
            subLista(cnt.getSig(), fin, ans);
        }
    }

    private boolean equals(NodoDE<T> cnt, Lista<T> l, int pos) {
        return (cnt.equals(ini)) ? true : !(cnt.getDato().equals(l.acceder(pos)))
                ? false
                : equals(cnt.getSig(), l, pos+1);
    }
}
