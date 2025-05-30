class AppUser {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String location;
  final List<String> attendingEvents;
  final List<String> hostingEvents;
  final List<String> badges;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.location,
    required this.attendingEvents,
    required this.hostingEvents,
    required this.badges,
  });

  factory AppUser.fromMap(Map<String, dynamic> map, String id) {
    return AppUser(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      location: map['location'] ?? '',
      attendingEvents: List<String>.from(map['attendingEvents'] ?? []),
      hostingEvents: List<String>.from(map['hostingEvents'] ?? []),
      badges: List<String>.from(map['badges'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'location': location,
      'attendingEvents': attendingEvents,
      'hostingEvents': hostingEvents,
      'badges': badges,
    };
  }

  // Added copyWith method
  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? location,
    List<String>? attendingEvents,
    List<String>? hostingEvents,
    List<String>? badges,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      location: location ?? this.location,
      attendingEvents: attendingEvents ?? this.attendingEvents,
      hostingEvents: hostingEvents ?? this.hostingEvents,
      badges: badges ?? this.badges,
    );
  }
}
