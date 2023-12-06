import 'package:bestcode2023/consts/theme_data.dart';
import 'package:bestcode2023/providers/store_provider.dart';
import 'package:bestcode2023/root_screen.dart';
import 'package:bestcode2023/screens/auth/forgot_password.dart';
import 'package:bestcode2023/screens/auth/login.dart';
import 'package:bestcode2023/screens/auth/register.dart';
import 'package:bestcode2023/screens/inner_screens/product_details.dart';
import 'package:bestcode2023/screens/inner_screens/wishlist.dart';
import 'package:bestcode2023/screens/search_screen.dart';
import 'package:bestcode2023/screens/splash_screen.dart';
import 'package:bestcode2023/providers/coupon_provider.dart';
import 'package:bestcode2023/providers/theme_provider.dart';
import 'package:bestcode2023/providers/user_provider.dart';
import 'package:bestcode2023/providers/wishlist_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  // runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CouponProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StoreProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (
        context,
        themeProvider,
        child,
      ) {
        return MaterialApp(
          title: 'BestCode',
          debugShowCheckedModeBanner: false,
          //  builder: DevicePreview.appBuilder,
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          home: const SplashScreen(),
          routes: {
            ProductDetails.routName: (context) => const ProductDetails(),
            WishlistScreen.routName: (context) => const WishlistScreen(),
            RegisterScreen.routName: (context) => const RegisterScreen(),
            LoginScreen.routName: (context) => const LoginScreen(),
            ForgotPasswordScreen.routeName: (context) =>
                const ForgotPasswordScreen(),
            SearchScreen.routeName: (context) => const SearchScreen(),
            RootScreen.routName: (context) => const RootScreen(),
          },
        );
      }),
    );
  }
}
