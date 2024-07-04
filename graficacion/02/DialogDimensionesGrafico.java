import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;
import javax.swing.SwingConstants;
import javax.swing.border.EmptyBorder;

import graphics.*;
import utilities.Panel;


public class DialogDimensionesGrafico extends JDialog {
  private JCheckBox chkRellenar;
  private JTextField inputGrosor, inputPintar, inputNoPintar, inputTp1X, inputTp1Y,
    inputTp2X, inputTp2Y, inputTp3X, inputTp3Y, inputCcentroX, inputCcentroY, inputCradio;

  public DialogDimensionesGrafico(Interfaz f, Panel lienzo, char g, boolean mG, boolean mE) {
    super((Frame) f, null, true);
    setLayout(new BorderLayout());

    JPanel panelTitle = new JPanel();
    JPanel panelDimension;
    JPanel panelColores = new JPanel(new GridLayout(2, 1));
    JPanel panelGrosorEstilo = new JPanel(new GridLayout(2, 1));

    // SECCION TITULO
    JLabel lableTitle =  new JLabel("Configuraciones del Grafico",
      SwingConstants.CENTER);
    lableTitle.setFont(new Font("Arial", Font.BOLD, 20));
    panelTitle.add(lableTitle);

    // SECCION DIMENSIONES
    panelDimension = (g == 'c') ? panelCirculo() : panelTriangulo();

    // SECCION COLORES
    JPanel panelRelleno = new JPanel(new GridLayout(1, 2));
    JButton btnColorContorno = new JButton("Contorno");
    chkRellenar = new JCheckBox("Rellenar");
    JButton btnColorRelleno = new JButton("Relleno");
    panelRelleno.add(chkRellenar);
    panelRelleno.add(btnColorRelleno);
    panelColores.add(btnColorContorno);
    panelColores.add(panelRelleno);
    btnColorRelleno.setEnabled(false);

    chkRellenar.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        btnColorRelleno.setEnabled(chkRellenar.isSelected());
      }
    });

    btnColorContorno.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        Color colorPrevio = f.colorContorno;
        f.colorContorno = JColorChooser.showDialog(DialogDimensionesGrafico.this,
          null, f.colorContorno);
        if (f.colorContorno == null)
          f.colorContorno = colorPrevio;
      }
    });

    btnColorRelleno.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        Color colorPrevio = f.colorRelleno;
        f.colorRelleno = JColorChooser.showDialog(DialogDimensionesGrafico.this,
          null, f.colorRelleno);
        if (f.colorRelleno == null)
          f.colorRelleno = colorPrevio;
      }
    });

    // SECCION GROSOR - ESTILO
    if (mG) {
      JPanel panelGrosor = new JPanel();
      JLabel labelGrosor = new JLabel("Grosor:");
      inputGrosor = new JTextField(2);
      panelGrosor.add(labelGrosor);
      panelGrosor.add(inputGrosor);
      panelGrosorEstilo.add(panelGrosor);
    }

    if (mE) {
      JPanel panelEstilo = new JPanel();
      JLabel labelPintar = new JLabel("Pintar:");
      JLabel labelNoPintar = new JLabel("No Pintar:");
      inputPintar = new JTextField(2);
      inputNoPintar = new JTextField(2);
      panelEstilo.add(labelPintar);
      panelEstilo.add(inputPintar);
      panelEstilo.add(labelNoPintar);
      panelEstilo.add(inputNoPintar);
      panelGrosorEstilo.add(panelEstilo);
    }

    panelTitle.setBorder(new EmptyBorder(30, 0, 20, 0));
    panelDimension.setBorder(new EmptyBorder(20, 30, 40, 30));
    panelGrosorEstilo.setBorder(new EmptyBorder(20, 30, 40, 0));
    panelColores.setBorder(new EmptyBorder(20, 0, 40, 30));

    JButton btnAceptar = new JButton("ACEPTAR");
    btnAceptar.setFont(new Font("Arial", Font.BOLD, 16));
    btnAceptar.setBorder(new EmptyBorder(10, 0, 10, 0));

    btnAceptar.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        int w = lienzo.getWidth();
        int h = lienzo.getHeight();

        if (!validarEntrada(g)) return;
        if (!verificarEntrada(g, w, h)) return;

        int grosor = (mG)
          ? Integer.parseInt(inputGrosor.getText())
          : 1;

        Estilo estilo = (mE)
          ? new Estilo(Integer.parseInt(inputNoPintar.getText()),
              Integer.parseInt(inputNoPintar.getText()))
          : null;

        if (g == 'c') {
          Point centro = new Point(Integer.parseInt(inputCcentroX.getText()),
            Integer.parseInt(inputCcentroY.getText()));
          int radio = Integer.parseInt(inputCradio.getText());
          f.grafico = new Circulo(centro, radio, w, h, grosor, estilo);
        } else {
          Point p1 = new Point(Integer.parseInt(inputTp1X.getText()),
            Integer.parseInt(inputTp1Y.getText()));
          Point p2 = new Point(Integer.parseInt(inputTp2X.getText()),
            Integer.parseInt(inputTp2Y.getText()));
          Point p3 = new Point(Integer.parseInt(inputTp3X.getText()),
            Integer.parseInt(inputTp3Y.getText()));
          f.grafico = new Triangulo(p1, p2, p3, w, h, grosor, estilo);
        }

        dispose();
        lienzo.clear();
        lienzo.draw(f.grafico.getContorno(), f.colorContorno, 0);
        if (chkRellenar.isSelected()) {
          f.rellenar = true;
          lienzo.draw(f.grafico.getRelleno(), f.colorRelleno, 0);
        }
        f.btnTrasladar.setEnabled(true);
        f.btnEscalar.setEnabled(true);
        f.btnRotar.setEnabled(true);
      }
    });

    add(panelTitle, BorderLayout.NORTH);
    add(panelGrosorEstilo, BorderLayout.WEST);
    add(panelDimension, BorderLayout.CENTER);
    add(panelColores, BorderLayout.EAST);
    add(btnAceptar, BorderLayout.SOUTH);
    pack();
    setLocationRelativeTo(null);
    setResizable(false);
    setVisible(true);
  }

  private JPanel panelCirculo() {
    JPanel panel = new JPanel(new GridLayout(2, 2));
    JPanel panelCentro = new JPanel();
    inputCradio = new JTextField(4);
    inputCcentroX = new JTextField(4);
    inputCcentroY = new JTextField(4);
    panelCentro.add(new JLabel("X"));
    panelCentro.add(inputCcentroX);
    panelCentro.add(new JLabel("Y"));
    panelCentro.add(inputCcentroY);
    panel.add(new JLabel("Punto Central:"));
    panel.add(panelCentro);
    panel.add(new JLabel("Radio:"));
    panel.add(inputCradio);
    return panel;
  }

  private JPanel panelTriangulo() {
    JPanel panel = new JPanel(new GridLayout(3, 2));
    JPanel panelp1 = new JPanel();
    JPanel panelp2 = new JPanel();
    JPanel panelp3 = new JPanel();
    inputTp1X = new JTextField(4);
    inputTp1Y = new JTextField(4);
    inputTp2X = new JTextField(4);
    inputTp2Y = new JTextField(4);
    inputTp3X = new JTextField(4);
    inputTp3Y = new JTextField(4);
    panelp1.add(new JLabel("X"));
    panelp1.add(inputTp1X);
    panelp1.add(new JLabel("Y"));
    panelp1.add(inputTp1Y);
    panelp2.add(new JLabel("X"));
    panelp2.add(inputTp2X);
    panelp2.add(new JLabel("Y"));
    panelp2.add(inputTp2Y);
    panelp3.add(new JLabel("X"));
    panelp3.add(inputTp3X);
    panelp3.add(new JLabel("Y"));
    panelp3.add(inputTp3Y);
    panel.add(new JLabel("Primer Punto:"));
    panel.add(panelp1);
    panel.add(new JLabel("Segundo Punto:"));
    panel.add(panelp2);
    panel.add(new JLabel("Tercer Punto:"));
    panel.add(panelp3);
    return panel;
  }

  private boolean validarEntrada(char g) {
    // TODO: VALIDAR QUE LOS CAMPOS SEAN NUMEROS
    boolean ans = true;
    return ans;
  }

  private boolean verificarEntrada(char g, int w, int h) {
    // TODO: VERIFICAR QUE LA FIGURA NO SE SALGA DEL LIENZO
    boolean ans = true;
    return ans;
  }
}
