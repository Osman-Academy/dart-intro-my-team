import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/cubit/add-transaction-cubit.dart';
import '../presentation/category-icons.dart';
import '../presentation/transactio-currency.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTransactionCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Новая запись')),
        body: BlocConsumer<AddTransactionCubit, AddTransactionState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)),);
            }
            if (state.success) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${state.isExpense ? 'Расход' : 'Доход'} добавлен!'),backgroundColor: Colors.green,),);
              Navigator.of(context).pop(true);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: 
                  [Expanded(
                        child: TypeButton(
                          isSelected: state.isExpense,
                          label: 'Расход',
                          color: Colors.red,
                          onTap: () {
                            context.read<AddTransactionCubit>().setExpense(true);
                          }
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TypeButton(
                          isSelected: !state.isExpense,
                          label: 'Доход',
                          color: Colors.green,
                          onTap: ()  {
                            context.read<AddTransactionCubit>().setExpense(false);
                            }
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Сумма',
                      border: const OutlineInputBorder(),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child:
                          DropdownButton<String>(
                          value: state.currency,
                          underline: Container(),
                          icon: Container(),
                          onChanged: (value) {
                            if (value != null) {
                              context.read<AddTransactionCubit>().setCurrency(value);
                            }
                          },
                          items: transactionCurrency
                              .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                              .toList(),
                        ),
                      ),
                    ),
                    style: const TextStyle(fontSize: 24),
                    onChanged: context.read<AddTransactionCubit>().setAmount,
                  ),
                  const SizedBox(height: 24),
                  const Text('Категория', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  if (state.isLoadingCategories)
                    const Center(child: CircularProgressIndicator())
                  else if (state.categories.isEmpty)
                    const Text('Нет категорий')
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: state.categories.map((category) {
                        return ChoiceChip(
                          label: Row(
                            children: [
                              Icon(category.icon.isEmpty ? Icons.category : categoryIcons[category.icon]),
                              const SizedBox(width: 4),
                              Text(category.name),
                            ],
                          ),
                          selected: state.selectedCategory?.id == category.id,
                          onSelected: (_) {
                            context.read<AddTransactionCubit>().selectCategory(category);
                          },
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: 24),

                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Описание (необязательно)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                    onChanged: context.read<AddTransactionCubit>().setDescription,
                  ),
                  const SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: state.isSubmitting ? null : () => context.read<AddTransactionCubit>().submit(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.isExpense ? const Color.fromARGB(255, 235, 123, 31) : Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: state.isSubmitting? const CircularProgressIndicator(color: Colors.white): 
                      Text(
                        'Добавить ${state.isExpense ? 'расход' : 'доход'}',
                        style: const TextStyle(fontSize: 18),
                      ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class TypeButton extends StatelessWidget {
  final bool isSelected;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const TypeButton({
    required this.isSelected,
    required this.label,
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? color.withOpacity(0.1) : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color : Colors.transparent,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}