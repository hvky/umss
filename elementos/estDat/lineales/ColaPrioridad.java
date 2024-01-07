package estDat.lineales;


public class ColaPrioridad<T extends Comparable<T>> extends Cola<T> {
    @Override
    public void add(T dato) {
        if (empty())
            super.add(dato);
        else if (fin.getDato().compareTo(dato) >= 0)
            super.add(dato);
        else {
            NodoDE<T> nuevo = new NodoDE<T>(dato);

            if (ini.getDato().compareTo(dato) < 0) {
                nuevo.setSig(ini);
                ini.setAnt(nuevo);
                ini = nuevo;
            } else {
                NodoDE<T> tmp = getNodo(dato, ini);
                nuevo.setSig(tmp);
                nuevo.setAnt(tmp.getAnt());
                tmp.getAnt().setSig(nuevo);
                tmp.setAnt(nuevo);
            }
        }
    }

    private NodoDE<T> getNodo(T dato, NodoDE<T> cnt) {
        return (cnt.getDato().compareTo(dato) < 0)
                ? cnt
                : getNodo(dato, cnt.getSig());
    }
}
