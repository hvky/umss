package estDat.test;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import estDat.lineales.BiCola;


public class BiColaTest {

    @Test
    public void methodsTest() {
        BiCola<Character> bc = new BiCola<Character>();
        Character items[] = {'a', 'b', 'c', 'd', 'e'};

        assertTrue(bc.empty());

        for (char x : items) {
            bc.addFront(x);
            assertFalse(bc.empty());
        }

        int i = 0;
        while (!bc.empty()) {
            assertFalse(bc.empty());
            assertEquals(items[i], bc.popBack());
            i++;
        }

        assertTrue(bc.empty());
    }
}

