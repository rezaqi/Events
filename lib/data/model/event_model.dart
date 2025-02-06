class EventModel {
  String id;
  String title;
  String description;
  int date;
  String timer;
  String category;
  int image;
  String location;

  // Constructor
  EventModel({
    this.id = "",
    required this.title,
    required this.image,
    required this.description,
    required this.date,
    required this.timer,
    required this.category,
    required this.location,
  });

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      timer: map['timer'] ?? '',
      category: map['category'] ?? '',
      location: map['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'date': date,
      'timer': timer,
      'category': category,
      'location': location,
    };
  }

  @override
  String toString() {
    return 'EventModel(id: $id, title: $title, description: $description, date: $date, category: $category, timer: $timer , image: $image location: $location)';
  }
}
