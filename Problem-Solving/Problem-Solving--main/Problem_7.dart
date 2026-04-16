import 'dart:io';

void main() {
    stdout.write('Enter a:');
    int A=int.parse(stdin.readLineSync()!);
    stdout.write('Enter b:');
    int B=int.parse(stdin.readLineSync()!);
    stdout.write('Enter c:');
    int C=int.parse(stdin.readLineSync()!);
    int largest = A;

    if (B > largest) largest = B;
    if (C > largest) largest = C;

    print("Largest number is $largest");
}
