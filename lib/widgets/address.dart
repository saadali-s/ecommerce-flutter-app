import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:sizer/sizer.dart';

class SearchField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const SearchField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    googlePlace = GooglePlace(
        'AIzaSyAn53FVPA8eLIGqD-NytxTf1NYRDkKIYCI'); // Replace with your API key
    super.initState();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 1.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 22,
              ),
              SizedBox(width: 1.h),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  autofocus: false,
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 222), () {
                      if (value.isNotEmpty) {
                        autoCompleteSearch(value);
                      } else {
                        setState(() {
                          predictions = [];
                        });
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        if (predictions.isNotEmpty)
          SizedBox(
            height: 23.h, // Set a fixed height for the suggestions
            child: ListView(
              children: [
                for (var prediction in predictions)
                  ListTile(
                    title: Text(prediction.description ?? ""),
                    onTap: () {
                      widget.controller.text = prediction.description ?? "";
                      setState(() {
                        predictions = [];
                      });
                    },
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
