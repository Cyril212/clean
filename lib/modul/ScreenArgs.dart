abstract class ScreenArgs {
  Map<String, String> get asMap;
}

class NoAnimationScreenArgs extends ScreenArgs {
  final int millis;

  NoAnimationScreenArgs({this.millis = 0});
  @override
  Map<String, String> get asMap => {'router-no-animation':millis.toString()};

}
