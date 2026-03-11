import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../core/constants/app_colors.dart';
import '../models/queue_ticket.dart';

/// Simulates the print preview / printed ticket layout (Figure 16H)
class TicketPrintScreen extends StatelessWidget {
  final QueueTicket ticket;

  const TicketPrintScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D3748),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
        title: Text(
          'Queue Ticket Preview',
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
            icon: const Icon(Icons.home_rounded, color: Colors.white70, size: 16),
            label: Text(
              'Return Home',
              style: GoogleFonts.poppins(
                  fontSize: 12, color: Colors.white70),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40000000),
                blurRadius: 40,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Hospital header
              const Icon(Icons.local_hospital,
                  size: 32, color: AppColors.primary),
              const SizedBox(height: 4),
              Text(
                'NMMC',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
              Text(
                'Northern Mindanao Medical Center',
                style: GoogleFonts.poppins(
                  fontSize: 9,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Outpatient Department',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: AppColors.textTertiary,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: AppColors.border),
              ),
              // Queue number big
              Text(
                ticket.formattedNumber,
                style: GoogleFonts.poppins(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                  height: 1,
                ),
              ),
              const SizedBox(height: 16),
              // Info pills
              _ticketPill('WAITING NUMBER', ticket.formattedNumber),
              const SizedBox(height: 8),
              _ticketPill('DOCTOR ASSIGNED', ticket.doctorName),
              const SizedBox(height: 8),
              _ticketPill('ROOM NUMBER', ticket.roomNumber),
              const SizedBox(height: 8),
              _ticketPill('DEPARTMENT', ticket.departmentName),
              const SizedBox(height: 8),
              _ticketPill('SERVICE',
                  ticket.serviceName.replaceAll('\n', ' ')),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(color: AppColors.border),
              ),
              // QR code
              QrImageView(
                data: ticket.qrData,
                version: QrVersions.auto,
                size: 120,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: AppColors.primary,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Scan QR to monitor your queue remotely',
                style: GoogleFonts.poppins(
                  fontSize: 9,
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                ticket.qrData,
                style: GoogleFonts.robotoMono(
                  fontSize: 8,
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ticketPill(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 8,
              fontWeight: FontWeight.w600,
              color: Colors.white60,
              letterSpacing: 1.2,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
