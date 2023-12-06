import 'package:bestcode2023/widgets/custom_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../services/assets_manager.dart';
import '../services/my_app_method.dart';
import '../widgets/app_name_text.dart';
import '../widgets/subtitle_text.dart';
import '../widgets/title_text.dart';
import 'auth/login.dart';
import 'inner_screens/wishlist.dart';
import 'loading_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  User? user = FirebaseAuth.instance.currentUser;
  bool _isLoading = true;
  UserModel? userModel;

  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      await MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "An error has been occured $error",
        fct: () {},
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const AppNameTextWidget(fontSize: 20),
        ),
        body: LoadingManager(
          isLoading: _isLoading,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: user == null ? true : false,
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TitlesTextWidget(
                        label: "Please login to have ultimate access"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                userModel == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            userModel?.userImage != null
                                ? Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).cardColor,
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            width: 3),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            userModel!.userImage,
                                          ),
                                          fit: BoxFit.fill,
                                        )),
                                  )
                                : const FittedBox(
                                    fit: BoxFit.fill,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.black38,
                                    ),
                                  ),
                            const SizedBox(
                              width: 7,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitlesTextWidget(label: userModel!.userName),
                                SubtitleTextWidget(
                                  label: userModel!.userEmail,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 7,
                      ),
                      const TitlesTextWidget(label: "General"),
                      user == null
                          ? const SizedBox.shrink()
                          : CustomListTile(
                              imagePath: AssetsManager.wishlistSvg,
                              text: "Wishlist",
                              function: () async {
                                await Navigator.pushNamed(
                                  context,
                                  WishlistScreen.routName,
                                );
                              },
                            ),
                      const Divider(
                        thickness: 1,
                      ),
                      const TitlesTextWidget(label: "Settings"),
                      const SizedBox(
                        height: 7,
                      ),
                      SwitchListTile(
                        secondary: Image.asset(
                          AssetsManager.theme,
                          height: 30,
                        ),
                        title: Text(themeProvider.getIsDarkTheme
                            ? "Dark mode"
                            : "Light mode"),
                        value: themeProvider.getIsDarkTheme,
                        onChanged: (value) {
                          themeProvider.setDarkTheme(themeValue: value);
                        },
                      ),
                      Visibility(
                        visible: user != null ? true : false,
                        child: CustomListTile(
                          imagePath: AssetsManager.orderBag,
                          text: "Delete Account",
                          function: () async {
                            await MyAppMethods.showErrorORWarningDialog(
                              context: context,
                              subtitle: "Are you sure?",
                              fct: () async {
                                await FirebaseAuth.instance.currentUser
                                    ?.delete();
                                if (!mounted) return;
                                await Navigator.pushNamed(
                                  context,
                                  LoginScreen.routName,
                                );
                              },
                              isError: false,
                            );
                          },
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                    ),
                    icon: Icon(user == null ? Icons.login : Icons.logout),
                    label: Text(
                      user == null ? "Login" : "Logout",
                    ),
                    onPressed: () async {
                      if (user == null) {
                        await Navigator.pushNamed(
                          context,
                          LoginScreen.routName,
                        );
                      } else {
                        await MyAppMethods.showErrorORWarningDialog(
                          context: context,
                          subtitle: "Are you sure?",
                          fct: () async {
                            await FirebaseAuth.instance.signOut();
                            if (!mounted) return;
                            await Navigator.pushNamed(
                              context,
                              LoginScreen.routName,
                            );
                          },
                          isError: false,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
