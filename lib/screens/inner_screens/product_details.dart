import 'package:bestcode2023/providers/coupon_provider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_name_text.dart';
import '../../widgets/dialog_container.dart';
import '../../widgets/heart_btn.dart';
import '../../widgets/subtitle_text.dart';
import '../../widgets/title_text.dart';

class ProductDetails extends StatefulWidget {
  static const routName = '/ProductDetails';
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final productProvider =Provider.of<CouponProvider>(context, listen: false);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrProduct = productProvider.findByProdId(productId);

    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(fontSize: 20),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            )),
        // automaticallyImplyLeading: false,
      ),
      body: getCurrProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
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
                      height: size.height * 0.28,
                      child: Column(
                        children: [
                          FancyShimmerImage(
                            imageUrl: getCurrProduct.couponImage,
                            height: size.height * 0.20,
                            width: double.infinity,
                            boxFit: BoxFit.contain,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          HeartButtonWidget(
                            storeName: getCurrProduct.couponStore,
                           // color: Colors.blue.shade300,
                          ),
                        ],
                      ),


                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
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
                          const TitlesTextWidget(label: "About this item",color: Colors.black,),
                          const SizedBox(
                            height: 10,
                          ),

                          Text(
                            getCurrProduct.couponTitle,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap:(){
                              showDialog(context: context, builder:(context){
                                return MyDialog(title: getCurrProduct.couponTitle, code: getCurrProduct.couponCode);
                              });

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                // color: AppColors.darkScaffoldColor,
                                border: Border.all(width: 1,color: Colors.black26),
                              ),
                              child: TitlesTextWidget(
                                label: getCurrProduct.couponCode,
                                maxLines: 2,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SubtitleTextWidget(
                            label: getCurrProduct.couponDescription,color: Colors.black
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
