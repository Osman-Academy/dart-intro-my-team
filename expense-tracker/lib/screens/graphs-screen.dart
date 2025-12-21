import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/transaction.dart';
import '../domain/category.dart';
import '../data/repository/transaction-repository.dart';
import '../data/repository/category-repository.dart';

class GraphsScreen extends StatefulWidget {
  const GraphsScreen({super.key});

  @override
  GraphsScreenState createState() => GraphsScreenState();
}

class GraphsScreenState extends State<GraphsScreen> {
  int _selectedPeriodIndex = 2; // Default to "Год" (Year)
  int _selectedYearIndex = 3; // Default to "Этот год" (This year)
  
  final TransactionRepository _transactionRepo = TransactionRepository();
  final CategoryRepository _categoryRepo = CategoryRepository();
  
  List<Transaction> _transactions = [];
  List<Category> _categories = [];
  List<Map<String, dynamic>> _categoryTotals = [];
  double _totalAmount = 0.0;
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> refresh() async {
    await _loadData();
  }
  
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      _categories = await _categoryRepo.getExpenseCategories();
      await _loadTransactionsForSelection();
    } catch (e) {
      print('Error loading data: $e');
      // You might want to show an error message to the user
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  DateTimeRange _selectedRange() {
    final now = DateTime.now();

    int selectedYear;
    switch (_selectedYearIndex) {
      case 0:
        selectedYear = 2022;
        break;
      case 1:
        selectedYear = 2023;
        break;
      case 2:
        selectedYear = now.year - 1;
        break;
      case 3:
      default:
        selectedYear = now.year;
        break;
    }

    late DateTime start;
    late DateTime end;

    switch (_selectedPeriodIndex) {
      case 0: // Week
        end = selectedYear == now.year
            ? now
            : DateTime(selectedYear, 12, 31, 23, 59, 59);
        start = end.subtract(const Duration(days: 7));
        break;
      case 1: // Month
        final monthStart = selectedYear == now.year
            ? DateTime(now.year, now.month, 1)
            : DateTime(selectedYear, 12, 1);
        start = monthStart;
        end = DateTime(monthStart.year, monthStart.month + 1, 0, 23, 59, 59);
        break;
      case 2: // Year
      default:
        start = DateTime(selectedYear, 1, 1);
        end = DateTime(selectedYear, 12, 31, 23, 59, 59);
        break;
    }

    return DateTimeRange(start: start, end: end);
  }

  Future<void> _loadTransactionsForSelection() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      if (!mounted) return;
      setState(() {
        _transactions = [];
        _totalAmount = 0.0;
        _categoryTotals = [];
        _isLoading = false;
      });
      return;
    }

    try {
      final range = _selectedRange();

      final rows = await _transactionRepo.getTransactions(
        userId: userId,
        start: range.start,
        end: range.end,
      );

      final txs = <Transaction>[];
      for (final row in rows) {
        try {
          final tx = Transaction.fromJson(row);
          if (tx.id.isEmpty) continue;
          txs.add(tx);
        } catch (_) {
          // Skip invalid rows
        }
      }

      if (!mounted) return;
      setState(() {
        _transactions = txs;
      });

      _processTransactionData();
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _transactions = [];
        _totalAmount = 0.0;
        _categoryTotals = [];
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  void _processTransactionData() {
    final expenseCategoryIds = _categories.map((c) => c.id).toSet();
    final filteredTransactions = _transactions.where((t) {
      if (!expenseCategoryIds.contains(t.categoryId)) return false;
      return true;
    }).toList();

    final totalAmount = filteredTransactions.fold<double>(
      0.0,
      (sum, t) => sum + t.amount.abs(),
    );

    final categoryMap = <String, double>{};
    final categoryCounts = <String, int>{};

    for (final transaction in filteredTransactions) {
      final amount = transaction.amount.abs();
      categoryMap.update(
        transaction.categoryId,
        (value) => value + amount,
        ifAbsent: () => amount,
      );

      categoryCounts.update(
        transaction.categoryId,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }

    final categoryTotals = categoryMap.entries.map((entry) {
      final category = _categories.firstWhere(
        (c) => c.id == entry.key,
        orElse: () => Category(
          id: entry.key,
          name: 'Неизвестно',
          icon: 'help',
          type: 'expense',
        ),
      );

      final amount = entry.value;
      final percentage = totalAmount > 0 ? (amount / totalAmount) * 100 : 0.0;
      final transactionCount = categoryCounts[entry.key] ?? 0;

      return {
        'id': entry.key,
        'name': category.name,
        'amount': amount,
        'percentage': percentage,
        'color': _getCategoryColor(category.name),
        'icon': _getCategoryIcon(category.name),
        'transactionCount': transactionCount,
        'transactions': filteredTransactions
            .where((t) => t.categoryId == entry.key)
            .toList(),
      };
    }).toList();

    categoryTotals.sort((a, b) => (b['amount'] as double).compareTo(a['amount'] as double));

    if (!mounted) return;
    setState(() {
      _totalAmount = totalAmount;
      _categoryTotals = categoryTotals;
    });
  }
  
  Color _getCategoryColor(String categoryName) {
    // Define your color scheme here
    switch (categoryName.toLowerCase()) {
      case 'семья':
        return Colors.amber;
      case 'образование':
        return Colors.blue;
      case 'проеб':
        return Colors.red;
      case 'еда':
        return Colors.green;
      case 'электроника':
        return Colors.purple;
      case 'одежда':
        return Colors.orange;
      default:
        return Colors.primaries[categoryName.length % Colors.primaries.length];
    }
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.decimalPattern('ru_RU');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Расходы', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPeriodButton('Неделя', 0),
                      _buildPeriodButton('Месяц', 1),
                      _buildPeriodButton('Год', 2),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildYearButton('2022', 0),
                        _buildYearButton('2023', 1),
                        _buildYearButton('Прошлый год', 2),
                        _buildYearButton('Этот год', 3),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
          if (_isLoading)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_categoryTotals.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('Нет данных о расходах')),
            )
          else ...[
            SliverToBoxAdapter(
              child: Container(
                height: 260,
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final d = constraints.biggest.shortestSide;
                        return Center(
                          child: SizedBox.square(
                            dimension: d,
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 1,
                                centerSpaceRadius: 70,
                                sections: _categoryTotals.map((category) {
                                  final percentage = category['percentage'] as double;
                                  final amount = category['amount'] as double;
                                  final showTitle = percentage >= 2.0;
                                  return PieChartSectionData(
                                    color: category['color'],
                                    value: amount,
                                    title: showTitle
                                        ? '${percentage.toStringAsFixed(0)}%'
                                        : '',
                                    radius: 92,
                                    titlePositionPercentageOffset: 0.7,
                                    titleStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Всего',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: 150,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${numberFormat.format(_totalAmount.round())} сом',
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 14)),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final category = _categoryTotals[index];
                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: category['color'].withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          category['icon'],
                          color: category['color'],
                        ),
                      ),
                      title: Text(
                        category['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${category['percentage'].toStringAsFixed(1)}%'),
                      trailing: Text(
                        '${category['amount'].toStringAsFixed(2)} сом',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                  childCount: _categoryTotals.length,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPeriodButton(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPeriodIndex = index;
        });
        _loadTransactionsForSelection();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _selectedPeriodIndex == index ? Colors.amber : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: _selectedPeriodIndex == index ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildYearButton(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedYearIndex = index;
        });
        _loadTransactionsForSelection();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _selectedYearIndex == index ? Colors.amber : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: _selectedYearIndex == index ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    // Map category names to icons
    final iconMap = {
      'семья': Icons.home,
      'образование': Icons.school,
      'проеб': Icons.money_off,
      'еда': Icons.restaurant,
      'рестораны': Icons.restaurant,
      'кафе': Icons.coffee,
      'транспорт': Icons.directions_car,
      'здоровье': Icons.local_hospital,
      'развлечения': Icons.movie,
      'покупки': Icons.shopping_bag,
      'электроника': Icons.devices,
      'одежда': Icons.checkroom,
      'коммунальные': Icons.bolt,
      'связь': Icons.phone_android,
      'образование': Icons.school,
      'путешествия': Icons.flight,
      'подарки': Icons.card_giftcard,
      'другое': Icons.category,
    };
    
    // Try to find a matching icon (case insensitive)
    final icon = iconMap[categoryName.toLowerCase()];
    return icon ?? Icons.category; // Default icon if not found
  }
}
