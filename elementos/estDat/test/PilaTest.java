package estDat.test;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import estDat.lineales.Pila;


public class PilaTest {

    @Test
    public void methodsTest() {
        Pila<Character> p = new Pila<Character>();

        assertTrue(p.empty());
        p.push('a');
        assertFalse(p.empty());
        p.push('b');
        assertEquals('b', p.top());
        p.push('c');
        assertEquals('c', p.pop());
        assertEquals('b', p.pop());
        assertEquals('a', p.pop());
        assertTrue(p.empty());
        p.push('x');
        assertEquals('x', p.top());
    }
}
