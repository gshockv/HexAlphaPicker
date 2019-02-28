import 'package:flutter/material.dart';

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
  double _value = 0.75;

  void _setValue(double value) {
    setState(() {
      _value = value;
    });
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
            fontWeight: FontWeight.bold,
            color: Color(0xff336688),
            letterSpacing: 2,
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
                "${(_value * 100).round()}%",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 64,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2,
                ),
              ),
              Slider(
                value: _value,
                onChanged: _setValue,
                activeColor: Color(0xFF039BE5),
                divisions: 20,
                label: "${(_value * 100).round()}%",
              ),
            ],
          ),
        ),
      );

  _buildPreview() => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              // preview widget
              Container(
                height: 240,
                decoration: BoxDecoration(
                  color: Color(0xff336699),
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
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0x12000000),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Center(
                        child: Text(
                          "#FF000000",
                          style: TextStyle(
                            color: Color(0xeeffffff),
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2,
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
}
