import "dart:io";

void main() {
  stdout.write("Word input:")  ;
  String text=stdin.readLineSync()!;
  var ans= text.split('').reversed.join();
  
  if(ans == text ){
      print("Palindrome");
  }else{
      print("Not Palindrome");
  }
    
}
