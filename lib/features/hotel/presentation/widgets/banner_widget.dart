import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hotel/config/styles/dimens/dimens.dart';

class BannerWidget extends StatefulWidget {
  final List<String> imageUrls;
  final bool autoPlay;
  const BannerWidget({
    super.key,
    required this.imageUrls,
    this.autoPlay = true,
  });
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<BannerWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: widget.imageUrls.map((e) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.btnRadius),
              child: CachedNetworkImage(
                imageUrl: e,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                errorWidget: (context, url, error) {
                  return Container(
                    color: Colors.grey.withOpacity(0.5),
                    child: const Icon(
                      Icons.broken_image,
                      size: 100,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            );
          }).toList(),
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: widget.autoPlay,
            enlargeCenterPage: true,
            aspectRatio: 1.34,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Positioned(
          left: Dimens.midMargin,
          right: Dimens.midMargin,
          bottom: Dimens.smallMargin,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.smallRadius),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 7.5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: widget.imageUrls.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 7.0,
                      height: 7.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 2.5,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
