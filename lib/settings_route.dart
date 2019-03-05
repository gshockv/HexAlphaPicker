import 'package:flutter/material.dart';
import "color_model.dart";

class SettingsRoute extends StatefulWidget {
  final int selectedColorPosition;

  SettingsRoute({Key key, @required this.selectedColorPosition}) : super(key: key);

  @override
  _SettingsRouteState createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
  int _selectedColorPosition = 0;
  final _colorModel = OverlayColorModel();

  @override
  void initState() {
    super.initState();
    _selectedColorPosition = widget.selectedColorPosition;
  }

  _selectColor(int position) {
    setState(() {
      _selectedColorPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: _buildSettingsList(),
      ),
    );
  }

  _buildSettingsList() => Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  "OVERLAY COLOR",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w400),
                ),
              ),
              _buildColorsGrid(),
            ],
          ),
        ),
      );

  _buildColorsGrid() => Expanded(
        child: GridView.count(
          padding: EdgeInsets.all(8),
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: _buildColorSelector(),
        ),
      );

  List<Widget> _buildColorSelector() =>
      List.generate(
          _colorModel.overlayColorsCount(), 
              (position) => _buildColorTile(position));

  _buildColorTile(int position) => GridTile(
        child: InkResponse(
          enableFeedback: true,
          child: Ink(
            color: Color(_colorModel.getOverlayColorCode(position)),
            child: Container(
              decoration: _selectedItemDecoration(position),
            ),
          ),
          onTap: () {
            _selectColor(position);
          },
        ),
      );

  _buildAppBar(BuildContext context) => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blueGrey,
            ),
            onPressed: () {
              _applySettings(context);
            }),
        title: Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22,
            color: Colors.blueGrey,
            letterSpacing: 1.5,
          ),
        ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.info_outline,
          color: Colors.blueGrey
        ),
        onPressed: () {
          debugPrint("Info pressed");
        },
      )
    ],
      );

  _applySettings(BuildContext context) {
    Navigator.of(context).pop(_selectedColorPosition);
  }

  BoxDecoration _selectedItemDecoration(int position) {
    if (position == _selectedColorPosition) {
      return BoxDecoration(
        border: Border.all(
          color: Colors.amber,
          width: 4,
        )
      );
    } else {
      return BoxDecoration(
          border: Border.all(
              color: Colors.transparent
          )
      );
    }
  }
}
