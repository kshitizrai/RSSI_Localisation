public class anchor_received
{
 private int index;
 private int RSSI;
 private double distance;
 private float n ;
 private float A;
 public float XCor;
 public float YCor;
 
 anchor_received(int index , int RSSI)
 {
  this.index = index;
  this.RSSI = RSSI;
  Anchor anchor_ref=anchors.get(index);
  this.n = anchor_ref.Request_n();
  this.A = anchor_ref.Request_A();
  this.XCor = anchor_ref.Anchor_XCor();
  this.YCor = anchor_ref.Anchor_YCor();
  this.distance = (A-float(RSSI))/(10*n);
  this.distance = Math.pow((10),this.distance);
 }
 
 public double Request_Distance()
 {
  return(this.distance); 
 }
  
 public int indexRequest()
 {
  return(index); 
 }
 
 public int RSSIRequest()
 {
   return(RSSI);   
 }
 
 public void print()
 {
   println("Index Anchor: " + (anchors.get(index)).requestAnchorMAC());
   println("RSSI: " + RSSI);
   println("N: " + n);
 }
 
}
