import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => BudgetScreenState();
}

class BudgetScreenState extends State<BudgetScreen> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _budgets = [];
  bool _loading = true;
  
  final _categoryController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isAdding = false;
  String? _editingId;

  @override
  void initState() {
    super.initState();
    _loadBudgetsOnly(); // Только бюджеты, без транзакций
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // 🔥 ТОЛЬКО ЗАГРУЗКА БЮДЖЕТОВ (без транзакций)
  Future<void> _loadBudgetsOnly() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        print('❌ Пользователь не авторизован');
        return;
      }

      print('🔄 Загружаем ТОЛЬКО бюджеты для пользователя: $userId');

      // Простой запрос только для бюджетов
      final budgetsResponse = await _supabase
          .from('budgets')
          .select()
          .eq('user_id', userId);

      print('✅ Загружено бюджетов: ${budgetsResponse.length}');

      setState(() {
        _budgets = List<Map<String, dynamic>>.from(budgetsResponse);
        _loading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Загружено ${budgetsResponse.length} бюджетов'),
            backgroundColor: Colors.deepPurple,
            duration: const Duration(seconds: 2),
          ),
        );
      }

    } catch (e) {
      print('❌ Ошибка при загрузке бюджетов: $e');
      setState(() {
        _loading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ошибка загрузки'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  // Сохранение бюджета
  Future<void> _save() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      _showError('Пользователь не авторизован');
      return;
    }

    final category = _categoryController.text.trim();
    final amount = _amountController.text.trim();
    
    if (category.isEmpty || amount.isEmpty) {
      _showError('Заполните все поля');
      return;
    }

    try {
      final amountValue = double.tryParse(amount);
      if (amountValue == null || amountValue <= 0) {
        _showError('Введите корректную сумму');
        return;
      }

      final data = {
        'user_id': userId,
        'category_name': category,
        'limit_amount': amountValue,
        'created_at': DateTime.now().toIso8601String(),
      };

      if (_editingId != null) {
        await _supabase
            .from('budgets')
            .update(data)
            .eq('id', _editingId!);
      } else {
        await _supabase
            .from('budgets')
            .insert(data);
      }

      _reset();
      await _loadBudgetsOnly();

      _showSuccess(_editingId != null ? 'Бюджет обновлен!' : 'Бюджет создан!');

    } catch (e) {
      _showError('Ошибка при сохранении: $e');
    }
  }

  // Удаление бюджета
  Future<void> _delete(String id) async {
    try {
      await _supabase
          .from('budgets')
          .delete()
          .eq('id', id);

      await _loadBudgetsOnly();

      _showSuccess('Бюджет удален!');
    } catch (e) {
      _showError('Ошибка при удалении: $e');
    }
  }

  // Вспомогательные функции
  void _startAdd() {
    setState(() {
      _isAdding = true;
      _editingId = null;
      _categoryController.clear();
      _amountController.clear();
    });
  }

  void _startEdit(Map<String, dynamic> budget) {
    setState(() {
      _isAdding = true;
      _editingId = budget['id'];
      _categoryController.text = budget['category_name'] ?? '';
      _amountController.text = (budget['limit_amount'] as num).toString();
    });
  }

  void _reset() {
    setState(() {
      _isAdding = false;
      _editingId = null;
      _categoryController.clear();
      _amountController.clear();
    });
  }

  String _getCategoryName(Map<String, dynamic> budget) {
    final name = budget['category_name'] ?? 'Без названия';
    return name.isEmpty ? 'Без названия' : name;
  }

  double _getBudgetAmount(Map<String, dynamic> budget) {
    return (budget['limit_amount'] as num).toDouble();
  }

  String _getCreatedAt(Map<String, dynamic> budget) {
    if (budget['created_at'] != null) {
      try {
        final date = DateTime.parse(budget['created_at']);
        return DateFormat('dd.MM.yyyy').format(date);
      } catch (e) {
        return 'Дата не указана';
      }
    }
    return 'Дата не указана';
  }

  double _getTotalBudget() {
    double total = 0.0;
    for (var budget in _budgets) {
      total += _getBudgetAmount(budget);
    }
    return total;
  }

  // 🔥 Убраны все функции связанные с транзакциями
  double _getSpentForBudget(Map<String, dynamic> budget) {
    // Возвращаем 0, так как транзакции не загружаем
    return 0.0;
  }

  double _getBudgetUsage(Map<String, dynamic> budget) {
    // Всегда 0%, так как нет данных о тратах
    return 0.0;
  }

  Color _getUsageColor(double usage) {
    // Всегда зеленый, так как нет реальных данных
    return Colors.green;
  }

  double _getRemainingForBudget(Map<String, dynamic> budget) {
    // Остаток равен лимиту, так как трат нет
    return _getBudgetAmount(budget);
  }

  double _getTotalSpent() {
    // Сумма потраченного всегда 0
    return 0.0;
  }

  double _getTotalRemaining() {
    // Остаток равен общему лимиту
    return _getTotalBudget();
  }

  void _showSuccess(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.deepPurple,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: const Text(
          '💰 Мой бюджет',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadBudgetsOnly,
            tooltip: 'Обновить данные',
          ),
        ],
      ),
      body: _loading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    '📥 Загружаем данные...',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Пожалуйста, подождите',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // 📊 ЗАГОЛОВОК С ДАННЫМИ ИЗ SUPABASE
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[800],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.cloud_done, color: Colors.green[300]),
                          const SizedBox(width: 8),
                          const Text(
                            'Данные загружены',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      // 📈 БЫСТРАЯ СТАТИСТИКА (только бюджеты)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildQuickStat(
                              'Бюджеты',
                              '${_budgets.length}',
                              Icons.list,
                              Colors.white,
                            ),
                            Container(height: 30, width: 1, color: Colors.white30),
                            _buildQuickStat(
                              'Общий лимит',
                              '${NumberFormat('#,###').format(_getTotalBudget())} ₽',
                              Icons.attach_money,
                              Colors.white,
                            ),
                            Container(height: 30, width: 1, color: Colors.white30),
                            _buildQuickStat(
                              'Использовано',
                              '0%', // Всегда 0% без транзакций
                              Icons.trending_up,
                              Colors.green, // Всегда зеленый
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 🎯 КНОПКА ДОБАВЛЕНИЯ
                if (!_isAdding)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton.icon(
                      onPressed: _startAdd,
                      icon: const Icon(Icons.add_circle_outline),
                      label: const Text(
                        'Добавить новый бюджет',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepPurple,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                // 📝 ФОРМА ДОБАВЛЕНИЯ/РЕДАКТИРОВАНИЯ
                if (_isAdding)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          _editingId != null ? '✏️ Редактировать бюджет' : '➕ Создать новый бюджет',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        TextField(
                          controller: _categoryController,
                          decoration: const InputDecoration(
                            labelText: 'Название категории',
                            labelStyle: TextStyle(color: Colors.black87),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Пример: Продукты, Транспорт...',
                            prefixIcon: Icon(Icons.category, color: Colors.deepPurple),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Сумма лимита (₽)',
                            labelStyle: TextStyle(color: Colors.black87),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.attach_money, color: Colors.deepPurple),
                            prefixText: '₽ ',
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _save,
                                icon: const Icon(Icons.cloud_upload, size: 20),
                                label: const Text('Сохранить'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _reset,
                                icon: const Icon(Icons.cancel, size: 20),
                                label: const Text('Отмена'),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.deepPurple),
                                  foregroundColor: Colors.deepPurple,
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                // 📋 СПИСОК БЮДЖЕТОВ ИЗ SUPABASE
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        // Заголовок списка
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.cloud, color: Colors.deepPurple),
                                  SizedBox(width: 8),
                                  Text(
                                    'Ваши бюджеты',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${_budgets.length} шт.',
                                  style: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Список или пустой экран
                        Expanded(
                          child: _budgets.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cloud_off,
                                        size: 80,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'пока нет бюджетов',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 40),
                                        child: Text(
                                          'Создайте первый бюджет, и он появится здесь',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton.icon(
                                        onPressed: _startAdd,
                                        icon: const Icon(Icons.add),
                                        label: const Text('Создать первый бюджет'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.deepPurple,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(16),
                                  itemCount: _budgets.length,
                                  itemBuilder: (context, index) {
                                    final budget = _budgets[index];
                                    final categoryName = _getCategoryName(budget);
                                    final limit = _getBudgetAmount(budget);
                                    final spent = _getSpentForBudget(budget); // Всегда 0
                                    final remaining = _getRemainingForBudget(budget); // Всегда равен лимиту
                                    final usage = _getBudgetUsage(budget); // Всегда 0
                                    final createdAt = _getCreatedAt(budget);

                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                        border: Border.all(
                                          color: Colors.grey[200]!,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          // Шапка карточки
                                          ListTile(
                                            contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 8,
                                            ),
                                            leading: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.deepPurple[100],
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Icon(
                                                _getCategoryIcon(categoryName),
                                                color: Colors.deepPurple,
                                                size: 20,
                                              ),
                                            ),
                                            title: Text(
                                              categoryName,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            subtitle: Text(
                                              'Создан: $createdAt',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            trailing: PopupMenuButton(
                                              icon: const Icon(Icons.more_vert, color: Colors.grey),
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  child: const Row(
                                                    children: [
                                                      Icon(Icons.edit, color: Colors.blue, size: 18),
                                                      SizedBox(width: 8),
                                                      Text('Редактировать'),
                                                    ],
                                                  ),
                                                  onTap: () => _startEdit(budget),
                                                ),
                                                PopupMenuItem(
                                                  child: const Row(
                                                    children: [
                                                      Icon(Icons.delete, color: Colors.red, size: 18),
                                                      SizedBox(width: 8),
                                                      Text('Удалить'),
                                                    ],
                                                  ),
                                                  onTap: () => _delete(budget['id']),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Статистика (всегда зеленая, так как трат нет)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: Column(
                                              children: [
                                                // Прогресс бар (всегда 0%)
                                                LinearProgressIndicator(
                                                  value: 0.0,
                                                  minHeight: 6,
                                                  backgroundColor: Colors.grey[200],
                                                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                                                ),
                                                
                                                const SizedBox(height: 8),
                                                
                                                // Цифры
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Лимит',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey[600],
                                                          ),
                                                        ),
                                                        Text(
                                                          '${NumberFormat('#,###').format(limit)} ₽',
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.deepPurple,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'Потрачено',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey[600],
                                                          ),
                                                        ),
                                                        const Text(
                                                          '0 ₽', // Всегда 0
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'Остаток',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey[600],
                                                          ),
                                                        ),
                                                        Text(
                                                          '${NumberFormat('#,###').format(remaining)} ₽',
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                
                                                const SizedBox(height: 8),
                                                
                                                // Процент (всегда 0%)
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.green.withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: const Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.check_circle,
                                                        size: 12,
                                                        color: Colors.green,
                                                      ),
                                                      SizedBox(width: 4),
                                                      Text(
                                                        '0% использовано',
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.green,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                
                                                const SizedBox(height: 12),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: _isAdding ? null : FloatingActionButton(
        onPressed: _startAdd,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
        tooltip: 'Добавить бюджет',
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  // Виджет быстрой статистики
  Widget _buildQuickStat(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: color.withOpacity(0.7),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  // Иконка категории
  IconData _getCategoryIcon(String categoryName) {
    final name = categoryName.toLowerCase();
    if (name.contains('еда') || name.contains('продукт')) return Icons.shopping_cart;
    if (name.contains('транспорт') || name.contains('машина')) return Icons.directions_car;
    if (name.contains('развлеч') || name.contains('кино')) return Icons.movie;
    if (name.contains('кафе') || name.contains('ресторан')) return Icons.restaurant;
    if (name.contains('дом') || name.contains('квартира')) return Icons.home;
    if (name.contains('одежда') || name.contains('шопинг')) return Icons.shopping_bag;
    if (name.contains('здоровье') || name.contains('врач')) return Icons.medical_services;
    if (name.contains('обучение') || name.contains('курс')) return Icons.school;
    return Icons.category;
  }
}