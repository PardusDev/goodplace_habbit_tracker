import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import 'CustomShimmer.dart';

class SelectableImageCard extends StatefulWidget {
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;
  const SelectableImageCard({super.key, required this.imageUrl, required this.isSelected, required this.onTap});

  @override
  State<SelectableImageCard> createState() => _SelectableImageCardState();
}

class _SelectableImageCardState extends State<SelectableImageCard> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(SelectableImageCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      setState(() {
        _isSelected = widget.isSelected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            width: 3.0,
            color: _isSelected
                ? ColorConstants.secondaryColor
                : ColorConstants.transparent,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return const SizedBox.expand(
                child: CustomShimmer(),
              );
            },
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
