import 'dart:io';

void main() {
    stdout.write("Enter text: ");
    String text = stdin.readLineSync()!;
    int count=0;
    for(int i=0;i<text.length;i++){
        String a=text[i];
        if("aeiouAEIOU". contains(a)){
          count++;
        }  
    }
    
  print(count);
}
