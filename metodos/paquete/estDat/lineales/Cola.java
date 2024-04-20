package estDat.lineales;

public class Cola<T> {
    private NodoDE<T> frente, fin;

    public Cola() {
        frente = fin = null;
    }

    public boolean vacia() {
        return frente == null && fin == null;
    }

    public void encolar(T dato) {
        NodoDE<T> nuevo = new NodoDE<T>(dato);

        if (vacia()) {
            frente = fin = nuevo;
        } else {
            nuevo.setAnt(fin);
            fin.setSig(nuevo);
            fin = nuevo;
        }
    }

    public T decolar() {
        if (vacia()) return null;

        T dato = frente.getDato();
        frente = frente.getSig();
        if (frente == null) {
            fin = null;
        } else {
            frente.getAnt().setSig(null);
            frente.setAnt(null);
        }
        return dato;
    }
}
