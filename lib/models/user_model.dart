import 'package:cloud_firestore/cloud_firestore.dart';

class BlinkUser {
  final String uid;
  final String name;
  final String city;
  final String? photoUrl;
  final bool isInvisible;
  final Map<String, String> socialLinks;
  final double latitude;
  final double longitude;
  final Timestamp? lastSeen; // ← Añadido para leer desde Firestore

  BlinkUser({
    required this.uid,
    required this.name,
    required this.city,
    this.photoUrl,
    this.isInvisible = false,
    Map<String, String>? socialLinks,
    required this.latitude,
    required this.longitude,
    this.lastSeen,
  }) : socialLinks = socialLinks ?? {};

  /// Convierte un DocumentSnapshot en BlinkUser
  factory BlinkUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BlinkUser(
      uid: doc.id,
      name: data['name'] as String? ?? 'Sin nombre',
      city: data['city'] as String? ?? 'Desconocida',
      photoUrl: data['photoUrl'] as String?,
      isInvisible: data['isInvisible'] as bool? ?? false,
      socialLinks: Map<String, String>.from(data['socialLinks'] ?? {}),
      latitude: (data['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (data['longitude'] as num?)?.toDouble() ?? 0.0,
      lastSeen: data['lastSeen'] as Timestamp?,
    );
  }

  /// Para guardar/actualizar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'city': city,
      'photoUrl': photoUrl,
      'isInvisible': isInvisible,
      'socialLinks': socialLinks,
      'latitude': latitude,
      'longitude': longitude,
      'lastSeen': FieldValue.serverTimestamp(),
    };
  }

  /// Para hacer copias con cambios (super útil con Riverpod o setState)
  BlinkUser copyWith({
    String? uid,
    String? name,
    String? city,
    String? photoUrl,
    bool? isInvisible,
    Map<String, String>? socialLinks,
    double? latitude,
    double? longitude,
    Timestamp? lastSeen,
  }) {
    return BlinkUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      city: city ?? this.city,
      photoUrl: photoUrl ?? this.photoUrl,
      isInvisible: isInvisible ?? this.isInvisible,
      socialLinks: socialLinks ?? this.socialLinks,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlinkUser && runtimeType == other.runtimeType && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}