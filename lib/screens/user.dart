import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../widgets/address.dart';
import '../widgets/dark_theme_provider.dart';
import '../widgets/text_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              RichText(
                text: TextSpan(
                  text: 'Hi,  ',
                  style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'MyName',
                        style: TextStyle(
                          color: color,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('My name is pressed');
                          }),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                text: 'Email@email.com',
                color: color,
                textSize: 18,
                // isTitle: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              _listTiles(
                title: 'Address 2',
                subtitle: 'My subtitle',
                icon: IconlyLight.profile,
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                          width: 250.w, // Adjust the width as needed
                          padding: EdgeInsets.all(3.h),
                          child: ListView(
                            shrinkWrap: true, // Set this to true
                            children: [
                              const Text(
                                "Current:",
                                style: TextStyle(
                                  fontSize:
                                      14, // Adjust the font size as needed
                                  fontWeight: FontWeight
                                      .bold, // Add any desired font weight
                                  color: Colors.black, // Change the text color
                                ),
                              ),
                              const Text(
                                "Update",
                                style: TextStyle(
                                  fontSize:
                                      18, // Adjust the font size as needed
                                  fontWeight: FontWeight
                                      .bold, // Add any desired font weight
                                  color: Colors.blue, // Change the text color
                                ),
                              ),
                              SizedBox(height: 3.h),

                              // Add spacing between the Text and SearchField
                              SizedBox(height: 3.h),

                              // Wrap the SearchField with predictions in SingleChildScrollView
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SearchField(
                                      hintText: "Enter your address",
                                      controller: TextEditingController(),
                                    ),
                                    SizedBox(
                                        height: 3
                                            .h), // Add spacing between the SearchField and buttons
                                  ],
                                ),
                              ),

                              // Add spacing between the SearchField and buttons
                              SizedBox(height: 3.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Implement the logic to save the selected address
                                      // You can access the selected address using the TextEditingController
                                      // For example, String selectedAddress = controller.text;
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                color: color,
              ),
              _listTiles(
                title: 'Orders',
                icon: IconlyLight.bag,
                onPressed: () {},
                color: color,
              ),
              _listTiles(
                title: 'Wishlist',
                icon: IconlyLight.heart,
                onPressed: () {},
                color: color,
              ),
              _listTiles(
                title: 'Viewed',
                icon: IconlyLight.show,
                onPressed: () {},
                color: color,
              ),
              _listTiles(
                title: 'Forgot password?',
                icon: IconlyLight.unlock,
                onPressed: () {},
                color: color,
              ),
              SwitchListTile(
                title: TextWidget(
                  text: themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                  color: color,
                  textSize: 18,
                  // isTitle: true,
                ),
                secondary: Icon(themeState.getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined),
                onChanged: (bool value) {
                  setState(() {
                    themeState.setDarkTheme = value;
                  });
                },
                value: themeState.getDarkTheme,
              ),
              _listTiles(
                title: 'Logout',
                icon: IconlyLight.logout,
                onPressed: () async {
                  await _showLogoutDialog();
                },
                color: color,
              ),
              listTileAsRow(),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _showLogoutDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(
                Icons.logout, // Replace with the icon you want to display
                color: Colors.blue, // You can customize the color
                size: 30.0, // You can customize the size
              ),
              SizedBox(
                  width:
                      4.w), // Add some spacing between the icon and title text
              const Text('Logout Confirmation'), // Add your title text here
            ],
          ),
          content: const Text(
              'Are you sure you want to log out?'), // Add your content text here
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Handle logout logic here
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "No",
                style: TextStyle(
                  fontSize: 13.sp, // Adjust the font size as needed
                  fontWeight: FontWeight.bold, // Add any desired font weight
                  color: Colors.red, // Change the text color
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                "yes",
                style: TextStyle(
                  fontSize: 14, // Adjust the font size as needed
                  fontWeight: FontWeight.bold, // Add any desired font weight
                  color: Colors.blue, // Change the text color
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
        // isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitle == null ? "" : subtitle,
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrow_right_2),
      onTap: () {
        onPressed();
      },
    );
  }

// Alternative code for the listTile.
  Widget listTileAsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          const Icon(Icons.settings),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Title'),
              Text('Subtitle'),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}
