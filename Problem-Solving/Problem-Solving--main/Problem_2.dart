class Vehicle{
   String brand;
   int year;
   Vehicle(this.brand,this.year);
   void info(){
       print("Brand:$brand,Year:$year");
   }
}
class Car extends Vehicle{
    String model;
    Car(String brand,int year,this.model):super(brand,year);
    void fullInfo(){
        print("$brand $model $year");
    }
}

void main() {
  var obj=Car("toyota",2026,"corola");
  obj.info();
  obj.fullInfo();
}
