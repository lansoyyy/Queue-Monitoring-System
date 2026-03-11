import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import '../core/constants/app_colors.dart';
import '../models/queue_ticket.dart';
import '../widgets/kiosk_widgets.dart';
import 'ticket_print_screen.dart';

class QueueInfoScreen extends StatelessWidget {
  final QueueTicket ticket;

  const QueueInfoScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final timeStr = DateFormat('HH:mm:ss').format(ticket.issuedAt);

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF7),
      appBar: KioskAppBar(
        breadcrumb: '${ticket.departmentName}  ›  ${ticket.serviceName.replaceAll('\n', ' ')}',
        onMenuTap: () => Navigator.of(context).popUntil((r) => r.isFirst),
      ),
      body: Column(
        children: [
          Container(height: 4, color: AppColors.primary.withAlpha(40)),
          Expanded(
            child: Row(
              children: [
                // Left sidebar placeholder (receipt decoration)
                _ReceiptSidebar(ticket: ticket),
                // Main content
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Time + QR top-right corner badge
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 24, top: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        timeStr,
                                        style: GoogleFonts.robotoMono(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    QrImageView(
                                      data: ticket.qrData,
                                      version: QrVersions.auto,
                                      size: 80,
                                      eyeStyle: const QrEyeStyle(
                                        eyeShape: QrEyeShape.square,
                                        color: AppColors.primary,
                                      ),
                                      dataModuleStyle: const QrDataModuleStyle(
                                        dataModuleShape: QrDataModuleShape.square,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Scan to track queue',
                                      style: GoogleFonts.poppins(
                                        fontSize: 9,
                                        color: AppColors.textTertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Queue number large display
                          Text(
                            'Your Queue Number',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: AppColors.primary.withAlpha(80),
                                  width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withAlpha(30),
                                  blurRadius: 20,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Text(
                              ticket.formattedNumber,
                              style: GoogleFonts.poppins(
                                fontSize: 52,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                                height: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Info pills
                          InfoPill(
                            label: 'WAITING NUMBER',
                            value: ticket.formattedNumber,
                          ),
                          InfoPill(
                            label: 'DOCTOR ASSIGNED',
                            value: ticket.doctorName,
                          ),
                          InfoPill(
                            label: 'ROOM NUMBER',
                            value: ticket.roomNumber,
                          ),
                          const SizedBox(height: 20),
                          // Print button
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      TicketPrintScreen(ticket: ticket),
                                  transitionsBuilder: (_, anim, __, child) =>
                                      FadeTransition(
                                          opacity: anim, child: child),
                                  transitionDuration:
                                      const Duration(milliseconds: 300),
                                ),
                              );
                            },
                            icon: const Icon(Icons.print_rounded, size: 18),
                            label: Text(
                              'PRINT TICKET',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () => Navigator.of(context)
                                .popUntil((r) => r.isFirst),
                            child: Text(
                              'Return to Home',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReceiptSidebar extends StatelessWidget {
  final QueueTicket ticket;

  const _ReceiptSidebar({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: const BoxDecoration(
        color: AppColors.sidebarBg,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.local_hospital, color: AppColors.primary, size: 28),
          const SizedBox(height: 8),
          Text(
            'NMMC',
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'OPD Queue',
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          _sidebarItem(Icons.apartment, ticket.departmentName),
          const SizedBox(height: 8),
          _sidebarItem(Icons.medical_services,
              ticket.serviceName.replaceAll('\n', ' ')),
          const SizedBox(height: 8),
          _sidebarItem(Icons.person, ticket.doctorName),
          const SizedBox(height: 8),
          _sidebarItem(Icons.door_front_door, ticket.roomNumber),
        ],
      ),
    );
  }

  Widget _sidebarItem(IconData icon, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.tileUnavailable,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: AppColors.primary),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
