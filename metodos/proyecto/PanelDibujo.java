import java.io.Serializable;
import herramientas.grafico.PanelModificado;

public class PanelDibujo extends PanelModificado implements Serializable {

    public PanelDibujo() {
        initComponents();
    }
    
    @SuppressWarnings("unchecked")                  
    private void initComponents() {

        setBackground(new java.awt.Color(65, 65, 67));
        setPreferredSize(new java.awt.Dimension(830, 910));

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 830, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 910, Short.MAX_VALUE)
        );
    }               
}
