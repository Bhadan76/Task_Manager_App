
import 'dart:io';
void main() {
    stdout.write('Multiplication num:');
    int num=int.parse(stdin.readLineSync()!);
    stdout.write('Limit num:');
    int limit=int.parse(stdin.readLineSync()!);
    for(int i=1;i<=limit;i++){
        int result=num*i;
        
        print("$num x $i=$result");
    }
  
}
