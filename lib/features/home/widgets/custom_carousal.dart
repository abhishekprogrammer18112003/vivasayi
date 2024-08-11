import 'package:vivasayi/core/app_imports.dart';

class CarouselWithController extends StatefulWidget {
  const CarouselWithController({super.key});

  @override
  State<CarouselWithController> createState() => _CarouselWithControllerState();
}

class _CarouselWithControllerState extends State<CarouselWithController> {
  final PageController _controller = PageController();
  final List<String> _images = [
    AppIcons.appLogo, AppIcons.appLogo, AppIcons.appLogo
    // Add more images as needed
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Image.asset(
                _images[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_images.length, (index) {
        return GestureDetector(
          onTap: () => _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          child: Container(
            margin: const EdgeInsets.all(4.0),
            width: 12.0,
            height: 12.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _controller.page?.round() == index
                  ? Colors.green
                  : Colors.grey,
            ),
          ),
        );
      }),
    );
  }
}
