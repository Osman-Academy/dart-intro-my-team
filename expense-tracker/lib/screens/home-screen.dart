import 'package:expensetracker/screens/reports-screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/add-transaction-screen.dart';
import '../screens/graphs-screen.dart';
import '../screens/transactions-screen.dart';
import 'auth-screen.dart';
import '../screens/budget-screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<TransactionsScreenState> transactionsKey =
      GlobalKey<TransactionsScreenState>();

  final GlobalKey<GraphsScreenState> graphsKey = GlobalKey<GraphsScreenState>();

  final GlobalKey<ReportsScreenState> reportsKey =
      GlobalKey<ReportsScreenState>();

  final GlobalKey<BudgetScreenState> budgetKey = GlobalKey<BudgetScreenState>();

  int selectedIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      TransactionsScreen(key: transactionsKey),
      GraphsScreen(key: graphsKey),
      ReportsScreen(key: reportsKey),
      BudgetScreen(key: budgetKey,),
      const Center(child: Text('Профиль — в разработке')),
    ];
  }

  void onBottomNavTapped(int index) async {
    if (index == 2) {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
      );

      if (result == true && mounted) {
        transactionsKey.currentState?.loadDataForPeriod();
        graphsKey.currentState?.refresh();
        reportsKey.currentState?.refresh();
      }
    if (index == 4) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const BudgetScreen(),
        ), 
      );
      return;
    }
    }

    setState(() {
      selectedIndex = index > 2 ? index - 1 : index;
    });

    if (index == 1) {
      graphsKey.currentState?.refresh();
    }

    if (index == 3) {
      reportsKey.currentState?.refresh();
    }
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
                MaterialPageRoute(builder: (_) => const AuthScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 150),
        child: IndexedStack(
          index: selectedIndex,
          children: screens,
        ),
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
            buildBottomIcon(4, Icons.account_balance_wallet, 'Бюджет'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onBottomNavTapped(2),
        backgroundColor: Colors.deepPurple,
        elevation: 8,
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildBottomIcon(int index, IconData icon, String label) {
    final bool isSelected =
        selectedIndex == (index > 2 ? index - 1 : index);

    return InkWell(
      onTap: () => onBottomNavTapped(index),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.deepPurple : Colors.grey,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.deepPurple : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}