package estDat.test;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import estDat.lineales.Lista;
import estDat.lineales.ListaSE;


public class ListaSETest {
    ListaSE<String> l;

    @BeforeEach
    public void setUp() {
        l = new ListaSE<String>();
        insertarElementos();
    }

    // @Test
    public void insertarTest() {
        assertTrue(l.esVacia());
        String datos[] = {"a", "e", "i", "o", "u"};
        for (String x : datos) {
            l.insertar(x);
            assertFalse(l.esVacia());
        }
    }

    @Test
    public void eliminarConPosicionTest() {
        String datosEl[] = {"a", "l", "z", "y", "b", null};
        int[] indices = {0, 10, 23, 22, 0, 22},
              tams = {25, 24, 23, 22, 21, 21};

        for (int i = 0; i < datosEl.length; i++) {
            assertEquals(datosEl[i], l.eliminar(indices[i]));
            assertEquals(tams[i], l.longitud());
        }
    }

    @Test
    public void accederConPosicionTest() {
        String datos[] = {"a", "e", "i", "o", "u", null, null};
        int indices[] = {0, 4, 8, 14, 20, 26, -1};

        for (int i = 0; i < 5; i++)
            assertEquals(datos[i], l.acceder(indices[i]));
    }

    @Test
    public void buscarTest() {
        String datos[] = {"a", "e", "i", "o", "u"};

        for (String x : datos)
            assertTrue(l.buscar(x));

        boolean esperado[] = {false, true, true, true, false};
        l.eliminar(20); l.eliminar(0);

        for (int i = 0; i < datos.length; i++)
            assertEquals(esperado[i], l.buscar(datos[i]));
    }

    @Test
    public void eliminarTodasTest() {
        String[] datos = {"a", "e", "e", "a", "a", "e", "i", "e"},
               elim = {"a", "i", "e", "po"};

        for (String x : datos)
            l.insertar(x);

        int tams[] = {34, 30, 28, 23};

        for (int i = 0; i < elim.length; i++) {
            assertEquals(tams[i], l.longitud());
            l.eliminarTodas(elim[i]);
        }

        assertEquals(23, l.longitud());
    }

    @Test
    public void vaciarTest() {
        l.vaciar();
        assertTrue(l.esVacia());
        insertarElementos();
        assertFalse(l.esVacia());
        l.vaciar();
        assertTrue(l.esVacia());
    }

    @Test
    public void reemplazarTest() {
        String datos[] = {"u", "a", "o", "i", "e"};

        for (int i = 0; i < datos.length; i++)
            l.reemplazar(i, datos[i]);

        for (int i = 0; i < datos.length; i++)
            assertEquals(datos[i], l.acceder(i));
    }

    @Test
    public void toStringTest() {
        String esperado = "[a b c d e f g h i j k l m n o p q r s t u v w x y z]";
        assertEquals(esperado, l.toString());

        l.vaciar();
        for (String x : new String[]{"a", "e", "i", "o", "u"})
            l.insertar(x);

        assertEquals("[a e i o u]", l.toString());

        l.vaciar();
        assertEquals("", l.toString());
    }

    @Test
    public void subListaTest() {
        String datos[] = {"a", "b", "c", "d", "e", "f", "g", "h",
                          "i", "j", "k", "l", "m", "n", "o", "p",
                          "q", "r", "s", "t", "u", "v", "w", "x",
                          "y", "z"};

        Lista<String> ans = l.subLista(0, 26);
        for (int i = 0; i < datos.length; i++)
            assertEquals(datos[i], ans.acceder(i));

        ans = l.subLista(10, 30);
        for (int i = 10; i < datos.length; i++)
            assertEquals(datos[i], ans.acceder(i-10));

        ans = l.subLista(26, 30);
        assertTrue(ans.esVacia());

        ans = l.subLista(20, 23);
        for (int i = 20; i < 23; i++)
            assertEquals(datos[i], ans.acceder(i-20));
    }

    @Test
    public void equalsTest() {
        Lista<String> tmp = l.subLista(0, l.longitud());
        assertTrue(l.equals(tmp));
        tmp.reemplazar(5, "k");
        assertFalse(l.equals(tmp));
        tmp.eliminar(5);
        assertFalse(l.equals(tmp));
    }

    @Test
    public void intercambiarTest() {
        int indices[][] = {{0, 25}, {10, -1}, {50, 26}, {20, 15}, {5, 1}};
        String cads[][] = {{"a", "z"}, {"k", null}, {null, null}, {"u", "p"}, {"f", "b"}},
        x, y;

        for (int i = 0; i < indices.length; i++) {
            x = l.acceder(indices[i][0]);
            y = l.acceder(indices[i][1]);
            assertEquals(cads[i][0], x);
            assertEquals(cads[i][1], y);

            l.intercambiar(indices[i][0], indices[i][1]);

            x = l.acceder(indices[i][0]);
            y = l.acceder(indices[i][1]);

            if (cads[i][0] != null && cads[i][1] != null) {
                assertEquals(cads[i][1], x);
                assertEquals(cads[i][0], y);
            } else {
                assertEquals(cads[i][0], x);
                assertEquals(cads[i][1], y);
            }
        }
    }

    @Test
    public void insertarTodosTest() {
        Lista<String> otra = new ListaSE<String>();

        String datos[] = {"a", "e", "i", "o", "u"};
        for (String x : datos)
            otra.insertar(x);

        assertEquals(26, l.longitud());
        l.insertarTodos(otra);
        assertEquals(31, l.longitud());

        for (int i = 0; i < 5; i++)
            assertEquals(datos[i], l.acceder(26+i));
    }

    @Test
    public void insertarTodosConPosicionTest() {
        Lista<String> otra = new ListaSE<String>();
        String datos[] = {"a", "e", "i", "o", "u"};
        for (String x : datos)
            otra.insertar(x);

        l.insertarTodos(otra, 30);
        assertEquals(26, l.longitud());

        l.insertarTodos(otra, 10);
        assertEquals(31, l.longitud());
        for (int i = 10; i < 15; i++)
            assertEquals(datos[i-10], l.acceder(i));

        l.insertarTodos(otra, 0);
        assertEquals(36, l.longitud());
        for (int i = 0; i < 5; i++)
            assertEquals(datos[i], l.acceder(i));

        assertEquals("a", l.acceder(5));
    }

    @Test
    public void insertarConPosicionTest() {
        String datos[] = {"a", "e", "i", "o", "u", "k"};
        int posiciones[] = {27, 0, 27, 1, 20, 10};

        for (int i = 0; i < datos.length; i++) {
            l.insertar(posiciones[i], datos[i]);
            assertEquals(26+i, l.longitud());
        }

        String esperado[] = {"e", "o", "a", "b", "c", "d", "e", "f", "g", "h",
                          "k", "i", "j", "k", "l", "m", "n", "o", "p",
                          "q", "r", "u", "s", "t", "u", "v", "w", "x",
                          "y", "z", "i"};

        for (int i = 0; i < esperado.length; i++)
            assertEquals(esperado[i], l.acceder(i));
    }

    @Test
    public void eliminarTest() {
        String[] datos = {"a", "e", "i", "o", "u", "a", "k", "e"},
                 esperado = {"a", "e", "i", "o", "u", null, "k", null};

        int tams[] = {25, 24, 23, 22, 21, 21, 20, 20};

        for (int i = 0; i < datos.length; i++) {
            assertEquals(esperado[i], l.eliminar(datos[i]));
            assertEquals(tams[i], l.longitud());
        }
    }

    @Test
    public void accederTest() {
        String[] datos = {"a", "e", "i", "o", "u", "ka", "b", "ho", "a"},
                 esperado = {"a", "e", "i", "o", "u", null, "b", null, "a"};

        for (int i = 0; i < datos.length; i++)
            assertEquals(esperado[i], l.acceder(datos[i]));
    }

    @Test
    public void indiceDeTest() {
        String datos[] = {"a", "e", "i", "o", "u", "ka", "b", "ho"};
        int esperado[] = {0, 4, 8, 14, 20, -1, 1, -1};

        for (int i = 0; i < datos.length; i++)
            assertEquals(esperado[i], l.indiceDe(datos[i]));
    }

    @Test
    public void indiceDeConPuntoDePartidaTest() {
        String datos[] = {"a", "e", "i", "o", "u"};
        int[] indices = {0, 4, 8, 14, 20},
              partida = {1, 3, 10, 4, 17},
              esperado = {-1, 1, -1, 10, 3};

        for (int i = 0; i < datos.length; i++)
            assertEquals(0, l.indiceDe(datos[i], indices[i]));

        for (int i = 0; i < datos.length; i++)
            assertEquals(esperado[i], l.indiceDe(datos[i], partida[i]));
    }

    @Test
    public void invertirTest() {
        Lista<String> otra = new ListaSE<String>();
        String datos[] = {"a", "b", "c", "d", "e", "f", "g", "h",
                          "i", "j", "k", "l", "m", "n", "o", "p",
                          "q", "r", "s", "t", "u", "v", "w", "x",
                          "y", "z"};

        for (int i = 25; i >= 0; i--)
            otra.insertar(datos[i]);

        l.invertir();
        assertTrue(l.equals(otra));

        l.vaciar();
        for (String x : new String[]{"a", "e", "i", "o", "u"})
            l.insertar(x);
        l.invertir();

        assertEquals("[u o i e a]", l.toString());
    }

    @Test
    public void eliminarTodosConPosicionTest() {
        l.eliminarTodos(0);
        assertTrue(l.esVacia());

        insertarElementos();
        l.eliminarTodos(20);
        assertEquals(20, l.longitud());

        l.vaciar();
        String datos[] = {"a", "e", "i", "o", "u"};
        for (String x : datos)
            l.insertar(x);

        l.eliminarTodos(2);
        assertEquals("[a e]", l.toString());
    }


    // metodos auxiliares
    private void insertarElementos() {
        String datos[] = {"a", "b", "c", "d", "e", "f", "g", "h",
                          "i", "j", "k", "l", "m", "n", "o", "p",
                          "q", "r", "s", "t", "u", "v", "w", "x",
                          "y", "z"};
        for (String x : datos)
            l.insertar(x);
    }
}
