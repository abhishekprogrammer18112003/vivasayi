import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/ui/molecules/custom_button.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final List<String> shopCategories = [
    'Clothing',
    'Electronics',
    'Groceries',
    'Home Decor',
  ];

  final Map<String, bool> selectedCategories = {};

  @override
  void initState() {
    super.initState();

    for (var category in shopCategories) {
      selectedCategories[category] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Photo with Edit Icon
            CustomSpacers.height40,
            Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'assets/nuts.png'), // Replace with your image asset
                ),
                Positioned(
                  top: 50,
                  left: 50,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 153, 0),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        size: 28.w,
                      ),
                      onPressed: () {
                        // Handle profile photo edit action
                      },
                    ),
                  ),
                ),
              ],
            ),
            CustomSpacers.height40,

            const TextField(
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Shop Name',
              ),
            ),
            CustomSpacers.height26,
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Country',
                      prefixText: '+',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                CustomSpacers.width10,
                const Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            CustomSpacers.height26,

            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Country',
                      prefixText: '+',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                CustomSpacers.width10,
                const Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Whatsapp Number',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            CustomSpacers.height26,

            const TextField(
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select Your location',
              ),
            ),
            // Select Shop Category
            CustomSpacers.height26,

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select Shop Category',
                style: TextStyle(fontSize: 18.w, fontWeight: FontWeight.bold),
              ),
            ),

            Expanded(
              child: ListView(
                children: shopCategories.map((category) {
                  return CheckboxListTile(
                    title: Text(category),
                    value: selectedCategories[category],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedCategories[category] = value ?? false;
                      });
                    },
                  );
                }).toList(),
              ),
            ),

            CustomButton(
              strButtonText: 'Submit',
              buttonAction: () {},
              dHeight: 69.h,
              dWidth: 369.w,
              bgColor: Colors.green,
              dCornerRadius: 12.w,
            ),
          ],
        ),
      ),
    );
  }
}
