package utilities;

// import java.awt.Point;
// import java.util.ArrayList;
// import java.util.Collections;
// import java.util.Comparator;


abstract public class Utils {
  // public static void sort(ArrayList<Point> pts) {
  //   Collections.sort(pts, new Comparator<Point>() {
  //     @Override
  //     public int compare(Point p1, Point p2) {
  //       return Integer.compare(p1.x, p2.x);
  //     }
  //   });

  //   Collections.sort(pts, new Comparator<Point>() {
  //     @Override
  //     public int compare(Point p1, Point p2) {
  //       return Integer.compare(p1.y, p2.y);
  //     }
  //   });
  // }

  public static void pausar(long time) {
    try {
      Thread.sleep(time);
    } catch (InterruptedException ie) {
      ie.printStackTrace();
    }
  }

  public static int min(int[] list) {
    int ans = Integer.MAX_VALUE;

    for (int i = 0; i < list.length; i++) {
      if (list[i] < ans)
        ans = list[i];
    }

    return ans;
  }

  public static int max(int[] list) {
    int ans = Integer.MIN_VALUE;

    for (int i = 0; i < list.length; i++) {
      if (list[i] > ans)
        ans = list[i];
    }

    return ans;
  }
}
