import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/add-transaction-screen.dart';
import '../screens/transactions-screen.dart'; 
import 'auth-screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<TransactionsScreenState> transactionsKey = GlobalKey<TransactionsScreenState>();
  int selectedIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      TransactionsScreen(key: transactionsKey),
      const Center(child: Text('Графики — в разработке')),
      const SizedBox(),
      const Center(child: Text('Отчёты — в разработке')),
      const Center(child: Text('Профиль — в разработке')),
    ];
  }

  void onBottomNavTapped(int index) async{
    if (index == 2) {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
      );
      if(result == true && mounted){
        transactionsKey.currentState?.loadDataForPeriod();
      }
      return;
    }
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final String userName = user?.userMetadata?['full_name'] ?? 'Гость';

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Привет, $userName'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {

              await Supabase.instance.client.auth.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AuthScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex > 2 ? selectedIndex - 1 : selectedIndex,
        children: screens.where((widget) => widget != const SizedBox()).toList(),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 150,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildBottomIcon(0, Icons.list_alt, 'Записи'),
            buildBottomIcon(1, Icons.bar_chart, 'Графики'),
            const SizedBox(width: 40),
            buildBottomIcon(3, Icons.assessment, 'Отчёты'),
            buildBottomIcon(4, Icons.person, 'Профиль'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onBottomNavTapped(2);
        },
        backgroundColor: Colors.deepPurple,
        elevation: 8,
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildBottomIcon(int index, IconData icon, String label) {
    final bool isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => onBottomNavTapped(index),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? Colors.deepPurple : Colors.grey),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: isSelected ? Colors.deepPurple : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}