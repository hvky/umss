import java.util.ArrayList;


public class Circunferencia {
  private int x, y, r;

  public Circunferencia(int x, int y, int r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }

  public ArrayList<int[]> bresenham() {
    ArrayList<int[]> ans = new ArrayList<int[]>();

    int x = this.r,
        y = 0, e = 0;

    while (y <= x) {
      addPoints(x, y, ans);

      e += (y << 1) + 1;
      y++;

      if ((e << 1) > ((x << 1) - 1)) {
        x--;
        e += 1 - (x << 1);
      }
    }

    return ans;
  }

  public ArrayList<int[]> midpoint() {
    ArrayList<int[]> ans = new ArrayList<int[]>();

    int x = this.r,
        y = 0,
        xChange = 1 - (this.r << 1),
        yChange = 1,
        radiusError = 0;

    while (x >= y) {
      addPoints(x, y, ans);

      y++;
      radiusError += yChange;
      yChange += 2;
      if ((radiusError << 1) + xChange > 0) {
        x--;
        radiusError += xChange;
        xChange += 2;
      }
    }

    return ans;
  }

  public void addPoints(int x, int y, ArrayList<int[]> list) {
    list.add(new int[] { this.x + x, this.y + y });
    list.add(new int[] { this.x - x, this.y + y });
    list.add(new int[] { this.x + x, this.y - y });
    list.add(new int[] { this.x - x, this.y - y });
    list.add(new int[] { this.x + y, this.y + x });
    list.add(new int[] { this.x - y, this.y + x });
    list.add(new int[] { this.x + y, this.y - x });
    list.add(new int[] { this.x - y, this.y - x });
  }
}
