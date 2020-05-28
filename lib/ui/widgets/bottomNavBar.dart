import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:urlix/ui/utilities/colors.dart' as xColors;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

typedef TapIndexCallback = void Function(int index);

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key key, this.onTab}) : super(key: key);

  final TapIndexCallback onTab;

  @override
  Widget build(BuildContext context) {
    return StyleProvider(
      style: Style(),
      child: ConvexAppBar(
        backgroundColor: xColors.black2,
        //activeColor: colors.CYAN,
        items: [
          TabItem(icon: EvaIcons.personOutline, title: 'Mi cuenta'),
          TabItem(icon: EvaIcons.flashOutline, title: 'Recargas'),
          TabItem(icon: EvaIcons.plus, title: 'Recargar'),
          TabItem(icon: EvaIcons.settingsOutline, title: 'Ajustes'),
        ],
        initialActiveIndex: 0,
        onTap: (int tab) {
          onTab(tab);
        },
      ),
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 12, color: color, fontFamily: 'OpenSans');
  }
}
