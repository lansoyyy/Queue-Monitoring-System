class QueueTicket {
  final String ticketNumber;
  final String departmentName;
  final String serviceName;
  final String doctorName;
  final String roomNumber;
  final DateTime issuedAt;
  final String qrData;

  QueueTicket({
    required this.ticketNumber,
    required this.departmentName,
    required this.serviceName,
    required this.doctorName,
    required this.roomNumber,
    required this.issuedAt,
    required this.qrData,
  });

  String get formattedNumber => ticketNumber.padLeft(4, '0');
}
