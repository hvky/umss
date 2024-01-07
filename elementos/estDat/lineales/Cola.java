package estDat.lineales;


public class Cola<T> {
    protected NodoDE<T> ini, fin;

    public Cola() {
        ini = null;
        fin = null;
    }

    public boolean empty() {
        return ini == null;
    }

    public void add(T dato) {
        NodoDE<T> nuevo = new NodoDE<T>(dato);

        if (empty())
            ini = nuevo;
        else {
            fin.setSig(nuevo);
            nuevo.setAnt(fin);
        }

        fin = nuevo;
    }

    public T pop() {
        T ans;

        if (empty())
            ans = null;
        else {
            ans = ini.getDato();
            ini = ini.getSig();

            if (empty())
                fin = null;
            else
                ini.setAnt(null);
        }

        return ans;
    }

    public T front() {
        return ini.getDato();
    }
}
