import 'package:flutter/material.dart';
import "settings_route.dart";
import "color_model.dart";

void main() => runApp(HexAlphaApp());

class HexAlphaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hex Alpha',
      debugShowCheckedModeBanner: false,
      home: AppHomePage(),
    );
  }
}

class AppHomePage extends StatefulWidget {
  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  final _colorModel = OverlayColorModel();

  int _selectedOverlayIndex = 0;
  double _alphaValue = 0;
  int _alphaPercentage = 0;

  @override
  void initState() {
    super.initState();
    _alphaValue = _colorModel.defaultAlphaValue;
    _calculateOverlay();
  }

  void _setAlphaValue(double value) {
    setState(() {
      _alphaValue = value;
      _calculateOverlay();
    });
  }

  void _calculateOverlay() {
    _alphaPercentage = (_alphaValue * 100).round();
    _colorModel.calculateOverlayColor(_alphaPercentage, _selectedOverlayIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildPreview(),
            _buildSliderWidget(),
          ],
        ),
      ),
    );
  }

  _buildAppBar() => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Hex Alpha Picker",
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
              Icons.settings,
              color: Color(0xaa336688),
            ),
            onPressed: _openSettings,
          ),
        ],
      );

  _buildSliderWidget() => Container(
        height: 240,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "${_alphaPercentage}%",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 88,
                  fontWeight: FontWeight.w200,
                  letterSpacing: 2,
                ),
              ),
              Slider(
                value: _alphaValue,
                onChanged: _setAlphaValue,
                activeColor: Color(0xFF039BE5),
                divisions: 20,
                //label: "${(_alphaValue * 100).round()}%",
              ),
            ],
          ),
        ),
      );

  _buildPreview() => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              // preview widget
              Container(
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        child: Image.asset(
                          "images/sardinia_sea_landscape.jpg",
                          fit: BoxFit.cover,
                          height: 240,
                        )),
                    // transparent color overlay
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _colorModel.overlayColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            "${_colorModel.overlayColorHuman}",
                            style: TextStyle(
                              color: Color(0xb3ffffff),
                              fontSize: 42,
                              fontWeight: FontWeight.w200,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, bottom: 4),
                child: Divider(
                  color: Colors.blueGrey,
                ),
              ),
              Text(
                "PREVIEW",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      );

  void _openSettings() async {
    final overlayIndex = await Navigator.of(context)
        .push(MaterialPageRoute(builder:
          (context) => SettingsRoute(selectedColorPosition: _selectedOverlayIndex)));

    setState(() {
      if (overlayIndex != null) {
        _selectedOverlayIndex = overlayIndex;
        _calculateOverlay();
      }
    });
  }
}
