package estDat.test;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import estDat.lineales.Cola;


public class ColaTest {

    @Test
    public void methodsTest() {
        Cola<String> c = new Cola<String>();

        assertTrue(c.empty());
        c.add("Carlos");
        assertFalse(c.empty());
        c.add("David");
        c.add("Maria");
        assertEquals("Carlos", c.front());
        assertEquals("Carlos", c.pop());
        assertEquals("David", c.front());
        assertEquals("David", c.pop());
        assertEquals("Maria", c.front());
        assertEquals("Maria", c.pop());
        assertTrue(c.empty());
        c.add("Marcelo");
        assertEquals("Marcelo", c.front());
        assertFalse(c.empty());
    }
}
