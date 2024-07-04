public class Circunferencia extends Grafico {
  private Punto pCentral;
  private int radio;

  public Circunferencia(Punto p, int r, Panel canvas) {
    this.pCentral = p;
    this.radio = r;
    this.canvas = canvas;
  }

  // PUNTO-MEDIO
  @Override
  public void dibujarContorno(int grosor, Estilo estilo, XColor color, int delay) {
    int x = this.radio,
        y = 0,
        xChange = 1 - (this.radio << 1),
        yChange = 1,
        radiusError = 0;
    
    int pintar = 0, noPintar = 0, cnt = 1;
    if (estilo != null) {
      pintar = estilo.pintar;
      noPintar = estilo.noPintar;
    }

    boolean f = true;
    while (x >= y) {
      if (estilo != null) {
        if (cnt == 1) {
          pintar--;

          if (pintar == 0) {
            pintar = estilo.pintar;
            cnt = 0;
            f = false;
          }
        } else {
          noPintar--;

          if (noPintar == 0) {
            noPintar = estilo.noPintar;
            cnt = 1;
            f = true;
          }
        }
      } else
        f = true;


      if (f)
        addPoints(x, y, grosor, delay, color.getValor());

      y++;
      radiusError += yChange;
      yChange += 2;
      if ((radiusError << 1) + xChange > 0) {
        x--;
        radiusError += xChange;
        xChange += 2;
      }
    }
  }

  @Override
  public void dibujarRelleno(XColor color, int delay) { }


  private void addPoints(int x, int y, int grosor, int delay, int color) {
    for (int i = 0; i < grosor; i++)
      for (int j = 0; j < grosor; j++) {
        canvas.drawPixel(pCentral.x + x + i, pCentral.y + y + j, color);
        canvas.drawPixel(pCentral.x - x + i, pCentral.y + y + j, color);
        canvas.drawPixel(pCentral.x + x + i, pCentral.y - y + j, color);
        canvas.drawPixel(pCentral.x - x + i, pCentral.y - y + j, color);
        canvas.drawPixel(pCentral.x + y + i, pCentral.y + x + j, color);
        canvas.drawPixel(pCentral.x - y + i, pCentral.y + x + j, color);
        canvas.drawPixel(pCentral.x + y + i, pCentral.y - x + j, color);
        canvas.drawPixel(pCentral.x - y + i, pCentral.y - x + j, color);

        try {
          Thread.sleep(delay);
        } catch (InterruptedException e) {
          e.printStackTrace();
        }
      }
  }
}
