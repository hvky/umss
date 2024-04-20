package estDat.lineales;

import java.io.Serializable;
import java.util.Iterator;

public class Iterador<T> implements Iterator<T>, Serializable {
    private NodoPrioridad<T> ini;
    
    public Iterador(NodoPrioridad<T> frente) {
        ini = frente;
    }
    
    @Override
    public boolean hasNext() {
        return ini != null;
    }
    
    @Override
    public T next() {
        T dato = ini.getDato();
        ini = ini.getSig();
        return dato;
    }
}
