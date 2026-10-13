import 'package:flutter/material.dart';

import 'models/product.dart';
import 'models/cart_item.dart';
import 'models/shop_order.dart';
import 'services/product_services.dart';
import 'pages/home_page.dart';
import 'pages/product_page.dart';
import 'pages/cart_page.dart';
import 'pages/order_page.dart';
import 'pages/profile_page.dart';

const kGreen = Color(0xFF237A3B);
const kLightGreen = Color(0xFFEAF6E8);
const kInk = Color(0xFF183323);

void main() {
  runApp(const FreshBasketApp());
}

class FreshBasketApp extends StatefulWidget {
  const FreshBasketApp({super.key});

  @override
  State<FreshBasketApp> createState() => _FreshBasketAppState();
}

class _FreshBasketAppState extends State<FreshBasketApp> {
  late final ShopController shop;

  @override
  void initState() {
    super.initState();
    shop = ShopController(ProductService());
  }

  @override
  void dispose() {
    shop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShopScope(
      controller: shop,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fresh Basket',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: kGreen),
          scaffoldBackgroundColor: const Color(0xFFF8FBF7),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF8FBF7),
            foregroundColor: kInk,
            elevation: 0,
          ),
        ),
        home: const MainNavigationPage(),
      ),
    );
  }
}

class ShopController extends ChangeNotifier {
  ShopController(this.service);

  final ProductService service;

  List<Product> products = Product.samples;
  final List<CartItem> cart = [];
  final List<ShopOrder> orders = [];

  bool isLoading = false;
  bool hasLoaded = false;
  String? error;

  int get cartCount => cart.fold(0, (sum, item) => sum + item.quantity);

  double get cartTotal => cart.fold(0, (sum, item) => sum + item.total);

  Future<void> loadProducts({bool refresh = false}) async {
    if (isLoading || (hasLoaded && !refresh)) return;

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final fruits = await service.fetchProducts();
      final vegetables = Product.samples
          .where((p) => p.category == ProductCategory.vegetable)
          .toList();

      products = [...fruits, ...vegetables];
      hasLoaded = true;
    } catch (_) {
      products = Product.samples;
      error = 'API unavailable. Showing sample products.';
      hasLoaded = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void addToCart(Product product) {
    final index = cart.indexWhere((item) => item.product.id == product.id);

    if (index == -1) {
      cart.add(CartItem(product: product));
    } else {
      cart[index].quantity++;
    }

    notifyListeners();
  }

  void increase(Product product) {
    final index = cart.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      cart[index].quantity++;
      notifyListeners();
    }
  }

  void decrease(Product product) {
    final index = cart.indexWhere((item) => item.product.id == product.id);

    if (index < 0) return;

    if (cart[index].quantity > 1) {
      cart[index].quantity--;
    } else {
      cart.removeAt(index);
    }

    notifyListeners();
  }

  void remove(Product product) {
    cart.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  ShopOrder? checkout(PaymentMethod method) {
    if (cart.isEmpty) return null;

    final order = ShopOrder(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      items: cart
          .map(
            (item) => CartItem(product: item.product, quantity: item.quantity),
          )
          .toList(),
      total: cartTotal,
      paymentMethod: method,
    );

    orders.insert(0, order);
    cart.clear();
    notifyListeners();
    return order;
  }

  void deleteOrder(String id) {
    orders.removeWhere((order) => order.id == id);
    notifyListeners();
  }
}

class ShopScope extends InheritedWidget {
  const ShopScope({super.key, required this.controller, required super.child});

  final ShopController controller;

  static ShopController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ShopScope>();
    assert(scope != null, 'ShopScope not found');
    return scope!.controller;
  }

  @override
  bool updateShouldNotify(ShopScope oldWidget) =>
      controller != oldWidget.controller;
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final shop = ShopScope.of(context);

    return AnimatedBuilder(
      animation: shop,
      builder: (context, _) => Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: [
            HomePage(),
            ProductsPage(),
            CartPage(),
            OrdersPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() => selectedIndex = index);
          },
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            const NavigationDestination(
              icon: Icon(Icons.eco_rounded),
              label: 'Products',
            ),
            NavigationDestination(
              icon: Badge(
                label: Text('${shop.cartCount}'),
                isLabelVisible: shop.cartCount > 0,
                child: const Icon(Icons.shopping_cart_rounded),
              ),
              label: 'Cart',
            ),
            const NavigationDestination(
              icon: Icon(Icons.receipt_long_rounded),
              label: 'Orders',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
