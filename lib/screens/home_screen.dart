import 'package:bestcode2023/providers/coupon_provider.dart';
import 'package:bestcode2023/providers/store_provider.dart';
import 'package:bestcode2023/widgets/product_widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../consts/app_constants.dart';
import '../widgets/app_name_text.dart';
import '../widgets/store_img_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<CouponProvider>(context);
    final storeProvider = Provider.of<StoreProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.24,
              child: ClipRRect(
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      AppConstants.bannersImages[index],
                      fit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: AppConstants.bannersImages.length,
                  pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: size.height * 0.1,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: storeProvider.getProducts.length < 10
                      ? storeProvider.getProducts.length
                      : 10,
                  itemBuilder: (context, index) {
                    return StoreImgWidget(
                      name: AppConstants.categoriesList[index].name,
                    );
                  }),
            ),
            SizedBox(height: 10),
            Expanded(
              child: DynamicHeightGridView(
                itemCount: productProvider.getProducts.length,
                builder: ((context, index) {
                  return ProductWidget(
                    productId: productProvider.getProducts[index].couponId,
                  );
                }),
                crossAxisCount: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
