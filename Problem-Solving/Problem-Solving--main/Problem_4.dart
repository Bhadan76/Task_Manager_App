class Payment{
    int amount;
    Payment(this.amount);
    void pay(){
        print("Processing.....");
    }
}

class CashPayment extends Payment{
    CashPayment(int amount):super(amount);
    @override
    void pay(){
      print("Paid $amount by Cash");
    }
}

class CardPayment extends Payment{
   String CardNumber;
   CardPayment(int amount,this.CardNumber):super(amount);
   @override
     void pay() {
        String last4=CardNumber.substring (CardNumber.length-4);
        
        print("Paid $amount by Card ending $last4");
       
     }
}

void main() {
    var cash=CashPayment(5000);
    var card=CardPayment(12000,"183829282928");
    cash.pay();
    card.pay();
}
