class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>()..add(LoadProducts()),
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: InputDecoration(hintText: 'Search products'),
            onChanged: (v) =>
                context.read<ProductBloc>().add(SearchProducts(v)),
          ),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (_, state) {
            if (state is ProductLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProductLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (_, i) {
                  final p = state.products[i];
                  return ListTile(
                    leading: Image.network(p.image, width: 50),
                    title: Text(p.title),
                    subtitle: Text('\$${p.price}'),
                  );
                },
              );
            }
            return Center(child: Text('Error'));
          },
        ),
      ),
    );
  }
}
