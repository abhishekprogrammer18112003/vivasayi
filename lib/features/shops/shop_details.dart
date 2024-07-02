import 'package:flutter/material.dart';
import 'package:vivasayi/core/utils/custom_spacers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/shops/seed_details.dart';

class ShopDetails extends StatefulWidget {
  const ShopDetails({super.key});

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Shop Name",
              style: TextStyle(fontSize: 25.w, fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
                const Icon(Icons.add),
                CustomSpacers.width16,
                const Icon(
                  Icons.delete,
                  color: Colors.red,
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
        child: _fruitsDetails(),
      ),
    );
  }

  Widget _fruitsDetails() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 10 / 13,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 201, 201, 201),
                    width: 1.w),
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 173.h, // Adjust the height as needed
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/peas.png'), // Background image
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.w)),
                          child: IconButton(
                            icon: const Icon(Icons.bookmark),
                            color: const Color.fromARGB(255, 26, 180, 3),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomSpacers.height4,
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: const Text(
                      'Fruit Name',
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
                          '₹ 250/Kg',
                          style: TextStyle(
                            fontSize: 20.w,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_box),
                        color: Colors.green,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SeedDetails(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
}
