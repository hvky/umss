package estDat.lineales;

import java.io.Serializable;

public class NodoPrioridad<T> implements Serializable {
    private T dato;
    private int prioridad;
    private NodoPrioridad<T> ant, sig;

    public NodoPrioridad(T dato, int prioridad) {
        this.dato = dato;
        this.prioridad = prioridad;
        ant = sig = null;
    }

    public T getDato() {
        return dato;
    }

    public int getPrioridad() {
        return prioridad;
    }

    public NodoPrioridad<T> getAnt() {
        return ant;
    }

    public NodoPrioridad<T> getSig() {
        return sig;
    }

    public void setDato(T dato) {
        this.dato = dato;
    }

    public void setPrioridad(int prioridad) {
        this.prioridad = prioridad;
    }

    public void setAnt(NodoPrioridad<T> ant) {
        this.ant = ant;
    }

    public void setSig(NodoPrioridad<T> sig) {
        this.sig = sig;
    }
}
