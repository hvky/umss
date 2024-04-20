package estDat.lineales;

import java.io.Serializable;
import java.util.Iterator;

public class ColaPrioridad<T> implements Iterable<T>, Serializable {
    private NodoPrioridad<T> frente, fin;
    private int longitud;

    public ColaPrioridad() {
        frente = fin = null;
        longitud = 0;
    }

    public boolean vacia() {
        return frente == null && fin == null;
    }

    public void vaciar() {
        frente = fin = null;
        longitud = 0;
    }

    public void encolar(T dato, int prioridad) {
        NodoPrioridad<T> nuevo = new NodoPrioridad<T>(dato, prioridad);

        if (vacia()) {
            frente = fin = nuevo;
        } else {
            if (prioridad > frente.getPrioridad()) {
                nuevo.setSig(frente);
                frente.setAnt(nuevo);
                frente = nuevo;
            } else if (prioridad <= fin.getPrioridad()) {
                fin.setSig(nuevo);
                nuevo.setAnt(fin);
                fin = nuevo;
            } else {
                NodoPrioridad<T> aux = frente;

                while (prioridad <= aux.getPrioridad()) {
                    aux = aux.getSig();
                }

                aux.getAnt().setSig(nuevo);
                nuevo.setAnt(aux.getAnt());
                nuevo.setSig(aux);
                aux.setAnt(nuevo);
            }
        }
        
        longitud++;
    }

    public T decolar() {
        T dato = null;

        if (!vacia()) {
            dato = frente.getDato();
            frente = frente.getSig();

            if (frente == null) {
                fin = null;
            } else {
                frente.getAnt().setSig(null);
                frente.setAnt(null);
            }
        }

        longitud--;
        return dato;
    }

    public T acceder() {
        return vacia() ? null : frente.getDato();
    }
    
    public boolean eliminar(int pos) {
        if (pos < 0 || pos >= longitud) return false;

        if (frente == fin) {
            frente = fin = null;
        } else if (pos == 0) {
            frente = frente.getSig();
            frente.getAnt().setSig(null);
            frente.setAnt(null);
        } else if (pos == longitud - 1) {
            fin = fin.getAnt();
            fin.getSig().setAnt(null);
            fin.setSig(null);
        } else {
            NodoPrioridad<T> aux = frente;

            while (pos > 0) {
                pos--;
                aux = aux.getSig();
            }

            aux.getAnt().setSig(aux.getSig());
            aux.getSig().setAnt(aux.getAnt());
            aux.setAnt(null);
            aux.setSig(null);
        }

        longitud--;
        return true;
    }
    
    public T acceder(int pos) {
        if (pos < 0 || pos >= longitud) {
            return null;
        }
        
        NodoPrioridad<T> aux = frente;
        
        while (pos > 0) {
            pos--;
            aux = aux.getSig();
        }
        
        return aux.getDato();
    }
    
    public int getLongitud() {
        return longitud;
    }
    
    @Override
    public Iterator<T> iterator() {
        return new Iterador(frente);
    }
}
