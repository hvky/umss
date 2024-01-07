package estDat.lineales;


public class Pila<T> {
    private T tope;
    private Pila<T> base;

    public Pila() {
        tope = null;
        base = null;
    }

    private Pila(T tope, Pila<T> base) {
        this.tope = tope;
        this.base = base;
    }

    public boolean empty() {
        return tope == null;
    }

    public void push(T dato) {
        if (empty())
            base = new Pila<T>();
        else
            base = new Pila<T>(tope, base);

        tope = dato;
    }

    public T pop() {
        T ans;

        if (empty())
            ans = null;
        else {
            ans = tope;
            tope = base.tope;
            base = base.base;
        }

        return ans;
    }

    public T top() {
        return tope;
    }
}
