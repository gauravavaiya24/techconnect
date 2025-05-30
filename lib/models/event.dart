class Event {
  final String id;
  final String title;
  final String category;
  final String date;
  final String description;
  final String host;
  final String location;
  final String coordinates;
  final String imageUrl;
  final int capacity;
  final List<String> attendees;
  final String price;
  final String rating;

  Event({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.description,
    required this.host,
    required this.location,
    required this.coordinates,
    required this.imageUrl,
    required this.capacity,
    required this.attendees,
    required this.price,
    required this.rating,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      date: json['date'],
      description: json['description'],
      host: json['host'],
      location: json['location'],
      coordinates: json['coordinates'],
      imageUrl: json['imageUrl'],
      capacity: json['capacity'],
      attendees: List<String>.from(json['attendees']),
      price: json['price'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'date': date,
      'description': description,
      'host': host,
      'location': location,
      'coordinates': coordinates,
      'imageUrl': imageUrl,
      'capacity': capacity,
      'attendees': attendees,
      'price': price,
      'rating': rating,
    };
  }

  Event copyWith({
    String? id,
    String? title,
    String? category,
    String? date,
    String? description,
    String? host,
    String? location,
    String? coordinates,
    String? imageUrl,
    int? capacity,
    List<String>? attendees,
    String? price,
    String? rating,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      date: date ?? this.date,
      description: description ?? this.description,
      host: host ?? this.host,
      location: location ?? this.location,
      coordinates: coordinates ?? this.coordinates,
      imageUrl: imageUrl ?? this.imageUrl,
      capacity: capacity ?? this.capacity,
      attendees: attendees ?? this.attendees,
      price: price ?? this.price,
      rating: rating ?? this.rating,
    );
  }
}
