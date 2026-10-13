import 'package:flutter/material.dart';

import '../main.dart';
import '../models/product.dart';
import '../widgets/empty_state.dart';
import '../widgets/product_cart.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String query = '';
  String category = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ShopScope.of(context).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final shop = ShopScope.of(context);

    final filtered = shop.products.where((product) {
      final matchesName = product.name.toLowerCase().contains(
        query.toLowerCase(),
      );
      final matchesCategory =
          category == 'All' ||
          (category == 'Fruits' && product.category == ProductCategory.fruit) ||
          (category == 'Vegetables' &&
              product.category == ProductCategory.vegetable);

      return matchesName && matchesCategory;
    }).toList();

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => shop.loadProducts(refresh: true),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 4),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Fruits & Vegetables',
                            style: TextStyle(
                              fontSize: 28,
                              color: kInk,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (filtered.isNotEmpty && query.isEmpty && category == 'All')
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: kGreen.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${filtered.length} items',
                              style: const TextStyle(
                                fontSize: 12,
                                color: kGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 12),
                    child: TextField(
                      onChanged: (value) => setState(() => query = value),
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        hintStyle: TextStyle(color: kInk.withValues(alpha: 0.4)),
                        prefixIcon: Icon(Icons.search_rounded, color: kInk.withValues(alpha: 0.5)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: kGreen, width: 2),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        _CategoryChip(
                          label: 'All',
                          icon: Icons.shopping_basket_rounded,
                          selected: category == 'All',
                          onTap: () => setState(() => category = 'All'),
                        ),
                        const SizedBox(width: 8),
                        _CategoryChip(
                          label: 'Fruits',
                          icon: Icons.apple_rounded,
                          selected: category == 'Fruits',
                          onTap: () => setState(() => category = 'Fruits'),
                        ),
                        const SizedBox(width: 8),
                        _CategoryChip(
                          label: 'Vegetables',
                          icon: Icons.eco_rounded,
                          selected: category == 'Vegetables',
                          onTap: () => setState(() => category = 'Vegetables'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            if (shop.isLoading && !shop.hasLoaded)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (shop.error != null && filtered.isEmpty)
              SliverFillRemaining(
                child: EmptyState(
                  icon: Icons.cloud_off_rounded,
                  title: 'Unable to Load',
                  message: shop.error!,
                  actionLabel: 'Retry',
                  onAction: () => shop.loadProducts(refresh: true),
                ),
              )
            else if (filtered.isEmpty)
              SliverFillRemaining(
                child: EmptyState(
                  icon: query.isNotEmpty ? Icons.search_off_rounded : Icons.eco_outlined,
                  title: query.isNotEmpty ? 'No Results Found' : 'No Products Available',
                  message: query.isNotEmpty
                      ? 'Try adjusting your search or filter'
                      : 'No products match the selected category',
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.all(18),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = filtered[index];
                      return ProductCard(
                        product: product,
                        onAdd: () {
                          shop.addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.name} added to cart'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    childCount: filtered.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: selected ? Colors.white : kGreen,
          ),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: kGreen,
      labelStyle: TextStyle(
        color: selected ? Colors.white : kInk,
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide(
        color: selected ? kGreen : kGreen.withValues(alpha: 0.3),
      ),
      backgroundColor: kLightGreen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    );
  }
}
