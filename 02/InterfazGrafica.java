import javax.swing.*;

// import graphics.Circunferencia;
// import graphics.Grafico;

import java.awt.*;
import java.awt.event.*;
import java.awt.geom.AffineTransform;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Path2D;

public class InterfazGrafica extends JFrame {
    private JPanel panel;
    private JButton botonOpciones;
    private OpcionesFormas opcionesFormas;
    private Lienzo lienzo;

    public InterfazGrafica() {
        setTitle("PRMITIVAS");
        setSize(800, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null); // Centrar la ventana en la pantalla

        // Crear panel principal con BorderLayout
        panel = new JPanel(new BorderLayout());

        // Botón para mostrar opciones de formas
        botonOpciones = new JButton("Opciones");
        botonOpciones.setFont(new Font("Arial", Font.BOLD, 16));
        botonOpciones.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                opcionesFormas.setVisible(true);
            }
        });

        // Crear lienzo para dibujar formas
        lienzo = new Lienzo();
        lienzo.setBackground(Color.WHITE);

        // Crear panel para opciones de formas
        opcionesFormas = new OpcionesFormas(lienzo);

        // Agregar componentes al panel principal
        panel.add(botonOpciones, BorderLayout.NORTH);
        panel.add(lienzo, BorderLayout.CENTER);

        // Agregar panel principal al marco
        add(panel);

        setVisible(true);
    }

    public static void main(String[] args) {
        new InterfazGrafica();
    }
}

class OpcionesFormas extends JFrame {
    private Lienzo lienzo;

    public OpcionesFormas(Lienzo lienzo) {
        setTitle("Opciones de Formas");
        setSize(300, 300);
        setLocationRelativeTo(null); // Centrar la ventana en la pantalla

        this.lienzo = lienzo;

        // Crear panel para las opciones de formas
        JPanel panel = new JPanel(new GridLayout(4, 1));
        panel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

        // Botón para seleccionar círculo
        JButton botonCirculo = new JButton("Círculo");
        botonCirculo.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                String radioStr = JOptionPane.showInputDialog("Ingrese el radio del círculo:");
                try {
                    double radio = Double.parseDouble(radioStr);
                    String[] opcionesLinea = {"Sólido", "Segmentado"};
                    String estiloLinea = (String) JOptionPane.showInputDialog(null, "Seleccione el estilo de línea:", "Estilo de Línea", JOptionPane.QUESTION_MESSAGE, null, opcionesLinea, opcionesLinea[0]);
                    Color colorBorde = elegirColor("Seleccione el color del borde del círculo");
                    Color colorRelleno = elegirColor("Seleccione el color del relleno del círculo");
                    // lienzo.agregarCirculo(radio, estiloLinea, colorBorde, colorRelleno);
                } catch (NumberFormatException ex) {
                    JOptionPane.showMessageDialog(null, "El radio debe ser un número válido.", "Error", JOptionPane.ERROR_MESSAGE);
                }
            }
        });

        // Botón para seleccionar triángulo
        JButton botonTriangulo = new JButton("Triángulo");
        botonTriangulo.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                String ladoStr = JOptionPane.showInputDialog("Ingrese la longitud del lado del triángulo:");
                try {
                    double lado = Double.parseDouble(ladoStr);
                    String[] opcionesLinea = {"Sólido", "Segmentado"};
                    String estiloLinea = (String) JOptionPane.showInputDialog(null, "Seleccione el estilo de línea:", "Estilo de Línea", JOptionPane.QUESTION_MESSAGE, null, opcionesLinea, opcionesLinea[0]);
                    Color colorBorde = elegirColor("Seleccione el color del borde del triángulo");
                    Color colorRelleno = elegirColor("Seleccione el color del relleno del triángulo");
                    // lienzo.agregarTriangulo(lado, estiloLinea, colorBorde, colorRelleno);
                } catch (NumberFormatException ex) {
                    JOptionPane.showMessageDialog(null, "La longitud del lado debe ser un número válido.", "Error", JOptionPane.ERROR_MESSAGE);
                }
            }
        });

        // Agregar botones al panel de opciones
        panel.add(botonCirculo);
        panel.add(botonTriangulo);

        // Agregar panel al marco
        add(panel);

        setVisible(false); // Ocultar la ventana al principio
    }

    private Color elegirColor(String mensaje) {
        Color color = JColorChooser.showDialog(this, mensaje, Color.BLACK);
        if (color == null) {
            color = Color.BLACK; // Color por defecto si se cancela la selección
        }
        return color;
    }
}

class Lienzo extends JPanel {
    private String formaSeleccionada;
    private double radioCirculo;
    private double ladoTriangulo;
    private String estiloLinea;
    private Color colorBorde;
    private Color colorRelleno;
    private int xFigura, yFigura;
    private int xFiguraMouse, yFiguraMouse;
    private boolean arrastrando;
    private double angulo;
    private double escala;

    public Lienzo() {
        setPreferredSize(new Dimension(600, 400));
        formaSeleccionada = "";
        radioCirculo = 0.0;
        ladoTriangulo = 0.0;
        estiloLinea = "Sólido"; // Por defecto, línea sólida
        colorBorde = Color.BLACK; // Por defecto, color negro
        colorRelleno = Color.WHITE; // Por defecto, color blanco
        xFigura = 300;
        yFigura = 200;
        arrastrando = false;
        angulo = 0.0;
        escala = 1.0;

        MyMouseListener oyenteRaton = new MyMouseListener();
        addMouseListener(oyenteRaton);
        addMouseMotionListener(oyenteRaton);
    }

    // public void agregarCirculo(double radio, String estiloLinea, Color colorBorde, Color colorRelleno) {
    //     Grafico circulo = new Circunferencia() ;
    //     formaSeleccionada = "Círculo";
    //     radioCirculo = radio;
    //     this.estiloLinea = estiloLinea;
    //     this.colorBorde = colorBorde;
    //     this.colorRelleno = colorRelleno;
    //     repaint();
    // }

    // public void agregarTriangulo(double lado, String estiloLinea, Color colorBorde, Color colorRelleno) {
    //     formaSeleccionada = "Triángulo";
    //     ladoTriangulo = lado;
    //     this.estiloLinea = estiloLinea;
    //     this.colorBorde = colorBorde;
    //     this.colorRelleno = colorRelleno;
    //     repaint();
    // }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        Graphics2D g2d = (Graphics2D) g;

        // // Transformaciones para rotación y escalado
        // AffineTransform transform = new AffineTransform();
        // transform.translate(xFigura, yFigura);
        // transform.rotate(Math.toRadians(angulo));
        // transform.scale(escala, escala);
        // g2d.transform(transform);

        // // Configurar el estilo de la línea
        // if (estiloLinea.equals("Segmentado")) {
        //     float[] patron = {10, 10}; // Patrón de línea segmentada
        //     BasicStroke dashed = new BasicStroke(2, BasicStroke.CAP_ROUND, BasicStroke.JOIN_ROUND, 0, patron, 0);
        //     g2d.setStroke(dashed);
        // } else {
        //     // Establecer línea sólida por defecto
        //     g2d.setStroke(new BasicStroke(2));
        // }

        // // Dibujar la forma seleccionada
        // if (formaSeleccionada.equals("Círculo")) {
        //     int x = -(int) radioCirculo;
        //     int y = -(int) radioCirculo;
        //     Ellipse2D.Double circle = new Ellipse2D.Double(x, y, 2 * radioCirculo, 2 * radioCirculo);
        //     g2d.setColor(colorRelleno);
        //     g2d.fill(circle);
        //     g2d.setColor(colorBorde);
        //     g2d.draw(circle);
        // } else if (formaSeleccionada.equals("Triángulo")) {
        //     Path2D.Double triangle = new Path2D.Double();
        //     triangle.moveTo(0, -ladoTriangulo / 3);
        //     triangle.lineTo(-ladoTriangulo / 2, ladoTriangulo / 3);
        //     triangle.lineTo(ladoTriangulo / 2, ladoTriangulo / 3);
        //     triangle.closePath();
        //     g2d.setColor(colorRelleno);
        //     g2d.fill(triangle);
        //     g2d.setColor(colorBorde);
        //     g2d.draw(triangle);
        // }
    }

    class MyMouseListener extends MouseAdapter {
        @Override
        public void mousePressed(MouseEvent e) {
            if (formaSeleccionada.equals("Círculo") || formaSeleccionada.equals("Triángulo")) {
                xFiguraMouse = e.getX();
                yFiguraMouse = e.getY();
                arrastrando = true;
            }
        }

        @Override
        public void mouseReleased(MouseEvent e) {
            arrastrando = false;
        }

        @Override
        public void mouseDragged(MouseEvent e) {
            if (arrastrando) {
                int dx = e.getX() - xFiguraMouse;
                int dy = e.getY() - yFiguraMouse;
                xFigura += dx;
                yFigura += dy;
                xFiguraMouse = e.getX();
                yFiguraMouse = e.getY();
                repaint();
            }
        }

        @Override
        public void mouseWheelMoved(MouseWheelEvent e) {
            int rotation = e.getWheelRotation();
            escala += rotation * 0.1; // Incrementar o decrementar la escala
            repaint();
        }

        @Override
        public void mouseClicked(MouseEvent e) {
            if (e.getButton() == MouseEvent.BUTTON3) {
                angulo += 5; // Rotar hacia la derecha
            } else {
                angulo -= 5; // Rotar hacia la izquierda
            }
            repaint();
        }
    }
}
