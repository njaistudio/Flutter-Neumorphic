import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicPlayground extends BaseScreen {
  @override
  Widget getChild() {
    return _Page();
  }
}
class BaseScreen extends StatelessWidget {

  Widget getChild() {
     return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NeumorphicTheme(
      usedTheme: UsedTheme.LIGHT,
      theme: NeumorphicThemeData(
        baseColor: Color(0xffDDDDDD),
        accentColor: Color(0xffFF00FF),
        lightSource: LightSource.topLeft,
        depth: 6,
        intensity: 0.5,
      ),
      child: getChild(),
    );
  }
}


class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> {
  final Color buttonActiveColor = Colors.yellow;
  final Color buttonInnactiveColor = Colors.grey;

  LightSource lightSource = LightSource.topLeft;
  NeumorphicShape shape = NeumorphicShape.flat;
  NeumorphicBoxShape boxShape;
  double depth = 5;
  double intensity = 0.5;
  double surfaceIntensity = 0.5;
  double cornerRadius = 20;
  double height = 150.0;
  double width = 150.0;

  static final minWidth = 50.0;
  static final maxWidth = 200.0;
  static final minHeight = 50.0;
  static final maxHeight = 200.0;

  @override
  void initState() {
    boxShape = NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(this.cornerRadius));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NeumorphicBackground(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Test", style: TextStyle(color: NeumorphicTheme.of(context).current.accentColor),),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: RaisedButton(child: Text("back"), onPressed: (){
                    NeumorphicTheme.of(context).usedTheme = NeumorphicTheme.isUsingDark(context) ? UsedTheme.LIGHT : UsedTheme.DARK;
                  },),
                ),
                shapeWidget(),
                boxshapeWidget(),
                intensitySelector(),
                surfaceIntensitySelector(),
                depthSelector(),
                cornerRadiusSelector(),
                sizeSelector(),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ...lightSourceWidgets(),
                      Center(child: neumorphic()),
                      colorPicker(),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget colorPicker() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Row(
        children: <Widget>[
          RaisedButton(
            child: Text("Color"),
            onPressed: () {
              changeColor();
            },
          ),
        ],
      ),
    );
  }

  void changeColor() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: NeumorphicTheme.of(context).current.baseColor,
            onColorChanged: (color) {
              setState(() {
                NeumorphicTheme.of(context).updateCurrentTheme(NeumorphicThemeData(baseColor: color));
              });
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget neumorphic() {
    return NeumorphicButton(
      padding: EdgeInsets.zero,
      duration: Duration(milliseconds: 300),
      onClick: () {
        setState(() {});
      },
      boxShape: boxShape,
      style: NeumorphicStyle(
        shape: this.shape,
        intensity: this.intensity,
        surfaceIntensity: this.surfaceIntensity,
        depth: depth,
        lightSource: this.lightSource,
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: Container(
            //color: Colors.blue,
            child: Center(child: Text(""))),
      ),
    );
  }

  Widget depthSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Depth"),
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.MIN_DEPTH,
            max: Neumorphic.MAX_DEPTH,
            value: depth,
            onChanged: (value) {
              setState(() {
                depth = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(depth.floor().toString()),
        ),
      ],
    );
  }

  Widget sizeSelector() {
    return Row(
      children: <Widget>[
        SizedBox(width: 12,),
        Text("W: "),
        Expanded(
          child: Slider(
            min: minWidth,
            max: maxWidth,
            value: width,
            onChanged: (value) {
              setState(() {
                width = value;
              });
            },
          ),
        ),
        Text("H: "),
        Expanded(
          child: Slider(
            min: minHeight,
            max: maxHeight,
            value: height,
            onChanged: (value) {
              setState(() {
                height = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget cornerRadiusSelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Corner"),
        ),
        Expanded(
          child: Slider(
            min: 0,
            max: 30,
            value: cornerRadius,
            onChanged: (value) {
              setState(() {
                cornerRadius = value;
                if (boxShape.isRoundRect) {
                  boxShape = NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(this.cornerRadius));
                }
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(cornerRadius.floor().toString()),
        ),
      ],
    );
  }

  Widget intensitySelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Intensity"),
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.MIN_INTENSITY, //in case of != 0
            max: Neumorphic.MAX_INTENSITY,
            value: intensity,
            onChanged: (value) {
              setState(() {
                intensity = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(((intensity * 100).floor() / 100).toString()),
        ),
      ],
    );
  }

  Widget surfaceIntensitySelector() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("SurfaceIntensity"),
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.MIN_INTENSITY, //in case of != 0
            max: Neumorphic.MAX_INTENSITY,
            value: surfaceIntensity,
            onChanged: (value) {
              setState(() {
                surfaceIntensity = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text(((surfaceIntensity * 100).floor() / 100).toString()),
        ),
      ],
    );
  }

  Widget boxshapeWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            setState(() {
              boxShape = NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(this.cornerRadius));
            });
          },
          color: boxShape.isRoundRect ? buttonActiveColor : buttonInnactiveColor,
          child: Text("Rectangle"),
        ),
        RaisedButton(
          onPressed: () {
            setState(() {
              boxShape = NeumorphicBoxShape.circle();
            });
          },
          color: boxShape.isCircle ? buttonActiveColor : buttonInnactiveColor,
          child: Text("Circle"),
        ),
        RaisedButton(
          onPressed: () {
            setState(() {
              boxShape = NeumorphicBoxShape.stadium();
            });
          },
          color: boxShape.isStadium ? buttonActiveColor : buttonInnactiveColor,
          child: Text("Stadium"),
        ),
      ],
    );
  }

  Widget shapeWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            onPressed: () {
              setState(() {
                shape = NeumorphicShape.concave;
              });
            },
            color: shape == NeumorphicShape.concave ? buttonActiveColor : buttonInnactiveColor,
            child: Text("Concave"),
          ),
        ),
        Expanded(
          child: RaisedButton(
            onPressed: () {
              setState(() {
                shape = NeumorphicShape.convex;
              });
            },
            color: shape == NeumorphicShape.convex ? buttonActiveColor : buttonInnactiveColor,
            child: Text("Convex"),
          ),
        ),
        Expanded(
          child: RaisedButton(
            onPressed: () {
              setState(() {
                shape = NeumorphicShape.flat;
              });
            },
            color: shape == NeumorphicShape.flat ? buttonActiveColor : buttonInnactiveColor,
            child: Text("Flat"),
          ),
        ),
      ],
    );
  }

  List<Widget> lightSourceWidgets() {
    return [
      Positioned(
        left: 10,
        right: 10,
        child: Slider(
          min: -1,
          max: 1,
          value: lightSource.dx,
          onChanged: (value) {
            setState(() {
              lightSource = lightSource.copyWith(dx: value);
            });
          },
        ),
      ),
      Positioned(
        left: 0,
        top: 10,
        bottom: 10,
        child: RotatedBox(
          quarterTurns: 1,
          child: Slider(
            min: -1,
            max: 1,
            value: lightSource.dy,
            onChanged: (value) {
              setState(() {
                lightSource = lightSource.copyWith(dy: value);
              });
            },
          ),
        ),
      ),
    ];
  }
}
