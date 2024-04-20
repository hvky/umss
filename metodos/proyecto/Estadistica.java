import java.util.HashMap;
import java.awt.Dimension;
import java.awt.BorderLayout;
import javax.swing.JLabel;
import javax.swing.JButton;
import javax.swing.JPanel;
import javax.swing.JComboBox;
import javax.swing.JOptionPane;

import herramientas.texto.Texto;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.chart.plot.PiePlot;
import org.jfree.data.general.DefaultPieDataset;

public class Estadistica extends javax.swing.JFrame {
    private JLabel IcHouseA, IcUser, Logo, jLabel;
    private JButton botGraficar;
    private JPanel botonInicio, head,jPanel1,jPanelBarras, jPanelCircular;
    private JComboBox<String> jComboBox1;

    public Estadistica() {
        initComponents();
        
        pack();
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        // setResizable(false);
    }

    private void initComponents() {
        jPanel1 = new JPanel();
        head = new JPanel();
        Logo = new JLabel();
        IcUser = new JLabel();
        botonInicio = new JPanel();
        IcHouseA = new JLabel();
        jLabel = new JLabel();
        jPanelBarras = new JPanel();
        jPanelCircular = new JPanel();
        botGraficar = new JButton();
        jComboBox1 = new JComboBox<>();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setPreferredSize(new java.awt.Dimension(1350, 700));
        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        jPanel1.setBackground(new java.awt.Color(65, 65, 67));
        jPanel1.setPreferredSize(new java.awt.Dimension(1350, 700));

        head.setBackground(new java.awt.Color(0, 0, 0));
        head.setPreferredSize(new java.awt.Dimension(1280, 40));

        Logo.setFont(new java.awt.Font("Roboto", 1, 14)); // NOI18N
        Logo.setForeground(new java.awt.Color(255, 255, 255));
        Logo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/logo2.png"))); // NOI18N
        Logo.setText("ANIMUSIC");

        IcUser.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/people.png"))); // NOI18N
        IcUser.setText("jLabel2");
        IcUser.setAlignmentY(0.0F);

        botonInicio.setBackground(new java.awt.Color(0, 0, 0));
        botonInicio.setPreferredSize(new java.awt.Dimension(45, 32));
        botonInicio.addMouseListener(new java.awt.event.MouseAdapter() {
                public void mouseClicked(java.awt.event.MouseEvent evt) {
                    botonInicioMouseClicked(evt);
                }
            });

        IcHouseA.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        IcHouseA.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/house2.png"))); // NOI18N
        IcHouseA.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));

        javax.swing.GroupLayout botonInicioLayout = new javax.swing.GroupLayout(botonInicio);
        botonInicio.setLayout(botonInicioLayout);
        botonInicioLayout.setHorizontalGroup(
            botonInicioLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(botonInicioLayout.createSequentialGroup()
                .addComponent(IcHouseA)
                .addGap(0, 10, Short.MAX_VALUE))
        );
        botonInicioLayout.setVerticalGroup(
            botonInicioLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(IcHouseA, javax.swing.GroupLayout.DEFAULT_SIZE, 40, Short.MAX_VALUE)
        );

        javax.swing.GroupLayout headLayout = new javax.swing.GroupLayout(head);
        head.setLayout(headLayout);
        headLayout.setHorizontalGroup(
            headLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, headLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(Logo, javax.swing.GroupLayout.PREFERRED_SIZE, 126, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(botonInicio, javax.swing.GroupLayout.PREFERRED_SIZE, 42, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(IcUser, javax.swing.GroupLayout.PREFERRED_SIZE, 36, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(8, 8, 8))
        );
        headLayout.setVerticalGroup(
            headLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(headLayout.createSequentialGroup()
                .addGroup(headLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(botonInicio, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(IcUser, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(Logo, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(0, 0, Short.MAX_VALUE))
        );

        jLabel.setFont(new java.awt.Font("Roboto Black", 3, 48)); // NOI18N
        jLabel.setForeground(new java.awt.Color(255, 255, 255));
        jLabel.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel.setText("ESTADÍSTICAS");

        jPanelBarras.setPreferredSize(new java.awt.Dimension(620, 400));

        javax.swing.GroupLayout jPanelBarrasLayout = new javax.swing.GroupLayout(jPanelBarras);
        jPanelBarras.setLayout(jPanelBarrasLayout);
        jPanelBarrasLayout.setHorizontalGroup(
            jPanelBarrasLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 713, Short.MAX_VALUE)
        );
        jPanelBarrasLayout.setVerticalGroup(
            jPanelBarrasLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 400, Short.MAX_VALUE)
        );

        jPanelCircular.setPreferredSize(new java.awt.Dimension(560, 400));

        javax.swing.GroupLayout jPanelCircularLayout = new javax.swing.GroupLayout(jPanelCircular);
        jPanelCircular.setLayout(jPanelCircularLayout);
        jPanelCircularLayout.setHorizontalGroup(
            jPanelCircularLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 0, Short.MAX_VALUE)
        );
        jPanelCircularLayout.setVerticalGroup(
            jPanelCircularLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 400, Short.MAX_VALUE)
        );

        botGraficar.setBackground(new java.awt.Color(203, 182, 163));
        botGraficar.setFont(new java.awt.Font("Roboto", 0, 12)); // NOI18N
        botGraficar.setText("Graficar");
        botGraficar.setBorder(null);
        botGraficar.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        botGraficar.addActionListener(new java.awt.event.ActionListener() {
                public void actionPerformed(java.awt.event.ActionEvent evt) {
                    botGraficarActionPerformed(evt);
                }
            });

        jComboBox1.setBackground(new java.awt.Color(203, 182, 163));
        jComboBox1.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Figuras", "Animaciones" }));

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(head, javax.swing.GroupLayout.DEFAULT_SIZE, 1340, Short.MAX_VALUE)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap(428, Short.MAX_VALUE)
                .addComponent(jLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 457, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(455, 455, 455))
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanelBarras, javax.swing.GroupLayout.PREFERRED_SIZE, 713, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(jPanelCircular, javax.swing.GroupLayout.DEFAULT_SIZE, 589, Short.MAX_VALUE)
                .addContainerGap())
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(37, 37, 37)
                .addComponent(jComboBox1, javax.swing.GroupLayout.PREFERRED_SIZE, 109, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(31, 31, 31)
                .addComponent(botGraficar, javax.swing.GroupLayout.PREFERRED_SIZE, 68, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addComponent(head, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(jLabel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGap(53, 53, 53)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(botGraficar, javax.swing.GroupLayout.PREFERRED_SIZE, 25, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jComboBox1, javax.swing.GroupLayout.PREFERRED_SIZE, 25, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(29, 29, 29)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanelBarras, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jPanelCircular, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(808, 808, 808))
        );

        getContentPane().add(jPanel1, new org.netbeans.lib.awtextra.AbsoluteConstraints(0, 0, 1340, 700));
    }

    private void botonInicioMouseClicked(java.awt.event.MouseEvent evt) {                                         
        dispose();
        new Inicio().setVisible(true);
    }                                        

    private void botGraficarActionPerformed(java.awt.event.ActionEvent evt) {  
        String tipoEstad= jComboBox1.getSelectedItem().toString();
        if(tipoEstad.equals("Figuras")){
            HashMap<String, Integer> datos = Texto.numeroAparicionesFile("estadisticaFigura.txt");               
            DefaultCategoryDataset setDatos = new DefaultCategoryDataset();
            DefaultPieDataset setDatos1 = new DefaultPieDataset();
            for (String palabra : datos.keySet()) {
                //System.out.println(palabra + ": " + datos.get(palabra));
                int frecuencia = datos.get(palabra);
                setDatos.setValue(frecuencia, "Frecuencia", palabra);
                setDatos1.setValue(palabra,frecuencia);
            }
            JFreeChart grafBarras = ChartFactory.createBarChart3D(
                    "Frecuencia de uso de Figuras", "Figuras", "Frecuencia", 
                    setDatos,  PlotOrientation.VERTICAL, true, false, false);

            ChartPanel panel = new ChartPanel(grafBarras);        
            panel.setPreferredSize (new Dimension(620, 400));
            jPanelBarras.setLayout(new BorderLayout());
            jPanelBarras.add(panel,BorderLayout.NORTH);

            JFreeChart grafCircular = ChartFactory.createPieChart3D(
                    "Frecuencia de uso de Figuras", setDatos1, true, true, false);

            ChartPanel panel2 = new ChartPanel( grafCircular);
            panel.setPreferredSize (new Dimension(560, 400));
            jPanelCircular.setLayout(new BorderLayout());
            jPanelCircular.add(panel2,BorderLayout.NORTH);

            jPanelBarras.revalidate();
            jPanelCircular.revalidate();
        }else {
            HashMap<String, Integer> datos1 = Texto.numeroAparicionesFile("estadisticaAnim.txt"); 
            DefaultCategoryDataset setDatos = new DefaultCategoryDataset();
            DefaultPieDataset setDatos1 = new DefaultPieDataset();
            for (String palabra : datos1.keySet()) {
                //System.out.println(palabra + ": " + datos1.get(palabra));
                int frecuencia = datos1.get(palabra);
                setDatos.setValue(frecuencia, "Frecuencia", palabra);
                setDatos1.setValue(palabra,frecuencia);
            }
            JFreeChart grafBarras = ChartFactory.createBarChart3D(
                    "Frecuencia de uso de Animaciones", "Animación", "Frecuencia", 
                    setDatos,  PlotOrientation.VERTICAL, true, false, false);

            ChartPanel panel = new ChartPanel(grafBarras);        
            panel.setPreferredSize (new Dimension(620, 400));
            jPanelBarras.setLayout(new BorderLayout());
            jPanelBarras.add(panel,BorderLayout.NORTH);

            JFreeChart grafCircular = ChartFactory.createPieChart3D(
                    "Frecuencia de uso de Animaciones", setDatos1, true, true, false);

            ChartPanel panel2 = new ChartPanel( grafCircular);
            panel.setPreferredSize (new Dimension(560, 400));
            jPanelCircular.setLayout(new BorderLayout());
            jPanelCircular.add(panel2,BorderLayout.NORTH);

            jPanelBarras.revalidate();
            jPanelCircular.revalidate();
        }
    }                                           

    public static void main(String args[]) {

        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Estadistica.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Estadistica.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Estadistica.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Estadistica.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }

        java.awt.EventQueue.invokeLater(new Runnable() {
                public void run() {
                    new Estadistica().setVisible(true);
                }
            });
    }

}
