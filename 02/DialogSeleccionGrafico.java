import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;
import javax.swing.SwingConstants;
import javax.swing.border.EmptyBorder;

import utilities.Panel;


public class DialogSeleccionGrafico extends JDialog {
  public DialogSeleccionGrafico(Interfaz f, Panel lienzo) {
    super((Frame) f, null, true);
    setLayout(new BorderLayout());

    JLabel labelTitle = new JLabel("Seleccione el grafico", SwingConstants.CENTER);
    JRadioButton btnCirculo = new JRadioButton("Circulo");
    JRadioButton btnTriangulo = new JRadioButton("Triangulo");
    JCheckBox chkGrosor = new JCheckBox("Modificar Grosor");
    JCheckBox chkEstilo = new JCheckBox("Personalizar Segmentado");
    ButtonGroup btnGroup = new ButtonGroup();
    JButton btnAceptar = new JButton("ACEPTAR");
    JPanel panelTitle  = new JPanel();
    JPanel panelOp = new JPanel(new GridLayout(2, 4));

    btnGroup.add(btnCirculo);
    btnGroup.add(btnTriangulo);
    labelTitle.setFont(new Font("Arial", Font.BOLD, 20));
    btnCirculo.setFont(new Font("Arial", Font.ITALIC, 16));
    btnTriangulo.setFont(new Font("Arial", Font.ITALIC, 16));
    chkGrosor.setFont(new Font("Arial", Font.ITALIC, 16));
    chkEstilo.setFont(new Font("Arial", Font.ITALIC, 16));
    btnAceptar.setFont(new Font("Arial", Font.BOLD, 16));
    panelTitle.setBorder(new EmptyBorder(10, 0, 20, 0));
    panelOp.setBorder(new EmptyBorder(20, 30, 40, 30));
    btnAceptar.setBorder(new EmptyBorder(10, 0, 10, 0));
    panelTitle.add(labelTitle);
    panelOp.add(btnCirculo);
    panelOp.add(btnTriangulo);
    panelOp.add(chkGrosor);
    panelOp.add(chkEstilo);

    btnAceptar.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        if (!btnCirculo.isSelected() && !btnTriangulo.isSelected()) {
          JOptionPane.showMessageDialog(DialogSeleccionGrafico.this,
            "Seleccione una figura!", "ERROR", JOptionPane.ERROR_MESSAGE);
          return;
        }

        char g = (btnCirculo.isSelected()) ? 'c' : 't';
        dispose();
        new DialogDimensionesGrafico(f, lienzo, g, chkGrosor.isSelected(), chkEstilo.isSelected());
      }
    });

    add(panelTitle, BorderLayout.NORTH);
    add(panelOp, BorderLayout.CENTER);
    add(btnAceptar, BorderLayout.SOUTH);
    pack();
    setLocationRelativeTo(null);
    setResizable(false);
    setVisible(true);
  }
}
