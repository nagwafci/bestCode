import 'package:bestcode2023/providers/coupon_provider.dart';
import 'package:bestcode2023/widgets/code_box.dart';
import 'package:bestcode2023/widgets/subtitle_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/inner_screens/product_details.dart';
import 'dialog_container.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.productId,
  });

  final String productId;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    // final productModelProvider = Provider.of<ProductModel>(context);
    final productProvider = Provider.of<CouponProvider>(context);
    final getCurrProduct = productProvider.findByProdId(widget.productId);
    Size size = MediaQuery.of(context).size;
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  ProductDetails.routName,
                  arguments: getCurrProduct.couponId,
                );
              },
              child: Container(
                height: size.height * 0.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 25,
                        color: Colors.black12),
                  ],
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      // borderRadius: BorderRadius.circular(30.0),
                      child: FancyShimmerImage(
                        imageUrl: getCurrProduct.couponImage,
                        width: size.width * 0.33,
                        height: size.height * 0.11,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return MyDialog(
                                    title: getCurrProduct.couponTitle,
                                    code: getCurrProduct.couponCode);
                              });
                        },
                        child: CodeBox(
                          code: getCurrProduct.couponCode,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SubtitleTextWidget(
                      label: getCurrProduct.couponTitle,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
