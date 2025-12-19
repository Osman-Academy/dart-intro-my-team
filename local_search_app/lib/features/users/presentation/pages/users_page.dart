import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserBloc>()..add(const UserEvent.search('')),
      child: Scaffold(
        appBar: AppBar(title: const Text('Local Search')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                onChanged: (v) =>
                    context.read<UserBloc>().add(UserEvent.search(v)),
                decoration: const InputDecoration(
                  hintText: 'Search user',
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (_, i) =>
                        ListTile(title: Text(state.users[i].name)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
