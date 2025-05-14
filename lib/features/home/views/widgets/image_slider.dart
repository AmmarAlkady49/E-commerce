import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 6),
            aspectRatio: 2.25,
            enlargeCenterPage: true,
            disableCenter: true,
            animateToClosest: true,
            enableInfiniteScroll: true,
            // reverse: HelperFunctions.isArabic(context) ? true : false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: imgList
              .map((item) => Container(
                    // padding:
                    //     const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        // topLeft: Radius.circular(12),
                        // topRight: Radius.circular(12),
                        // bottomLeft: Radius.circular(12),
                        // bottomRight: Radius.circular(12),
                        Radius.circular(12),
                      ),
                      border: Border.all(color: Colors.black12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        item,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        cacheHeight: 800,
                        cacheWidth: 442,
                      ),
                    ),
                  ))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: _current == entry.key ? 23.0 : 12.0,
                height: 8.5,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 1.5),
                decoration: BoxDecoration(
                    borderRadius: _current == entry.key
                        ? BorderRadius.circular(10)
                        : null,
                    shape: _current == entry.key
                        ? BoxShape.rectangle
                        : BoxShape.circle,
                    color: _current == entry.key
                        // ? MyColor.kellyGreen2.withValues(alpha: 0.8)
                        ? MyColor.kellyGreen3
                        : Colors.grey.shade500),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

final List<String> imgList = [
  "assets/images/home_page/7090379.webp",
  "assets/images/home_page/7498785.webp",
  "assets/images/home_page/10135204.jpg",
];
