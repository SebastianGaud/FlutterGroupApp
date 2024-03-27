import 'package:triptaptoe_app/models/ActivityDTO.dart';

class CityDTO {
  final String? country;
  final String name;
  final List<ActivityDTO>? activities;

  CityDTO({
    this.country,
    required this.name,
    this.activities,
  });

  factory CityDTO.fromJson(Map<String, dynamic> json) {
    late List<ActivityDTO> activities;
    if (json['activities'] != null) {
      activities = List<ActivityDTO>.from(json['activities'].map((day) => ActivityDTO.fromJson(day)));
    }

    return CityDTO(
      country: json['country'],
      name: json['name'],
      activities: activities,
    );
  }
}
