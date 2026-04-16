class Employee{
    String name;
    int salary;
    Employee(this.name,this.salary);
    void info(){
        print("Name:$name,Salary:$salary");
    }
}

class Manager extends Employee{
    int bonus;
    int salary;
    Manager(String name,this.salary,this.bonus):super(name,salary);
    totalSalary(){
        return salary+bonus;
    }
}

class Developer extends Employee{
    int overtimeHours;
    int salary;
    Developer(String name,this.salary,this. overtimeHours):super(name,salary);
    totalSalary(){
       return salary + (overtimeHours * 200);
    }
    
}
void main(){
    var obj1=Manager("Bhadan",30000,5000);
    var obj2=Developer("Oop",20000,15);
   
    print("Manager salary:${obj1.totalSalary()}");
    print("Developer salary:${obj2.totalSalary()}");
}
