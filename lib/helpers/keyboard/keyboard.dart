import 'package:flutter/widgets.dart'
    show BuildContext, FocusScope, FocusScopeNode;

class Keyboard {
  static void hide(BuildContext ctx) {
    FocusScopeNode currentFocus = FocusScope.of(ctx);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
