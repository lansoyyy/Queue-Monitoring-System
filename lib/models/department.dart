class Department {
  final String id;
  final String name;
  final String shortName;
  bool isActive;
  final List<ServiceItem> services;

  Department({
    required this.id,
    required this.name,
    required this.shortName,
    this.isActive = true,
    required this.services,
  });

  Department copyWith({bool? isActive}) {
    return Department(
      id: id,
      name: name,
      shortName: shortName,
      isActive: isActive ?? this.isActive,
      services: services,
    );
  }
}

class ServiceItem {
  final String id;
  final String name;
  final String departmentId;
  bool isAvailable;
  final String? description;

  ServiceItem({
    required this.id,
    required this.name,
    required this.departmentId,
    this.isAvailable = true,
    this.description,
  });

  ServiceItem copyWith({bool? isAvailable}) {
    return ServiceItem(
      id: id,
      name: name,
      departmentId: departmentId,
      isAvailable: isAvailable ?? this.isAvailable,
      description: description,
    );
  }
}
