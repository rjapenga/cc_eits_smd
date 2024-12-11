// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import './models/cc_cart.dart';
import './models/cc_catalog.dart';
import './models/cc_articles.dart';
import './screens/cc_cart.dart';
import './screens/cc_catalog.dart';
import './screens/cc_articles.dart';
import './screens/cc_articles_inherit.dart';
import './screens/cc_articles_no_state_management.dart';
import './screens/counter.dart';

GoRouter router() {
  // router is called at the top of the tree and thous checkbox is only filled once.
  late final List<bool> checkbox;
  checkbox = List.filled(22, false);
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
          routes: [
/*            GoRoute(
              path: 'plan0',
              builder: (context, state) => const CCArticlesNoState(),
            ),*/
            GoRoute(
              path: 'plan',
              builder: (context, state) => const CCArticlesNoStateManagement(),
            ),
            GoRoute(
              path: 'plan_inherited',
              builder: (context, state) =>
                  CCArticlesInherit(checkbox: checkbox),
            ),
            GoRoute(
              path: 'plan_provider',
              builder: (context, state) => const CCArticles(),
            ),
            GoRoute(
              path: 'catalog',
              builder: (context, state) => const MyCatalog(),
              routes: [
                GoRoute(
                  path: 'cart',
                  builder: (context, state) => const MyCart(),
                ),
              ],
            ),
            GoRoute(
              path: 'counter',
              builder: (context, state) => const CounterPage(),
            ),
          ]),
    ],
  );
}

class HomePageButton extends StatelessWidget {
  const HomePageButton({super.key, required this.function, required this.text});
  final void Function() function;
  final String text;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Column(
      children: [
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            style: style,
            onPressed: function,
            // Comment out the call to setState and the button will not update
            child: Text(text, textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final appTheme = ThemeData(
    colorSchemeSeed: Colors.yellow,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Corben',
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: Colors.black,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => ReadCountModel()),
        ChangeNotifierProvider(create: (_) => CheckboxModel()),
      ],
      child: MaterialApp.router(
        title: 'Circuit Cellar Demo',
        theme: appTheme,
        routerConfig: router(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool buttonEn;

  @override
  void initState() {
    buttonEn = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circuit Cellar: Embedded in Thin Slices',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Circuit Cellar: Embedded in Thin Slices'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(),
                children: [
                  const Center(
                    child: Text('State Management Demo',
                        style: TextStyle(fontSize: 24, color: Colors.red)),
                  ),
                  HomePageButton(
                    text: buttonEn
                        ? 'A Subscription: Discontinued'
                        : 'A Subscription: Active',
                    function: () => {
                      setState(
                          () => buttonEn ? buttonEn = false : buttonEn = true)
                    },
                  ),
                  HomePageButton(
                      text: 'Circuit Celler Reading Plan - No State Management',
                      function: () => context.go('/home/plan')),
                  HomePageButton(
                      text: 'Circuit Celler Reading Plan - InheritedWidget',
                      function: () => context.go('/home/plan_inherited')),
                  HomePageButton(
                      text: 'Circuit Celler Reading Plan - Provider',
                      function: () => context.go('/home/plan_provider')),
                  HomePageButton(
                      text: 'Circuit Cellar Catalog of Issues to Buy',
                      function: () => context.go('/home/catalog')),
                  HomePageButton(
                      text: 'Circuit Cellar Simple Counter - using Provider',
                      function: () => context.go('/home/counter')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
