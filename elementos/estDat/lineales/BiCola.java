package estDat.lineales;


public class BiCola<T> extends Cola<T> {
    public void addFront(T dato) {
        NodoDE<T> nuevo = new NodoDE<T>(dato);

        if (empty())
            fin = nuevo;
        else {
            ini.setAnt(nuevo);
            nuevo.setSig(ini);
        }

        ini = nuevo;
    }

    public T popBack() {
        T ans;

        if (empty())
            ans = null;
        else {
            ans = fin.getDato();
            fin = fin.getAnt();

            if (fin == null)
                ini = null;
            else
                fin.setSig(null);
        }

        return ans;
    }

    public T back() {
        return fin.getDato();
    }   
}
