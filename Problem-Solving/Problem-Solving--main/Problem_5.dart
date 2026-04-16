abstract class Shape{
  double area();
}
class Circle implements Shape{
    double redius;
    Circle(this.redius);
    @override
     double area(){
        return 3.14*redius*redius;
    }
}
class Rectangle implements Shape{
    double width;
    double height;
    Rectangle(this.width,this.height);
    @override
    double area(){
        return width*height;
        
    }
}
class Triangle implements Shape{
    double width;
    double height;
    Triangle(this.width,this.height);
    @override
    double area(){
      return 0.5*width*height;
    }
}

void main() {
  Shape obj1=Circle(20);
  Shape obj2=Rectangle(20,30);
  Shape obj3=Triangle(30,50);
  print(obj1.area());
  print (obj2.area());
  print(obj3.area());
}
