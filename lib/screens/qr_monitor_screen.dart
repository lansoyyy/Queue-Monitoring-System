import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../core/constants/app_colors.dart';
import '../data/hospital_data.dart';
import '../widgets/kiosk_widgets.dart';

/// Figure 16E — QR Page: real-time queue monitor (accessed via scanned QR code)
class QrMonitorScreen extends StatefulWidget {
  final String? departmentId;
  final String? ticketNumber;
  final String? serviceName;

  const QrMonitorScreen({
    super.key,
    this.departmentId,
    this.ticketNumber,
    this.serviceName,
  });

  @override
  State<QrMonitorScreen> createState() => _QrMonitorScreenState();
}

class _QrMonitorScreenState extends State<QrMonitorScreen> {
  late Timer _refreshTimer;
  String _currentPatient = '0045';
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _currentPatient = HospitalData.currentPatientNumber;
    _now = DateTime.now();
    // Simulate live updates every 30s
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _refreshTimer.cancel();
    super.dispose();
  }

  String get _deptLabel {
    if (widget.departmentId == null) return 'OPD Queue Monitor';
    final dept = HospitalData.departments
        .where((d) => d.id == widget.departmentId)
        .firstOrNull;
    final svc = widget.serviceName ?? '';
    if (dept == null) return 'OPD Queue Monitor';
    return svc.isNotEmpty
        ? '${dept.shortName}  |  ${svc.replaceAll('\n', ' ')}'
        : dept.shortName;
  }

  String get _timeDisplay {
    final h = _now.hour.toString().padLeft(2, '0');
    final m = _now.minute.toString().padLeft(2, '0');
    final s = _now.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF7),
      appBar: KioskAppBar(
        breadcrumb: 'Queue Monitor',
        onMenuTap: () => Navigator.of(context).maybePop(),
      ),
      body: Column(
        children: [
          Container(height: 4, color: AppColors.primary.withAlpha(40)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar: dept label + time + QR
                  Row(
                    children: [
                      // Dept / Service chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(60),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          _deptLabel,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Time
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _timeDisplay,
                              style: GoogleFonts.robotoMono(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Small QR
                          QrImageView(
                            data:
                                'https://nmmc.queue/monitor?dept=${widget.departmentId ?? 'all'}',
                            version: QrVersions.auto,
                            size: 72,
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
                            'Scan to refresh',
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Current patient display
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Live indicator
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2ECC71),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'LIVE — Real-time Queue Monitor',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Current Patient label
                          Container(
                            width: 320,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withAlpha(80),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Current Patient:',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: 320,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withAlpha(80),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Text(
                              _currentPatient,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 52,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (widget.ticketNumber != null)
                            _myTicketBadge(widget.ticketNumber!),
                          const SizedBox(height: 16),
                          Text(
                            'Please proceed to ${HospitalData.roomAssignments[widget.departmentId] ?? 'the assigned room'} when your number is called.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _myTicketBadge(String number) {
    final myNum = int.tryParse(number) ?? 0;
    final currNum = int.tryParse(_currentPatient) ?? 0;
    final diff = myNum - currNum;
    final ahead = diff > 0
        ? '$diff patient${diff > 1 ? 's' : ''} ahead'
        : 'Your turn!';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: diff <= 0
            ? const Color(0xFF2ECC71)
            : AppColors.primaryLight.withAlpha(30),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: diff <= 0 ? const Color(0xFF2ECC71) : AppColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            diff <= 0 ? Icons.check_circle : Icons.timer_outlined,
            size: 16,
            color: diff <= 0 ? Colors.white : AppColors.primary,
          ),
          const SizedBox(width: 8),
          Text(
            'Your ticket: #${number.padLeft(4, '0')}  —  $ahead',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: diff <= 0 ? Colors.white : AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
