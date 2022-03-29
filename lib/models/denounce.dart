class Denounce {
  String adId;
  String topic;
  String description;
  String email;

  Denounce();

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      "topic": topic,
      "description": description,
      "email": email,
      'ad': adId,
    };
    return map;
  }
}
