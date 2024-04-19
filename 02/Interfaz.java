import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;
import javax.swing.border.EmptyBorder;

import graphics.Grafico;
import utilities.Panel;


public class Interfaz extends JFrame {
  private Panel lienzo;
  protected Grafico grafico;
  protected Color colorContorno, colorRelleno;
  protected boolean rellenar;
  protected JTextField inputTrasladarX, inputTrasladarY, inputEscalar, inputRotar;
  protected JButton btnTrasladar, btnRotar, btnEscalar;

  public Interfaz(int w, int h) {
    setTitle("GRAFICACION");
    setLayout(new BorderLayout());
    setDefaultCloseOperation(EXIT_ON_CLOSE);
    rellenar = false;
    colorContorno = Color.WHITE;
    colorRelleno = Color.WHITE;

    lienzo = new Panel(w, h);
    JLabel titleLabel = new JLabel("Graficacion por Computadora " + w + " x " + h, SwingConstants.CENTER);
    JButton btnGraficar = new JButton("Graficar");
    JButton btnGuardar = new JButton("Guardar Lienzo");
    JPanel panelTitle = new JPanel();
    JPanel panelBtns = new JPanel(new GridLayout(1, 2));
    JPanel panelOpciones = new JPanel(new GridLayout(9, 1));
    JPanel panelTrasladar = new JPanel();
    inputTrasladarX = new JTextField(4);
    inputTrasladarY = new JTextField(4);
    inputEscalar = new JTextField(4);
    inputRotar = new JTextField(4);
    btnTrasladar = new JButton("Trasladar");
    btnEscalar = new JButton("Escalar");
    btnRotar = new JButton("Rotar");

    btnTrasladar.setEnabled(false);
    btnEscalar.setEnabled(false);
    btnRotar.setEnabled(false);
    panelTrasladar.add(new JLabel("X"));
    panelTrasladar.add(inputTrasladarX);
    panelTrasladar.add(new JLabel("Y"));
    panelTrasladar.add(inputTrasladarY);

    panelOpciones.add(new JLabel("Trasladar:"));
    panelOpciones.add(panelTrasladar);
    panelOpciones.add(btnTrasladar);
    panelOpciones.add(new JLabel("Escalar (Punto Flotante):"));
    panelOpciones.add(inputEscalar);
    panelOpciones.add(btnEscalar);
    panelOpciones.add(new JLabel("Rotar (Grados):"));
    panelOpciones.add(inputRotar);
    panelOpciones.add(btnRotar);
    panelOpciones.setBorder(new EmptyBorder(50, 20, 50, 20));

    titleLabel.setFont(new Font("Arial", Font.BOLD, 24));
    btnGraficar.setFont(new Font("Arial", Font.BOLD, 16));
    btnGuardar.setFont(new Font("Arial", Font.BOLD, 16));
    btnGraficar.setPreferredSize(new Dimension(w / 2, 40));
    btnGuardar.setPreferredSize(new Dimension(w / 2, 40));
    panelTitle.add(titleLabel);
    panelBtns.add(btnGraficar);
    panelBtns.add(btnGuardar);

    btnTrasladar.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        if (!validarTrasladar()) return;
        int x = Integer.parseInt(inputTrasladarX.getText());
        int y = Integer.parseInt(inputTrasladarY.getText());
        grafico.trasladar(x, y);
        repintar();
      }
    });

    btnEscalar.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        if (!validarEscalar()) return;
        double escala = Double.parseDouble(inputEscalar.getText());
        grafico.escalar(escala);
        repintar();
      }
    });

    btnRotar.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        if (!validarRotar()) return;
        int grados = Integer.parseInt(inputRotar.getText());
        grafico.rotar(grados);
        repintar();
      }
    });

    btnGraficar.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        new DialogSeleccionGrafico(Interfaz.this, lienzo);
      }
    });

    btnGuardar.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        JFileChooser fileChooser = new JFileChooser();
        fileChooser.setDialogTitle("Guardar Lienzo");
        fileChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
        int seleccion = fileChooser.showSaveDialog(Interfaz.this);

        if (seleccion == JFileChooser.APPROVE_OPTION)
          lienzo.saveImage(fileChooser.getSelectedFile().getAbsolutePath());
      }
    });

    add(panelTitle, BorderLayout.NORTH);
    add(lienzo, BorderLayout.CENTER);
    add(panelOpciones, BorderLayout.EAST);
    add(panelBtns, BorderLayout.SOUTH);
    pack();
    setLocationRelativeTo(null);
    setResizable(false);
    setVisible(true);
  }

  private void repintar() {
    lienzo.clear();
    lienzo.draw(grafico.getContorno(), colorContorno, 0);
    if (rellenar)
      lienzo.draw(grafico.getRelleno(), colorRelleno, 0);
  }

  private boolean validarTrasladar() {
    // TODO: CONTROLAR QUE LA ENTRADA SEAN NUMEROS
    return true;
  }

  private boolean validarEscalar() {
    // TODO: CONTROLAR QUE LA ENTRADA SEAN FLOTANTES Y NO NEGATIVOS
    return true;
  }

  private boolean validarRotar() {
    // TODO: CONTROLAR QUE LA ENTRADA SEAN NUMEROS
    return true;
  }
}
