import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../data/repository/transaction-repository.dart';
import '../../data/repository/category-repository.dart';
import '../../domain/category.dart';
import '../../domain/transaction.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddTransactionState {
  final bool isExpense;
  final double amount;
  final String description;
  final String currency;
  final Category? selectedCategory;
  final List<Category> categories;

  final bool isLoadingCategories;
  final bool isSubmitting;
  final String? errorMessage;
  final bool success;

  const AddTransactionState({
    this.isExpense = true,
    this.amount = 0.0,
    this.description = '',
    this.currency = '₽',
    this.selectedCategory,
    this.categories = const [],
    this.isLoadingCategories = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.success = false,
  });

  AddTransactionState copyWith({
    bool? isExpense,
    double? amount,
    String? description,
    String? currency,
    Category? selectedCategory,
    List<Category>? categories,
    bool? isLoadingCategories,
    bool? isSubmitting,
    String? errorMessage,
    bool? success,
  }) {
    return AddTransactionState(
      isExpense: isExpense ?? this.isExpense,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      currency: currency ?? this.currency,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categories: categories ?? this.categories,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
      success: success ?? this.success,
    );
  }
}

class AddTransactionCubit extends Cubit<AddTransactionState> {
  final CategoryRepository categoryRepository = GetIt.instance<CategoryRepository>();
  final TransactionRepository transactionRepository = GetIt.instance<TransactionRepository>();
  final Uuid uuid = const Uuid();

  AddTransactionCubit() : super(const AddTransactionState()) {
    loadCategories();
  }

  void setExpense(bool isExpense) {
    if (state.isExpense == isExpense) return;
    emit(state.copyWith(isExpense: isExpense,selectedCategory: null));
    loadCategories();
  }

  void setAmount(String value) {
    final double? parsed = double.tryParse(value);
    emit(state.copyWith(amount: parsed ?? 0.0));
  }

  void setDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void setCurrency(String currency) {
    emit(state.copyWith(currency: currency));
  }

  void selectCategory(Category category) {
    emit(state.copyWith(selectedCategory: category));
  }

  Future<void> loadCategories() async {
    emit(state.copyWith(isLoadingCategories: true, errorMessage: null));

    try {
      final categories = state.isExpense? await categoryRepository.getExpenseCategories(): await categoryRepository.getIncomeCategories();
      final selected = categories.isEmpty ? null : categories[0];
      emit(state.copyWith(isLoadingCategories: false,categories: categories,selectedCategory: selected));
    } catch (e) {
      final debugExpense = Category(
        id: '550e8400-e29b-41d4-a716-446655440010',
        name: 'debug_expense',
        icon: 'other_expense',
        type: 'expense',
      );
      final debugIncome = Category(
        id: '550e8400-e29b-41d4-a716-446655440106',
        name: 'debug_income',
        icon: 'other_income',
        type: 'income',
      );

      final fallbackCategories = state.isExpense ? [debugExpense] : [debugIncome];

      emit(state.copyWith(isLoadingCategories: false,categories: fallbackCategories,selectedCategory: fallbackCategories[0],errorMessage: e.toString(),));
    }
  }

  Future<void> submit() async {
    if (state.selectedCategory == null || state.amount <= 0) {
      emit(state.copyWith(errorMessage: 'Введите сумму и выберите категорию'));
      emit(state.copyWith(errorMessage: null)); 
      return;
    }
    emit(state.copyWith(isSubmitting: true, errorMessage: null, success: false));
    try {
      final transaction = Transaction(
        id: uuid.v4(),
        userId: Supabase.instance.client.auth.currentUser!.id,
        categoryId: state.selectedCategory!.id,
        description: state.description,
        amount: state.isExpense ? -state.amount : state.amount,
        createdAt: DateTime.now(),
        currency: state.currency,
      );
      await transactionRepository.addTransaction(transaction);
      emit(state.copyWith(isSubmitting: false, success: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false,errorMessage: 'Ошибка: $e',));
    }
  }
}