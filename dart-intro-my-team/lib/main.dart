import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunrise Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const CartPage(),
    );
  }
}

class Item {
  final String name;
  final double price;
  final String image;
  const Item(this.name, this.price, this.image);
}

class Category {
  final String name;
  final List<Item> items;
  const Category(this.name, this.items);
}

class CartModel extends ChangeNotifier {
  final Map<Item, int> _items = {};

  void addItem(Item item) {
    _items[item] = (_items[item] ?? 0) + 1;
    notifyListeners();
  }

  void removeItem(Item item) {
    if (_items.containsKey(item)) {
      _items[item] = _items[item]! - 1;
      if (_items[item]! <= 0) _items.remove(item);
      notifyListeners();
    }
  }

  double get total =>
      _items.entries.fold(0, (sum, e) => sum + e.key.price * e.value);

  Map<Item, int> get items => _items;
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cart = CartModel();

  final categories = const [
    Category("Фрукты", [
      Item("Яблоко", 1.2, "https://cdn-icons-png.flaticon.com/512/415/415682.png"),
      Item("Банан", 0.8, "https://cdn-icons-png.flaticon.com/128/2909/2909761.png"),
      Item("Апельсин", 1.5, "https://cdn-icons-png.flaticon.com/512/415/415734.png"),
    ]),
    Category("Овощи", [
      Item("Помидор", 1.0, "https://cdn-icons-png.flaticon.com/128/5280/5280911.png"),
      Item("Огурец", 0.9, "https://cdn-icons-png.flaticon.com/128/7758/7758758.png"),
      Item("Морковь", 0.7, "https://cdn-icons-png.flaticon.com/128/5124/5124099.png"),
    ]),
    Category("Электроника", [
      Item("Телефон", 600, "https://cdn-icons-png.flaticon.com/512/15/15874.png"),
      Item("Наушники", 100, "https://cdn-icons-png.flaticon.com/128/27/27130.png"),
      Item("Ноутбук", 950, "https://cdn-icons-png.flaticon.com/128/428/428001.png"),
    ]),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop 🛒"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, i) {
                final category = categories[i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: ExpansionTile(
                      title: Text(
                        category.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      children: category.items.map((item) {
                        return ListTile(
                          leading: Image.network(item.image, width: 40, height: 40),
                          title: Text(item.name),
                          subtitle: Text("\$${item.price.toStringAsFixed(2)}"),
                          trailing: ElevatedButton.icon(
                            onPressed: () {
                              setState(() => cart.addItem(item));
                            },
                            icon: const Icon(Icons.add_shopping_cart, size: 18),
                            label: const Text("Добавить"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.orange.shade50,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "🛍️ Ваша корзина:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.deepOrange),
                ),
                const SizedBox(height: 8),
                if (cart.items.isEmpty)
                  const Text("Корзина пуста"),
                ...cart.items.entries.map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${e.key.name} x${e.value}"),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() => cart.removeItem(e.key));
                              },
                              icon: const Icon(Icons.remove_circle_outline,
                                  color: Colors.red),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() => cart.addItem(e.key));
                              },
                              icon: const Icon(Icons.add_circle_outline,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    )),
                const Divider(),
                Text(
                  "Итого: \$${cart.total.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
