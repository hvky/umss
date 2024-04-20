package estDat.noLineales;

import estDat.lineales.Cola;

public class ArbolBB {
    private Integer raiz;
    private ArbolBB izq, der;

    public ArbolBB() {
        raiz = null;
        izq = der = null;
    }

    public boolean vacio() {
        return raiz == null && izq == null && der == null;
    }

    public void insertar(int dato) {
        if (vacio()) {
            raiz = dato;
            izq = new ArbolBB();
            der = new ArbolBB();
            return;
        }

        if (dato > raiz) izq.insertar(dato);
        else             der.insertar(dato);
    }

    public Cola<Integer> inOrden() {
        Cola<Integer> datos = new Cola<Integer>();
        inOrden(datos);
        return datos;
    }

    private void inOrden(Cola<Integer> datos) {
        if (vacio()) return;

        izq.inOrden(datos);
        datos.encolar(raiz);
        der.inOrden(datos);
    }

    public boolean buscar(int n) {
        if (vacio()) return false;
        if (n == raiz) return true;

        return (n > raiz)
                ? izq.buscar(n)
                : der.buscar(n);
    }

    public void vaciar() {
        raiz = null;
        izq = der = null;
    }

    public boolean eliminar(int n) {
        boolean esta = buscar(n);
        if (esta) eliminarAux(n);
        return esta;
    }

    public void eliminarAux(int n) {
        if (n != raiz) {
            if (n < raiz) izq.eliminarAux(n);
            else          der.eliminarAux(n);
            return;
        }

        if (esHoja()) {
            raiz = null;
            izq = der = null;
        } else if (soloIzq()) {
            raiz = izq.raiz;
            der = izq.der;
            izq = izq.izq;
        } else if (soloDer()) {
            raiz = der.raiz;
            izq = der.izq;
            der = der.der;
        } else {
            ArbolBB arb = izq.descDer();
            raiz = arb.raiz;
            arb.eliminarAux(raiz);
        }
    }

    private boolean esHoja() {
        return raiz != null && izq.vacio() && der.vacio();
    }

    private boolean soloIzq() {
        return raiz != null && !izq.vacio() && der.vacio();
    }

    private boolean soloDer() {
        return raiz != null && !der.vacio() && izq.vacio();
    }

    private ArbolBB descDer() {
        return (der.vacio()) ? this : der.descDer();
    }
}
