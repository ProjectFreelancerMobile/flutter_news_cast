import 'dart:ui';

class ChartData {
  final DateTime x;
  final double y;

  ChartData(this.x, this.y);

  @override
  String toString() {
    return 'ChartData{x: $x, y: $y}';
  }
}

class ChartInfo {
  final Color color;
  final String unit;
  final String name;

  ChartInfo(this.color, this.name, this.unit);

  @override
  String toString() {
    return 'ChartInfo{color: $color, unit:$unit, name: $name}';
  }
}
