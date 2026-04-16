import 'dart:io';
void main() {
    stdout.write("Enter number:");
    int number=int.parse(stdin.readLineSync()!);
    int fact=1;
    for(int i=1;i<=number;i++){
        fact=fact*i;
        print(fact);
    }
    
}
