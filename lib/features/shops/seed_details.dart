import 'package:flutter/material.dart';
import 'package:vivasayi/core/utils/custom_spacers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/ui/molecules/custom_button.dart';

class SeedDetails extends StatefulWidget {
  const SeedDetails({super.key});

  @override
  State<SeedDetails> createState() => _SeedDetailsState();
}

class _SeedDetailsState extends State<SeedDetails> {
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
              "Details",
              style: TextStyle(fontSize: 25.w, fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
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
        child: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 187.h,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/lemon.png'), // Background image
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12.w),
                ),
              ),
              CustomSpacers.height20,
              Text(
                'Lime Seedlings',
                style: TextStyle(fontSize: 22.w, fontWeight: FontWeight.w500),
              ),
              CustomSpacers.height2,
              _ratingAndStock(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Color.fromARGB(255, 26, 180, 3),
                    ),
                    onPressed: () {
                      // Handle decrement logic
                    },
                  ),
                  Text(
                    '1pcs',
                    style:
                        TextStyle(fontSize: 20.w, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle,
                      color: Color.fromARGB(255, 26, 180, 3),
                    ),
                    onPressed: () {
                      // Handle increment logic
                    },
                  ),
                ],
              ),
              CustomSpacers.height20,
              Text(
                'Related Products',
                style: TextStyle(fontSize: 22.w, fontWeight: FontWeight.w500),
              ),
              CustomSpacers.height16,
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 20.w,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  children: [
                    const TextSpan(
                      text:
                          'Limes are closely related to lemons. They even look similar to them. Lime tree harvest is easier when you are familiar with the different types of lemon trees and what... ',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: 'Read more',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w400,
                        fontSize: 20.w,
                      ),
                      // Add your onTap function here
                    ),
                  ],
                ),
              ),
              CustomSpacers.height20,
              Text(
                'Description',
                style: TextStyle(fontSize: 20.w, fontWeight: FontWeight.w500),
              ),
              CustomSpacers.height20,
              _listViewIcons(),
              CustomSpacers.height60,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    strButtonText: "Call Now",
                    buttonAction: () {},
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
    );
  }

  _coloredContainer() => Container(
      height: 80.h,
      width: 80.w,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/tomato.png'), // Background image
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10.w),
      ));

  _listViewIcons() => Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              _coloredContainer(),
              _coloredContainer(),
              _coloredContainer(),
              _coloredContainer(),
              _coloredContainer(),
              _coloredContainer(),
            ],
          ),
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
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 24.w,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '4.5(209)', // Replace with your actual rating value
                      style: TextStyle(fontSize: 20.w),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Text(
                '₹ 250/pcs', // Replace with your actual price
                style: TextStyle(fontSize: 22.w, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      );
}
