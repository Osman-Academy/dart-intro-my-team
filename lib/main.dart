import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Team Manager',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class User {
  final int id;
  String name;
  String email;
  String phone;
  String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<User> _users = [
    User(
        id: 1,
        name: 'Alice Johnson',
        email: 'alice@example.com',
        phone: '+1 555 0101',
        role: 'Designer'),
    User(
        id: 2,
        name: 'Bob Smith',
        email: 'bob@example.com',
        phone: '+1 555 0102',
        role: 'Developer'),
    User(
        id: 3,
        name: 'Carlos Rodriguez',
        email: 'carlos@example.com',
        phone: '+1 555 0103',
        role: 'Product'),
  ];

  String _query = '';

  List<User> get _filteredUsers {
    if (_query.isEmpty) return _users;
    final q = _query.toLowerCase();
    return _users
        .where((u) =>
            u.name.toLowerCase().contains(q) ||
            u.email.toLowerCase().contains(q) ||
            u.role.toLowerCase().contains(q))
        .toList();
  }

  void _openAddUserSheet({User? user}) {
    final isEditing = user != null;
    final nameCtl = TextEditingController(text: user?.name ?? '');
    final emailCtl = TextEditingController(text: user?.email ?? '');
    final phoneCtl = TextEditingController(text: user?.phone ?? '');
    final roleCtl = TextEditingController(text: user?.role ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(isEditing ? 'Edit user' : 'Add user',
                        style: Theme.of(context).textTheme.titleLarge),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                    controller: nameCtl,
                    decoration: const InputDecoration(labelText: 'Full name')),
                const SizedBox(height: 8),
                TextField(
                    controller: emailCtl,
                    decoration: const InputDecoration(labelText: 'Email')),
                const SizedBox(height: 8),
                TextField(
                    controller: phoneCtl,
                    decoration: const InputDecoration(labelText: 'Phone')),
                const SizedBox(height: 8),
                TextField(
                    controller: roleCtl,
                    decoration: const InputDecoration(labelText: 'Role')),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        icon: const Icon(Icons.save_as),
                        label: Text(isEditing ? 'Save' : 'Add'),
                        onPressed: () {
                          final name = nameCtl.text.trim();
                          final email = emailCtl.text.trim();
                          final phone = phoneCtl.text.trim();
                          final role = roleCtl.text.trim();
                          if (name.isEmpty) return; // simple validation

                          setState(() {
                            if (isEditing) {
                              user!.name = name;
                              user.email = email;
                              user.phone = phone;
                              user.role = role;
                            } else {
                              _users.add(User(
                                id: DateTime.now().millisecondsSinceEpoch,
                                name: name,
                                email: email,
                                phone: phone,
                                role: role,
                              ));
                            }
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showUserDetails(User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${user.email}'),
            const SizedBox(height: 6),
            Text('Phone: ${user.phone}'),
            const SizedBox(height: 6),
            Text('Role: ${user.role}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _openAddUserSheet(user: user);
            },
            child: const Text('Edit'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _users.removeWhere((u) => u.id == user.id));
              Navigator.of(context).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Team Manager'),
        elevation: 0,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFE8EEFF), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search by name, email, or role',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _filteredUsers.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.search_off,
                                size: 64, color: Colors.indigoAccent),
                            const SizedBox(height: 8),
                            Text('No users found',
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredUsers.length,
                        itemBuilder: (context, index) {
                          final user = _filteredUsers[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.indigo.shade300,
                                child: Text(_initials(user.name),
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                              title: Text(user.name),
                              subtitle: Text('${user.role} • ${user.email}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.more_vert),
                                onPressed: () => _showUserDetails(user),
                              ),
                              onTap: () => _showUserDetails(user),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add user'),
        icon: const Icon(Icons.person_add),
        onPressed: () => _openAddUserSheet(),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.split(' ');
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}
