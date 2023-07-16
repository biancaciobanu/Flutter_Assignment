class Contact {
  final int? id;
  final String name;
  final String mobilePhoneNumber;
  final String landlineNumber;
  final bool isFavorite;

  Contact({
    this.id,
    required this.name,
    required this.mobilePhoneNumber,
    required this.landlineNumber,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobilePhoneNumber': mobilePhoneNumber,
      'landlineNumber': landlineNumber,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      mobilePhoneNumber: map['mobilePhoneNumber'],
      landlineNumber: map['landlineNumber'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
