import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../bloc/user_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserBloc>()..add(const UserEvent.load()),
      child: Scaffold(
        appBar: AppBar(title: const Text('User Search')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  context
                      .read<UserBloc>()
                      .add(UserEvent.search(value));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (_, state) {
                  return state.when(
                    initial: () => const SizedBox(),
                    loaded: (users) => ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (_, i) => ListTile(
                        title: Text(users[i].name),
                        subtitle: Text(users[i].email),
                      ),
                    ),
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
