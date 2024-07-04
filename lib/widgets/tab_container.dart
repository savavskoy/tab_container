import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tab_container/constants.dart';
import 'package:tab_container/widgets/animated_image_item.dart';
import 'package:tab_container/widgets/image_item.dart';

class TabContainer extends StatefulWidget {
  final List<List<String>> images;

  const TabContainer({super.key, required this.images});

  @override
  TabContainerState createState() => TabContainerState();
}

class TabContainerState extends State<TabContainer>
    with TickerProviderStateMixin {
  static const int _animatedImagesCount = 4;

  final ScrollController _scrollController = ScrollController();

  var _selectedTabIndex = 0;
  var _prevTabIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Tabs(
            selectedIndex: _selectedTabIndex,
            tabsCount: widget.images.length,
            onTabPressed: (index) async {
              await scrollToFirstElement();
              setState(() {
                _prevTabIndex = _selectedTabIndex;
                _selectedTabIndex = index;
              });
            }),
        Expanded(
          child: Center(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.images[_selectedTabIndex].length,
              itemBuilder: (context, index) {
                return SizedBox(
                  key: ValueKey('PushingContainer-$_selectedTabIndex-$index'),
                  width: imageSize,
                  child: index < _animatedImagesCount
                      ? AnimatedImageItem(
                          firstImageUrl: widget.images[_prevTabIndex][index],
                          secondImageUrl: widget.images[_selectedTabIndex]
                              [index],
                          index: index,
                        )
                      : ImageItem(
                          imageUrl: widget.images[_selectedTabIndex][index],
                        ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> scrollToFirstElement() {
    return _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}

class _Tabs extends StatelessWidget {
  final int tabsCount;
  final int selectedIndex;
  final Function(int) onTabPressed;

  const _Tabs({
    required this.selectedIndex,
    required this.tabsCount,
    required this.onTabPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: ListView.builder(
        itemCount: tabsCount,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTabPressed(index),
            child: Container(
              color: selectedIndex == index ? Colors.blue : Colors.grey,
              height: 100,
              child: Center(
                child: RotatedBox(
                    quarterTurns: 3, child: Text('Tab ${index + 1}')),
              ),
            ),
          );
        },
      ),
    );
  }
}
