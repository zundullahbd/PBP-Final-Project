class Event {
  String name;
  String time;
  String description;
  // final String ename;

  Event({required this.name, required this.time, required this.description});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['Name'],
      time: json['Time'],
      description: json['Description'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'time': time, 'description': description};
}
