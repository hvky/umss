import java.awt.Color;
import java.awt.Dimension;
import javax.swing.GroupLayout;
import herramientas.grafico.PanelModificado;

public class PanelAnimacion extends PanelModificado {

    public PanelAnimacion() {
        initComponents();
    }

    @SuppressWarnings("unchecked")
    private void initComponents() {
        setBackground(new Color(65, 65, 67));
        setPreferredSize(new Dimension(660, 760));

        javax.swing.GroupLayout layout = new GroupLayout(this);
        setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGap(0, 710, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(GroupLayout.Alignment.LEADING)
            .addGap(0, 580, Short.MAX_VALUE)
        );
    }
}
