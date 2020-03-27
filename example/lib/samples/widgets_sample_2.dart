import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class WidgetsSample2 extends StatefulWidget {
  WidgetsSample2({Key key}) : super(key: key);

  @override
  createState() => _ContainersListPageState();
}

class _ContainersListPageState extends State<WidgetsSample2> {
  int _groupValue;
  bool _switchConcaveEnabled = false;
  bool _switchConvexEnabled = false;
  bool _switchFlatEnabled = false;

  bool useDark = false;

  Color _textColor() {
    if (useDark)
      return Colors.white70;
    else {
      return Colors.black;
    }
  }

  Widget _buildProgress() {
    return Row(
      children: <Widget>[
        Text(
          "Progress",
          style: TextStyle(color: _textColor()),
        ),
        SizedBox(width: 12),
        Flexible(
          child: NeumorphicProgress(
            height: 15,
            percent: 0.55,
          ),
        ),
        SizedBox(width: 12),
      ],
    );
  }

  Widget _buildIndeterminateProgress() {
    return Row(
      children: <Widget>[
        Text(
          "Progress",
          style: TextStyle(color: _textColor()),
        ),
        SizedBox(width: 12),
        Flexible(
          child: NeumorphicProgressIndeterminate(
            height: 10,
          ),
        ),
        SizedBox(width: 12),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: <Widget>[
        Text(
          "Buttons",
          style: TextStyle(color: _textColor()),
        ),
        SizedBox(width: 20),
        NeumorphicButton(
          duration: Duration(milliseconds: 500),
          boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(16)),
          style: NeumorphicStyle(shape: NeumorphicShape.flat),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Text(
            "button",
            style: TextStyle(color: _textColor()),
          ),
          onClick: () {
          },
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _buildRadios() {
    final size = 70.0;
    return Row(
      children: <Widget>[
        Text(
          "Radios",
          style: TextStyle(color: _textColor()),
        ),
        SizedBox(width: 20),
        NeumorphicRadio(
          boxShape: NeumorphicBoxShape.circle(),
          child: SizedBox(
            height: size,
            width: size,
            child: Center(
              child: Text(
                "A",
                style: TextStyle(color: _textColor()),
              ),
            ),
          ),
          value: 1,
          groupValue: _groupValue,
          onChanged: (value) {
            setState(() {
              _groupValue = value;
            });
          },
        ),
        SizedBox(width: 20),
        NeumorphicRadio(
          boxShape: NeumorphicBoxShape.circle(),
          child: SizedBox(
            height: size,
            width: size,
            child: Center(
              child: Text(
                "B",
                style: TextStyle(color: _textColor()),
              ),
            ),
          ),
          value: 2,
          groupValue: _groupValue,
          onChanged: (value) {
            setState(() {
              _groupValue = value;
            });
          },
        ),
        SizedBox(width: 20),
        NeumorphicRadio(
          boxShape: NeumorphicBoxShape.circle(),
          child: SizedBox(
            height: size,
            width: size,
            child: Center(
              child: Text(
                "C",
                style: TextStyle(color: _textColor()),
              ),
            ),
          ),
          value: 3,
          groupValue: _groupValue,
          onChanged: (value) {
            setState(() {
              _groupValue = value;
            });
          },
        ),
      ],
    );
  }

  bool check1 = false;
  bool check2 = false;
  bool check3 = false;

  Widget _buildChecks() {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              NeumorphicCheckbox(
                value: check1,
                onChanged: (value) {
                  setState(() {
                    check1 = value;
                  });
                },
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: Text(
                  "Aya Nakamyura",
                  style: TextStyle(color: _textColor()),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              NeumorphicCheckbox(
                value: check2,
                onChanged: (value) {
                  setState(() {
                    check2 = value;
                  });
                },
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: Text(
                  "PNL",
                  style: TextStyle(color: _textColor()),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              NeumorphicCheckbox(
                value: check3,
                onChanged: (value) {
                  setState(() {
                    check3 = value;
                  });
                },
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: Text(
                  "Jul",
                  style: TextStyle(color: _textColor()),
                ),
              ),
            ],
          ),
          NeumorphicCheckbox(
            value: check3,
            onChanged: (value) {
              setState(() {
                check3 = value;
              });
            },
          ),
        ],
      ),
    );
  }


  double seekValue = 0;

  Widget _buildSlider() {
    return Row(
      children: <Widget>[
        Text(
          "Slider",
          style: TextStyle(color: _textColor()),
        ),
        SizedBox(width: 12),
        Flexible(
          child: NeumorphicSlider(
              height: 15,
              value: seekValue,
              min: 0,
              max: 10,
              onChanged: (value) {
                setState(() {
                  seekValue = value;
                });
              }),
        ),
        SizedBox(width: 12),
        Text(
          "value: ${seekValue.round()}",
          style: TextStyle(color: _textColor()),
        ),
        SizedBox(width: 12),
      ],
    );
  }

  Widget _buildSwitches() {
    final spacing = 20.0;
    return Row(children: <Widget>[
      Text(
        "Switch",
        style: TextStyle(color: _textColor()),
      ),
      SizedBox(width: spacing),
      NeumorphicSwitch(
        value: _switchConcaveEnabled,
        style: NeumorphicSwitchStyle(
          thumbShape: NeumorphicShape.concave, // concave or flat with elevation
        ),
        onChanged: (value) {
          setState(() {
            _switchConcaveEnabled = value;
          });
        },
      ),
      SizedBox(width: spacing),
      NeumorphicSwitch(
        value: _switchFlatEnabled,
        style: NeumorphicSwitchStyle(
          thumbShape: NeumorphicShape.flat, // concave or flat with elevation
        ),
        onChanged: (value) {
          setState(() {
            _switchFlatEnabled = value;
          });
        },
      ),
      SizedBox(width: spacing),
      NeumorphicSwitch(
        value: _switchConvexEnabled,
        style: NeumorphicSwitchStyle(
          thumbShape: NeumorphicShape.convex,
        ),
        onChanged: (value) {
          setState(() {
            _switchConvexEnabled = value;
          });
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      usedTheme: useDark ? UsedTheme.DARK : UsedTheme.LIGHT,
      darkTheme: NeumorphicThemeData(
        baseColor: NeumorphicColors.darkBackground,
        accentColor: NeumorphicColors.darkAccent,
        lightSource: LightSource.topLeft,
        depth: 6,
        intensity: 0.3,
      ),
      theme: NeumorphicThemeData(
        baseColor: Color(0xffDDDDDD),
        lightSource: LightSource.topLeft,
        depth: 8,
        intensity: 0.5,
      ),
      child: Scaffold(
        body: FractionallySizedBox(
          //match parent height
          heightFactor: 1,
          child: NeumorphicBackground(
            //margin: EdgeInsets.all(10),
            //borderRadius: BorderRadius.circular(40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: <Widget>[
                      Neumorphic(
                        child: AppBar(
                          iconTheme: IconThemeData.fallback(),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          title: Text(
                            "Widgets",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        style: NeumorphicStyle(depth: -8),
                      ),
                      /*
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: NeumorphicButton(
                          onClick: (){
                            setState(() {
                              useDark = !useDark;
                            });
                          },
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Text(useDark ? "Dark" : "Light"),
                        ),
                      )
                       */
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(height: 30),
                        _buildProgress(),
                        SizedBox(height: 12),
                        _buildIndeterminateProgress(),
                        SizedBox(height: 30),
                        _buildButtons(),
                        SizedBox(height: 40),
                        _buildRadios(),
                        SizedBox(height: 40),
                        _buildChecks(),
                        SizedBox(height: 40),
                        _buildSlider(),
                        SizedBox(height: 40),
                        _buildSwitches(),
                        SizedBox(height: 40),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
