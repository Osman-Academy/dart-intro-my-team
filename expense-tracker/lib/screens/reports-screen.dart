import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/category.dart';
import '../domain/transaction.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  ReportsScreenState createState() => ReportsScreenState();
}

class ReportsScreenState extends State<ReportsScreen> {
  late Future<List<Transaction>> _future;
  final Map<String, String> categoryTypes = {};

  @override
  void initState() {
    super.initState();
    _future = _loadData();
    // Ensure Russian locale is initialized (important for Flutter Web)
    initializeDateFormatting('ru_RU', null);
  }

  void refresh() {
    setState(() {
      categoryTypes.clear();
      _future = _loadData();
    });
  }

  Future<List<Transaction>> _loadData() async {
    await _loadCategories();
    return _loadTransactions();
  }

  Future<void> _loadCategories() async {
    final response = await Supabase.instance.client.from('categories').select();

    for (final c in (response as List)) {
      final category = Category.fromJson(c);
      categoryTypes[category.id] = category.type;
    }
  }

  Future<List<Transaction>> _loadTransactions() async {
    final user = Supabase.instance.client.auth.currentUser;

    final response = await Supabase.instance.client
        .from('transactions')
        .select()
        .eq('user_id', user!.id)
        .order('created_at');

    return (response as List).map((e) => Transaction.fromJson(e)).toList();
  }

  String _capitalize(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

  Map<String, Map<String, double>> _groupByMonth(List<Transaction> transactions) {
    final result = <String, Map<String, double>>{};
    final formatter = DateFormat('LLLL yyyy', 'ru_RU');

    for (final t in transactions) {
      final key = _capitalize(formatter.format(t.createdAt));
      final type = categoryTypes[t.categoryId] ?? (t.amount >= 0 ? 'income' : 'expense');

      result.putIfAbsent(key, () => {'income': 0, 'expense': 0});

      if (type == 'income') {
        result[key]!['income'] = result[key]!['income']! + t.amount;
      } else {
        result[key]!['expense'] = result[key]!['expense']! + t.amount;
      }
    }

    return result;
  }

  String _seasonImage(String monthYear) {
    final m = DateFormat('LLLL yyyy', 'ru_RU').parse(monthYear.toLowerCase()).month;

    if (m == 12 || m <= 2) return 'assets/images/winter_new.jpg';
    if (m <= 5) return 'assets/images/spring_new.jpg';
    if (m <= 8) return 'assets/images/summer_new.jpg';
    return 'assets/images/autumn_new.jpg';
  }

  Widget _whiteFrameText(
    String text, {
    Color color = Colors.black,
    double fontSize = 16,
    FontWeight? fontWeight,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.bold,
        ),
      ),
    );
  }

  String _formatNumber(double number) {
    // Format numbers without decimals
    return NumberFormat('#,##0', 'ru_RU').format(number);
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      return const Center(child: Text('Не найден пользователь'));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Отчёты')),
      body: FutureBuilder<List<Transaction>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final stats = _groupByMonth(snapshot.data!);
          final entries = stats.entries.toList()
            ..sort((a, b) => DateFormat('LLLL yyyy', 'ru_RU')
                .parse(a.key.toLowerCase())
                .compareTo(DateFormat('LLLL yyyy', 'ru_RU').parse(b.key.toLowerCase())));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            itemBuilder: (_, i) {
              final e = entries[i];
              final income = e.value['income']!;
              final expense = e.value['expense']!;
              final total = income + expense;

              final monthTransactions = snapshot.data!
                  .where((t) => _capitalize(DateFormat('LLLL yyyy', 'ru_RU').format(t.createdAt)) == e.key)
                  .toList();

              final currency = monthTransactions.isNotEmpty ? (monthTransactions.first.currency ?? 'c.') : 'c.';

              return Container(
                height: 120,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    image: AssetImage(_seasonImage(e.key)),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _whiteFrameText(
                            e.key,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          _whiteFrameText(
                            '${_formatNumber(total)} $currency',
                            color: total >= 0 ? Colors.green : Colors.red,
                            fontSize: 24,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _whiteFrameText(
                            '-${_formatNumber(expense.abs())} $currency',
                            color: Colors.red,
                            fontSize: 15,
                          ),
                          _whiteFrameText(
                            '+${_formatNumber(income)} $currency',
                            color: Colors.green,
                            fontSize: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
