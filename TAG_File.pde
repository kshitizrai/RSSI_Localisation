public class TAG_File {

  private int index;
  private ArrayList<anchor_received> connected = new ArrayList<anchor_received>();
  private float x_est = 0;
  private float y_est = 0;
  TAG_File(int x)
  {
    this.index= x;
  }

  public void addition(int anchor_index, int RSSI)
  {
    anchor_received ref = new anchor_received(anchor_index, RSSI);
    int i=0;
    int flag=0;
    for (i=0; i<connected.size(); i++)
    {
      anchor_received ref2 = connected.get(i);
      //   println("Ref :"+ ref2.indexRequest()+" New :"+ anchor_index + " index :" + i);
      if (ref2.indexRequest() == anchor_index)
      {
        //     println("Match");
        connected.set(i, ref);
        //     println("Anchor_Connected Before :-" + connected.size()); 
        flag=1;
        break;
      }
    }
    if (flag == 0)
      connected.add(ref);

    sorting();
    if(connected.size()>=3)
    {
      calculate_point();
    }
  }
  
 public void calculate_point()
 {
   color Tag_color = color(255,204,0);
   fill(Tag_color);
   stroke(255, 204, 0);
   ellipse(x_est/pixel_bred , y_est/pixel_leng , 20 ,20);
   
  float x1 = (connected.get(0)).XCor; 
  float y1 = (connected.get(0)).YCor; 
  float x2 = (connected.get(1)).XCor; 
  float y2 = (connected.get(1)).YCor;
  float x3 = (connected.get(2)).XCor;
  float y3 = (connected.get(2)).YCor;
  double r1 = (connected.get(0)).Request_Distance();
  double r2 = (connected.get(1)).Request_Distance();
  double r3 = (connected.get(2)).Request_Distance();
  
  x_est += (x2-x3)*((Math.pow(2,x2)-Math.pow(2,x1)) + (Math.pow(2,y2)-Math.pow(2,y1)) + (Math.pow(2,r2)-Math.pow(2,r1)));
  x_est -= ((x1-x2)*((Math.pow(2,x3)-Math.pow(2,x2)) + (Math.pow(2,y3)-Math.pow(2,y2)) + (Math.pow(2,r2)-Math.pow(2,r3))));
  x_est /= (2*((y1-y2)*(x2-x3)-(y2-y3)*(x1-x2)));
  y_est += (y2-y3)*((Math.pow(2,y2)-Math.pow(2,y1)) + (Math.pow(2,x2)-Math.pow(2,x1)) + (Math.pow(2,r2)-Math.pow(2,r1)));
  y_est -= ((y1-y2)*((Math.pow(2,y3)-Math.pow(2,y2)) + (Math.pow(2,x3)-Math.pow(2,x2)) + (Math.pow(2,r2)-Math.pow(2,r3))));
  y_est /= (2*((x1-x2)*(y2-y3)-(x2-x3)*(y1-y2)));
  
  Tag_color = color(0,255,0);
  fill(Tag_color);
  ellipse(x_est/pixel_bred , y_est/pixel_leng , 20 ,20);
 }
  
  private void sorting()
  {
    for (int i=0; i<connected.size()-1; i++)
    {
      for (int j=0; j<connected.size()-i-1; j++)
      {
        if ((connected.get(j)).RSSIRequest() < (connected.get(j+1)).RSSIRequest())
        {
       //   println("Replaced");
          anchor_received temp = connected.get(j);
          connected.set(j, connected.get(j+1));
          connected.set(j+1, temp);
        }
      }
    }
  }
  
  public void print()
  {  
    println("Index Tag: " + tags.get(index));
    for (int i=0; i<connected.size(); i++)
    {
      (connected.get(i)).print();
    }
    println("X estimate : " + x_est);
    println("Y estimate : " + y_est);
    println("*******************\n");

  }

  public void Anchor_Connected()
  {
    println("Anchor_Connected :-" + connected.size());
  } 
}
