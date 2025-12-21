import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';
import '../models/category.dart';

class CategoryRepository {
  final SupabaseClient supabase = GetIt.instance<SupabaseClient>();
  Future<List<Category>> getExpenseCategories() async {
    try{
      final response = await supabase
      .from('categories')
      .select()
      .eq('type', 'expense')
      .order('name', ascending: false, nullsFirst: true);

    return (response as List).map((json) => Category.fromJson(json)).toList();
    } catch(e){
      return categoriesExpLoc;
    }
  }
    
  Future<List<Category>> getIncomeCategories() async {
    try{
      final response = await supabase
      .from('categories')
      .select()
      .eq('type', 'income')
      .order('name', ascending: false, nullsFirst: true);
    return (response as List).map((json) => Category.fromJson(json)).toList();
    } catch(e){
      return categoriesIncLoc;
    }
  }
  final List<Category> categoriesExpLoc = [
    Category(
      id: "550e8400-e29b-41d4-a716-446655440001",
      name: "Food",
      icon: "food",
      type: "expense",
    ),
    Category(
      id: "550e8400-e29b-41d4-a716-446655440002",
      name: "Transport",
      icon: "transport",
      type: "expense",
    ),
    Category(
      id: "550e8400-e29b-41d4-a716-446655440003",
      name: "Entertainment",
      icon: "entertainment",
      type: "expense",
    ),
    Category(
      id: "550e8400-e29b-41d4-a716-446655440004",
      name: "Shopping",
      icon: "shopping",
      type: "expense",
    ),
    Category(
      id: "550e8400-e29b-41d4-a716-446655440005",
      name: "Health",
      icon: "health",
      type: "expense",
    ),
    Category(
      id: "550e8400-e29b-41d4-a716-446655440006",
      name: "Education",
      icon: "education",
      type: "expense",
    ),
    Category(
      id: "550e8400-e29b-41d4-a716-446655440007",
      name: "Bills",
      icon: "bills",
      type: "expense",
    ),
    Category(
      id: "550e8400-e29b-41d4-a716-446655440008",
      name: "Travel",
      icon: "travel",
      type: "expense",
    ),
    Category(
      id: "550e8400-e29b-41d4-a716-446655440009",
      name: "Gifts",
      icon: "gifts",
      type: "expense",
    ),
    Category(
      id: "550e8400-e29b-41d4-a716-446655440010",
      name: "Other Expense",
      icon: "other_expense",
      type: "expense",
    ),
  ];

     List<Category> categoriesIncLoc = [Category(
    id: "550e8400-e29b-41d4-a716-446655440101",
    name: "Salary",
    icon: "salary",
    type: "income",
  ),
  Category(
    id: "550e8400-e29b-41d4-a716-446655440102",
    name: "Business",
    icon: "business",
    type: "income",
  ),
  Category(
    id: "550e8400-e29b-41d4-a716-446655440103",
    name: "Freelance",
    icon: "freelance",
    type: "income",
  ),
  Category(
    id: "550e8400-e29b-41d4-a716-446655440104",
    name: "Investments",
    icon: "investments",
    type: "income",
  ),
  Category(
    id: "550e8400-e29b-41d4-a716-446655440105",
    name: "Gift",
    icon: "gift_income",
    type: "income",
  ),
  Category(
    id: "550e8400-e29b-41d4-a716-446655440106",
    name: "Other Income",
    icon: "other_income",
    type: "income",
  ),
  ];
}
