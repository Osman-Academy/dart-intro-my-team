import 'dart:io';
class Category {
  final String name;
  Category(this.name);
}
class Item extends Category{
  final String title;
  int count = 1;
  Item(this.title, String category) : super(category);
  int add(int quantity){
    count += quantity;
    return count;
  }
  int remove(int quantity) {
    if(quantity>=0 && quantity <= count) {
      count -= quantity;
    }
    return count;
  }
  void display(){
    print('$title category: $name count: $count');
  }
}

void main(){
  Item item = Item("termos", "dishes");

  bool run = true;
  while(run){
    item.display();
    print("1)add" + "\n" + "2)remove" + "\n" + "3)cart" + "\n" + "4)exit");
    int choice = int.parse(stdin.readLineSync()!);
    if(choice==1){
      print("how many?");
      int quantity = int.parse(stdin.readLineSync()!);
      item.add(quantity);
    }
    if(choice==2){
      print("how many?");
      int quantity = int.parse(stdin.readLineSync()!);
      item.remove(quantity);
    }
    if(choice==3){
      item.display();
    }
    if(choice==4){
      run = false;
    }

  }
}