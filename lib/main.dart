import 'package:flutter/material.dart';
import 'hex_colors.dart';

void main() => runApp(HexAlphaApp());

class HexAlphaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hex Alpha',
      home: AppHomePage(),
    );
  }
}

class AppHomePage extends StatefulWidget {
  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  static const _defaultOverlayColor = "000000";
  
  double _alphaValue = 0.5;
  int _alphaPercentage = 50;
  String _hexWithAlphaColor = "#";
  Color _overlayColor = Colors.transparent;

  _AppHomePageState() {
    _calculateOverlayColor();
  }

  void _setValue(double value) {
    setState(() {
      _alphaValue = value;
      _calculateOverlayColor();
    });
  }

  void _calculateOverlayColor() {
    _alphaPercentage = (_alphaValue * 100).round();
    _hexWithAlphaColor = "#" + hexAlpha[_alphaPercentage] + _defaultOverlayColor;
    _overlayColor = Color(_hexToColor(_hexWithAlphaColor));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildPreview(),
          _buildSliderWidget(),
        ],
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
            onPressed: () {},
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
                onChanged: _setValue,
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
                    Container(
                      decoration: BoxDecoration(
                        color: _overlayColor,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Center(
                        child: Text(
                          "${_hexWithAlphaColor}",
                          style: TextStyle(
                            color: Color(0xb3ffffff),
                            fontSize: 42,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 1.5,
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

  int _hexToColor(String code) {
    code = code.replaceFirst('#', '');
    code = code.length == 6 ? 'ff' + code : code;
    int val = int.parse(code, radix: 16);
    return val;
  }
}
