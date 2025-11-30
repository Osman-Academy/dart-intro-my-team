import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _requested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_requested) {
      _requested = true;
      final auth = context.read<AuthProvider>();
      if (auth.user == null && (auth.token?.isNotEmpty ?? false)) {
        auth.refreshUser();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.user;
    final isLoading = auth.status == AuthStatus.authenticating || (user == null && (auth.token?.isNotEmpty ?? false));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (r) => false);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthProvider>().logout();
              if (!context.mounted) return;
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: user == null
                  ? const Center(child: Text('Нет данных пользователя'))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundImage: user.image.isNotEmpty ? NetworkImage(user.image) : null,
                              child: user.image.isEmpty ? const Icon(Icons.person) : null,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.name, style: Theme.of(context).textTheme.titleMedium),
                                Text(user.email),
                                Text('@${user.username}'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text('Имя: ${user.firstName}'),
                        Text('Фамилия: ${user.lastName}'),
                        Text('Пол: ${user.gender}'),
                      ],
                    ),
            ),
    );
  }
}
