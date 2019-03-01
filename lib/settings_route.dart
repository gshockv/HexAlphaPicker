import 'package:flutter/material.dart';

class SettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Text("Settings..."),
      ),
    );
  }

  _buildAppBar(BuildContext context) => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blueGrey,
            ),
            onPressed: () {_applySettings(context); }
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22,
            color: Colors.blueGrey,
            letterSpacing: 1.5,
          ),
        ),
      );

  _applySettings(BuildContext context) {
    Navigator.of(context).pop();
  }
}
