// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivasayi/core/constants/value_constants.dart';
import 'package:vivasayi/core/loaded_widget.dart';
import 'package:vivasayi/core/utils/custom_spacers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/shops/data/shops_provider.dart';
import 'package:vivasayi/features/shops/screens/add_shops.dart';
import 'package:vivasayi/features/shops/screens/edit_shop_screen.dart';
import 'package:vivasayi/features/shops/screens/product_details.dart';
import 'package:vivasayi/ui/atoms/loader_widget.dart';

class ProductScreen extends StatefulWidget {
  String shopCategory;
  dynamic shop;

  String shopName;
  ProductScreen(
      {super.key,
      required this.shopName,
      required this.shopCategory,
      required this.shop});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<ShopsProvider>(context, listen: false)
          .fetchProducts(widget.shopName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopsProvider>(
      builder: (context, value, child) => LoaderWidget(
        isLoading: value.isLoading,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new), // Custom arrow icon
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.shopName,
                  style: TextStyle(fontSize: 25.w, fontWeight: FontWeight.w400),
                ),
                CustomSpacers.width16,
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle Create Shop action
                        // Navigate to ShopScreen
                        // Close the dialog
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddShopScreen(
                                    shopName: widget.shopName,
                                    shopCategory: widget.shopCategory,
                                  )),
                        );
                      },
                      child: const Icon(Icons.add),
                    ),
                    CustomSpacers.width10,
                    InkWell(
                      onTap: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditShopScreen(shop: widget.shop)));
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.amber,
                      ),
                    ),
                    CustomSpacers.width10,
                    InkWell(
                      onTap: () async {
                        await value.deleteShop(widget.shopName);
                        OverlayManager.showToast(
                            type: ToastType.Success,
                            msg: "Shops Deleted Successfully !");
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    CustomSpacers.width10,
                    const Icon(
                      Icons.add_shopping_cart,
                      color: Color.fromARGB(255, 2, 167, 7),
                    ),
                    CustomSpacers.width10,
                  ],
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: _fruitsDetails(),
          ),
        ),
      ),
    );
  }

  Widget _fruitsDetails() => Consumer<ShopsProvider>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: value.productList.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 10 / 13,
                  ),
                  itemCount: value.productList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                shop : widget.shop,
                                    data: value.productList[index],
                                    relatedProd: value.productList,
                                  )),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 201, 201, 201),
                              width: 1.w),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 173.h, // Adjust the height as needed
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(value
                                              .productList[index]
                                          ['image_url']), // Background image
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(8.w),
                                  ),
                                ),
                              ],
                            ),
                            CustomSpacers.height4,
                            Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: Text(
                                value.productList[index]['productName'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Text(
                                    '₹ ${value.productList[index]['price']}',
                                    style: TextStyle(
                                      fontSize: 20.w,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_box),
                                  color: Colors.green,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text('No products listed under this shop !'),
                  ),
                ),
        ),
      );
}
