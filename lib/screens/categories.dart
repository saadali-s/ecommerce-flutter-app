import 'package:flutter/material.dart';

import '../widgets/categories_widget.dart';
import '../widgets/text_widget.dart';
import '../widgets/utils.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);
  final List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];

  List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/images/category1.png',
      'catText': 'Beef',
    },
    {
      'imgPath': 'assets/images/category2.png',
      'catText': 'Poultry',
    },
    {
      'imgPath': 'assets/images/category3.png',
      'catText': 'Lamb',
    },
    {
      'imgPath': 'assets/images/category4.png',
      'catText': 'Sea Food',
    },
    {
      'imgPath': 'assets/images/special.png',
      'catText': 'On Special',
    },
    {
      'imgPath': 'assets/images/category1.png',
      'catText': 'Biltong',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            text: 'Categories',
            color: color,
            textSize: 24,
            isTitle: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 250,
            crossAxisSpacing: 10, // Vertical spacing
            mainAxisSpacing: 10, // Horizontal spacing
            children: List.generate(6, (index) {
              return CategoriesWidget(
                catText: catInfo[index]['catText'],
                imgPath: catInfo[index]['imgPath'],
                passedColor: gridColors[index],
              );
            }),
          ),
        ));
  }
}
