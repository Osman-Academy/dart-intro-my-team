import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _handleCheckout(BuildContext context) async {
    final auth = context.read<AuthProvider>();
    final cart = context.read<CartProvider>();

    if (!auth.isAuthenticated) {
      // Отправляем на логин, а потом возвращаемся в корзину
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(redirectRoute: '/cart'),
        ),
      );

      // После возврата проверяем, авторизовался ли пользователь
      if (!auth.isAuthenticated) {
        return;
      }
    }

    cart.clear();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заказ оформлен')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items;
    final isWide = MediaQuery.of(context).size.width >= 700;

    Widget list = ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, i) {
        final it = items[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(it.product.imageUrl),
              onBackgroundImageError: (_, __) {},
            ),
            title: Text(it.product.name),
            subtitle: Text(
              '${it.product.price.toStringAsFixed(2)} x ${it.qty} = \\${(it.product.price * it.qty).toStringAsFixed(2)}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    if (it.qty > 1) {
                      it.qty -= 1;
                      cart.remove(it.product.id);
                      cart.add(it.product);
                    } else {
                      cart.remove(it.product.id);
                    }
                  },
                ),
                Text('${it.qty}'),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () => cart.add(it.product),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => cart.remove(it.product.id),
                ),
              ],
            ),
          ),
        );
      },
    );

    Widget summary = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Итого: \$${cart.total.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _handleCheckout(context),
            child: const Text('Оформить заказ'),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Cart'), actions: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (r) => false);
          },
        ),
      ]),
      body: items.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : isWide
              ? Row(
                  children: [
                    Expanded(child: list),
                    SizedBox(
                      width: 300,
                      child: summary,
                    ),
                  ],
                )
              : Column(
                  children: [
                    Expanded(child: list),
                    summary,
                  ],
                ),
    );
  }
}
