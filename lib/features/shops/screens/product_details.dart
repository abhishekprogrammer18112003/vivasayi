import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/loaded_widget.dart';
import 'package:vivasayi/core/utils/custom_spacers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/shops/data/shops_provider.dart';
import 'package:vivasayi/features/shops/screens/edit_products.dart';
import 'package:vivasayi/ui/atoms/loader_widget.dart';
import 'package:vivasayi/ui/molecules/custom_button.dart';

class ProductDetails extends StatefulWidget {
  dynamic shop;
  dynamic data;
  List<dynamic> relatedProd;
  ProductDetails(
      {super.key,
      required this.data,
      required this.relatedProd,
      required this.shop});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int count = 1;

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
                  "Details",
                  style: TextStyle(fontSize: 25.w, fontWeight: FontWeight.w400),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProductsScreen(
                                      shopName: widget.data['shopName'],
                                      shopCategory: widget.data['shopCategory'],
                                      data: widget.data,
                                    )));
                        // await value.deleteProduct(widget.data['productName']);
                        // OverlayManager.showToast(
                        //     type: ToastType.Success,
                        //     msg: "Product Deleted Successfully !");
                        // Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.amber,
                      ),
                    ),
                    CustomSpacers.width16,
                    InkWell(
                      onTap: () async {
                        await value.deleteProduct(widget.data['productName']);
                        OverlayManager.showToast(
                            type: ToastType.Success,
                            msg: "Product Deleted Successfully !");
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    CustomSpacers.width16,
                    const Icon(
                      Icons.add_shopping_cart,
                      color: Color.fromARGB(255, 2, 167, 7),
                    ),
                    CustomSpacers.width16,
                  ],
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 187.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            widget.data['image_url']), // Background image
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                  ),
                  CustomSpacers.height20,
                  Text(
                    widget.data['productName'],
                    style:
                        TextStyle(fontSize: 22.w, fontWeight: FontWeight.w500),
                  ),
                  CustomSpacers.height2,
                  _ratingAndStock(),
                  CustomSpacers.height10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Text(
                              'Total : ',
                              style: TextStyle(
                                  fontSize: 20.w, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              height: 40.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '₹ ${int.parse(widget.data['price']) * count}',
                                      style: TextStyle(
                                          fontSize: 16.w,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Color.fromARGB(255, 26, 180, 3),
                              ),
                              onPressed: () {
                                if (count > 1) {
                                  setState(() {
                                    count--;
                                  });
                                }
                              },
                            ),
                            Text(
                              '$count',
                              style: TextStyle(
                                  fontSize: 20.w, fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add_circle,
                                color: Color.fromARGB(255, 26, 180, 3),
                              ),
                              onPressed: () {
                                setState(() {
                                  count++;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  CustomSpacers.height20,
                  Text(
                    'Description',
                    style:
                        TextStyle(fontSize: 22.w, fontWeight: FontWeight.w500),
                  ),
                  CustomSpacers.height16,
                  Container(
                    child: Text(
                      widget.data['description'],
                      style: TextStyle(
                          fontSize: 20.w, fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomSpacers.height30,
                  Text(
                    'Related Products',
                    style:
                        TextStyle(fontSize: 20.w, fontWeight: FontWeight.w500),
                  ),
                  CustomSpacers.height20,
                  _listViewIcons(),
                  CustomSpacers.height60,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        strButtonText: "Call Now",
                        buttonAction: () {
                          _makePhoneCall(widget.shop['phone']);
                        },
                        dHeight: 69.h,
                        dWidth: 175.w,
                        bgColor: Colors.green,
                        dCornerRadius: 12,
                      ),
                      CustomButton(
                        strButtonText: "Whatsapp",
                        buttonAction: () {},
                        dHeight: 69.h,
                        dWidth: 175.w,
                        bgColor: Colors.green,
                        dCornerRadius: 12,
                      ),
                    ],
                  ),
                  CustomSpacers.height40,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  _coloredContainer(String img) => Container(
      height: 80.h,
      width: 100.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(img), // Background image
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10.w),
      ));

  _listViewIcons() => Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Container(
          height: 80.h,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.relatedProd.length,
              itemBuilder: (context, index) {
                return _coloredContainer(
                    widget.relatedProd[index]['image_url']);
              }),
        ),
      );

  _ratingAndStock() => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available in Stock',
                  style: TextStyle(
                      fontSize: 16.w,
                      fontWeight: FontWeight.w600,
                      color: Colors.green),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Text(
                '₹ ' + widget.data['price'], // Replace with your actual price
                style: TextStyle(fontSize: 22.w, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      );
}
