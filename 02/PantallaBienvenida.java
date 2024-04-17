//"C:/Users/hp/Downloads/pracGraficacion/image1.jpg"
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;

public class PantallaBienvenida extends JFrame {

    public PantallaBienvenida() {
        super("PRIMITIVAS");

        // Configuración del JFrame
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(800, 500);
        setLocationRelativeTo(null); // Centra la ventana en la pantalla

        // Crear un JPanel para la imagen con GridBagLayout
        JPanel imagenPanel = new JPanel(new GridBagLayout()) {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                try {
                    BufferedImage imagen = ImageIO.read(new File("./IMG_20220719_155711.jpg")); // Ruta de la imagen
                    g.drawImage(imagen, 0, 0, getWidth(), getHeight(), this);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        };

        // Crear un botón de inicio
        JButton btnIniciar = new JButton("INICIAR");
        
        // Configurar las restricciones del botón para centrarlo
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.gridx = 0;
        gbc.gridy = 7;
        gbc.anchor = GridBagConstraints.CENTER;
        gbc.insets = new Insets(75, 0, 0, 0); // Espacio inferior

        // Añadir el botón al JPanel con las restricciones
        imagenPanel.add(btnIniciar, gbc);
        // Añadir el JPanel al JFrame
        add(imagenPanel);

        // Mostrar la ventana
        setVisible(true);
        
        // Agregar un ActionListener al botón para cerrar la ventana de bienvenida
        btnIniciar.addActionListener(e -> {
            dispose(); // Cerrar la ventana de bienvenida
            abrirNuevaVentana(); // Abrir la nueva ventana
        });
    }

    private void abrirNuevaVentana() {
        
        InterfazGrafica interfaz =new InterfazGrafica();
    }

    public static void main(String[] args) {
        // Crear una instancia de la clase PantallaBienvenida
        SwingUtilities.invokeLater(PantallaBienvenida::new);
    }
}
