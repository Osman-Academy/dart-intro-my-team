import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/repository/transaction-repository.dart';
import 'package:get_it/get_it.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => TransactionsScreenState();
}

class TransactionsScreenState extends State<TransactionsScreen> {
  DateTime selectedDate = DateTime.now();
  bool isMonthView = true;

  double income = 0.0;
  double expense = 0.0;
  List<Map<String, dynamic>> transactions = [];
  bool isLoading = false;
  final SupabaseClient supabase = GetIt.instance<SupabaseClient>();
  final TransactionRepository transactionRepository = GetIt.instance<TransactionRepository>(); 

  double get balance => income - expense;

  @override
  void initState() {
    super.initState();
    loadDataForPeriod();
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      locale: const Locale('ru', 'RU'),
      initialDatePickerMode: DatePickerMode.day,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.deepPurple,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        isMonthView = false;
      });
      loadDataForPeriod();
    }
  }

  Future<void> loadDataForPeriod() async {
    setState(() => isLoading = true);

    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      setState(() => isLoading = false);
      return;
    }

    late DateTime start;
    late DateTime end;

    if (isMonthView) {
      start = DateTime(selectedDate.year, selectedDate.month, 1);
      end = DateTime(selectedDate.year, selectedDate.month + 1, 0, 23, 59, 59);
    } else {
      start = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
      end = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);
    }

    try {
          final transactionsData = await transactionRepository.getTransactions(
            userId: userId,
            start: start,
            end: end,
          );

          double inc = 0.0;
          double exp = 0.0;

          for (var t in transactionsData) {
            final amount = (t['amount'] as num?)?.toDouble() ?? 0.0;
            if (amount > 0) {
              inc += amount;
            } else {
              exp += amount.abs();
            }
          }

          if (!mounted) {
            return;
          }
          setState(() {
            transactions = transactionsData;
            income = inc;
            expense = exp;
            isLoading = false;
          });
          
        } catch (e) {
          print(e);
          if (!mounted) {
            return;
          }
          setState(() => isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ошибка загрузки данных')),
          );
          
        }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          color: Colors.grey[50],
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(isMonthView ? Icons.today : Icons.view_module),
                    tooltip: isMonthView ? 'Выбрать день' : 'Вернуться к месяцу',
                    onPressed: () {
                      setState(() {
                        isMonthView = !isMonthView;
                        if (isMonthView) {
                          selectedDate = DateTime(selectedDate.year, selectedDate.month, 1);
                        }
                      });
                      loadDataForPeriod();
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => selectDate(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calendar_today, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            isMonthView
                                ? DateFormat('MMMM yyyy', 'ru_RU').format(selectedDate)
                                : DateFormat('d MMMM yyyy', 'ru_RU').format(selectedDate),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const Icon(Icons.arrow_drop_down, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: buildStatCard('Расходы', expense, Colors.red)),
                  const SizedBox(width: 12),
                  Expanded(child: buildStatCard('Доходы', income, Colors.green)),
                  const SizedBox(width: 12),
                  Expanded(child: buildStatCard('Баланс', balance, Colors.deepPurple)),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Обновить данные',
                  color: Colors.deepPurple,
                  onPressed: loadDataForPeriod,
                ),
              ),
            ],
          ),
        ),
        Expanded(child: buildTransactionsList()),
      ],
    );
  }

  Widget buildStatCard(String title, double amount, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          Text(
            '${amount.toStringAsFixed(0)} ₽',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  Widget buildTransactionsList() {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    if (transactions.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Твои транзакции будут здесь\n(пока пусто)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final t = transactions[index];
        final double amount = (t['amount'] as num?)?.toDouble() ?? 0.0;
        final String description = (t['description'] as String?) ?? 'Без описания';
        final String createdAtStr = (t['created_at'] as String?) ?? DateTime.now().toIso8601String();
        final DateTime date = DateTime.parse(createdAtStr);
        final bool isIncome = amount > 0;
        final Color color = isIncome ? Colors.green : Colors.red;
        final String currency = (t['currency'] as String?) ?? 'c.';

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(isIncome ? Icons.trending_up : Icons.trending_down, color: color),
            ),
            title: Text(description),
            subtitle: Text(DateFormat('d MMM yyyy', 'ru_RU').format(date)),
            trailing: Text(
              '${isIncome ? '+' : '-'}${amount.abs().toStringAsFixed(0)} $currency',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
            ),
          ),
        );
      },
    );
  }
}