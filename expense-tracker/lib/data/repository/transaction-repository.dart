import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/transaction.dart';
import 'package:get_it/get_it.dart';

class TransactionRepository {
  final SupabaseClient supabase = GetIt.instance<SupabaseClient>();

  Future<void> addTransaction(Transaction transaction) async {
    await supabase.from('transactions').insert(transaction.toJson());
  }

  Future<List<Map<String, dynamic>>> getTransactions({
    required String userId,
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      final response = await supabase
          .from('transactions')
          .select()
          .eq('user_id', userId)
          .gte('created_at', start.toIso8601String())
          .lte('created_at', end.toIso8601String())
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return List.empty();
    }
  }

}