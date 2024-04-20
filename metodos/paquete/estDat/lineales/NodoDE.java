package estDat.lineales;

public class NodoDE<T> {
    private T dato;
    private NodoDE<T> ant, sig;

    public NodoDE(T dato) {
        this.dato = dato;
        ant = sig = null;
    }

    public T getDato() {
        return dato;
    }

    public NodoDE<T> getAnt() {
        return ant;
    }

    public NodoDE<T> getSig() {
        return sig;
    }

    public void setDato(T dato) {
        this.dato = dato;
    }

    public void setAnt(NodoDE<T> ant) {
        this.ant = ant;
    }

    public void setSig(NodoDE<T> sig) {
        this.sig = sig;
    }
}
