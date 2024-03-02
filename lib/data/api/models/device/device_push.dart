class DevicePush {
  DevicePush({
    this.state,
    this.text,
  });

  @override
  String toString() {
    return 'DevicePush{state: $state, text: $text}';
  }

  DevicePush.fromJson(dynamic json) {
    state = json['state'];
    text = json['text'];
  }

  bool? state;
  String? text;
}
