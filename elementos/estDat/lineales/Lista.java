package estDat.lineales;


public interface Lista<T> {
    boolean esVacia();

    void insertar(T dato);

    T eliminar(int pos);

    T acceder(int pos);

    boolean buscar(T dato);

    int longitud();

    void eliminarTodas(T dato);

    void vaciar();

    void reemplazar(int pos, T dato);

    String toString();

    Lista<T> subLista(int ini, int fin);

    boolean equals(Lista<T> otra);

    void intercambiar(int pos1, int pos2);

    void insertarTodos(Lista<T> otra);

    void insertarTodos(Lista<T> otra, int pos);

    void insertar(int pos, T dato);

    T eliminar(T dato);

    T acceder(T dato);

    int indiceDe(T dato);

    int indiceDe(T dato, int pos);

    void invertir();

    void eliminarTodos(int pos);
}
