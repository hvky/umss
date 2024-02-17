package estDat.test;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import estDat.lineales.ColaPrioridad;


public class ColaPrioridadTest {

    @Test
    public void methodsTest() {
        ColaPrioridad<Integer> c = new ColaPrioridad<Integer>();
        int datos[] = {10, 4, 5, 1, 7, 8, 3, 2, 9, 6};

        assertTrue(c.empty());
        for (int x : datos)
            c.add(x);

        int cnt = 11;
        while (!c.empty()) {
            cnt--;
            assertEquals(cnt, c.pop());
        }

        assertTrue(c.empty());

        c.add(9);
        c.add(10);
        c.add(8);
        c.add(9);
        assertEquals(10, c.pop());
        assertEquals(9, c.pop());
        assertEquals(9, c.pop());
        assertEquals(8, c.pop());
    }
}
