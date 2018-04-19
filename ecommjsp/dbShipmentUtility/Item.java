package dbShipmentUtility;

/**
 *
 * @author foush
 */
public class Item {
  int id = 0;
  String name = "";
  int quantity = 0;
  double price = 0;
  float weight=0;
  public Item()
 {

 }

 //
   // Setters methods
   //
     public void setId(int n)
     {
       id = n;
     }
      public void setName(String s)
     {
      name = s;
     }
      public void setQuantity(int n)
     {
       quantity = n;
     }

     public void setPrice(double n)
     {
       price = n;
     }
     public void setWeight(float n)
     {
       weight = n;
     }

   //
   // Getters methods
   //
    public int getId()
    {
      return id;
    }
    public String getName()
    {
      return name;
    }

   public int getQuantity()
   {
    return quantity;
   }

   public double getPrice()
   {
     return price;
   }
   public float getWeight()
   {
     return weight;
   }

   @Override
      public String toString()
      {
        return id+" "+name+" "+quantity +" "+weight+" @ "+price;
      }




}
