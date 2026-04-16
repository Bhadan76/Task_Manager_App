import 'dart:io';
void main() {
    stdout.write("Any Number:");
    int number=int.parse(stdin.readLineSync()!);
    
    if(number%2==0){
        print("Even Number.");
    }
    else{
        print("Odd Number.");
    }
}
