import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/color_constants.dart';
import '../constants/image_constants.dart';

class InputSection<T> extends StatelessWidget {
  final String title;
  final String description;
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final VoidCallback? onAutofillTap;
  final bool? descLoading;
  final int maxChars = 25;

  const InputSection({
    required this.title,
    required this.description,
    required this.hintText,
    required this.controller,
    super.key,
    this.onChanged, this.onAutofillTap, this.descLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              if (title == "Habit Subject - Optional") ...[
                GestureDetector(
                  onTap: () {
                    onAutofillTap!();
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        ImageConstants.aiCreateIcon,
                        color: ColorConstants.createHabitAIIconColor,
                        width: 20.0,
                        height: 20.0,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Auto-fill",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: ColorConstants.createHabitAIIconColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8.0),
          if (title == "Habit Subject - Optional" && descLoading!)
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: TextField(
                enabled: false,
                controller: controller,
                maxLines: 5,
                minLines: 5,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            )
          else
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  onChanged: (value) {
                    if (title == "Habit Name") {
                      if (value.length <= maxChars) {
                        controller.text = value;
                        controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: value.length),
                        );
                      } else {
                        controller.text = value.substring(0, maxChars);
                        controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: maxChars),
                        );
                      }
                    }
                    if (onChanged != null) onChanged!(controller.text);
                  },
                  controller: controller,
                  maxLines: title == "Habit Subject - Optional" ? 5 : 1,
                  minLines: title == "Habit Subject - Optional" ? 5 : 1,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                  ),
                ),
                if (title == "Habit Name" && controller.text.length >= 20)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      '${controller.text.length}/$maxChars',
                      style: TextStyle(
                        color: controller.text.length == maxChars
                            ? Colors.red
                            : Colors.orange,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}