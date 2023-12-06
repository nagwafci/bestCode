import 'package:bestcode2023/providers/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/search_screen.dart';

class StoreImgWidget extends StatelessWidget {
  const StoreImgWidget({
    super.key,
    required this.name,
  });

  final String name;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final storeProvider = Provider.of<StoreProvider>(context);
    final getCurrentStore = storeProvider.findByName(name);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          SearchScreen.routeName,
          arguments: name,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: size.width * 0.3,
          height: size.height * 0.1,
          decoration: BoxDecoration(
            //  borderRadius: BorderRadius.circular(11),
            border: Border.all(color: Colors.black26),
            image: DecorationImage(
              image: NetworkImage(getCurrentStore!.image),
              fit: BoxFit.fill,
            ),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 10), blurRadius: 25, color: Colors.black12),
            ],
          ),
        ),
      ),
    );
  }
}
