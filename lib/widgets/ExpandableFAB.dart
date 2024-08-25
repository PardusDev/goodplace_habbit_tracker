import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../pages/home/home_page_view_model.dart';

class ExpandableFAB extends StatefulWidget {
  final String message;
  final Widget icon;
  final VoidCallback onPressed;
  const ExpandableFAB({super.key, required this.message, required this.icon, required this.onPressed});

  @override
  State<ExpandableFAB> createState() => _ExpandableFABState();
}

class _ExpandableFABState extends State<ExpandableFAB> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _widthAnimation = Tween<double>(
      begin: 56.0,
      end: context.sized.dynamicWidth(0.86)
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.aiFabExpanded) {
          _controller.forward();
        } else {
          _controller.reverse();
        }

        return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return GestureDetector(
                onTap: widget.onPressed,
                child: Container(
                  width: _widthAnimation.value,
                  height: 56.0,
                  margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.0),
                    color: ColorConstants.primaryColor,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (!viewModel.aiFabExpanded)
                        widget.icon
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                          child: Row(
                            children: [
                              widget.icon,
                              const SizedBox(width: 8.0,),
                              Expanded(child: Text(widget.message, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,)),
                            ],
                          ),
                        )
                    ],
                  ),
                )
              );
            }
        );
      }
    );
  }
}
