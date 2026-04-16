import 'dart:io';

void main() {
  double balance =0;
  while (true) {
    print(" 1.Deposit  2.Withdraw  3.Check Balance  4.Exit");
    stdout.write("Choose option: ");
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        // deposit
        stdout.write("Deposit balance :");
        double amount=double.parse(stdin.readLineSync()!);
        balance += amount;
        print("deposit balance:$amount"); 
        break;

      case 2:
        // withdraw
        stdout.write("Withdraw balance:");
        double amount=double.parse(stdin.readLineSync()!);
        if(amount>balance){
           print( "Insufficient balance");
        }else{
            balance-=amount;
            print("withdraw :$amount");
        }
        break;

      case 3:
        // show balance
        print("Current balance: $balance");
        break;

      case 4:
        print("Thank you!");
        return;

      default:
        print("Invalid choice");
    }
  }
}
