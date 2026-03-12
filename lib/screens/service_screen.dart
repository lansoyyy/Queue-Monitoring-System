import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_colors.dart';
import '../data/hospital_data.dart';
import '../models/department.dart';
import '../models/queue_ticket.dart';
import '../widgets/kiosk_widgets.dart';
import 'queue_info_screen.dart';

class ServiceScreen extends StatefulWidget {
  final Department department;

  const ServiceScreen({super.key, required this.department});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  int _selectedDeptIndex = 0;

  List<Department> get _depts => HospitalData.departments;

  Department get _activeDept {
    // Find department index for sidebar
    final idx = _depts.indexWhere((d) => d.id == widget.department.id);
    return _depts[_selectedDeptIndex < _depts.length
        ? _selectedDeptIndex
        : idx];
  }

  @override
  void initState() {
    super.initState();
    _selectedDeptIndex = _depts.indexWhere((d) => d.id == widget.department.id);
    if (_selectedDeptIndex < 0) _selectedDeptIndex = 0;
  }

  void _selectService(ServiceItem service) {
    final dept = _activeDept;
    final ticketNum = HospitalData.nextTicketNumber();
    final ticket = QueueTicket(
      ticketNumber: ticketNum.toString(),
      departmentName: dept.name,
      serviceName: service.name.replaceAll('\n', ' '),
      doctorName:
          HospitalData.doctorAssignments[dept.id] ?? 'On-Duty Physician',
      roomNumber: HospitalData.roomAssignments[dept.id] ?? 'Room TBA',
      issuedAt: DateTime.now(),
      qrData: 'https://nmmc.queue/monitor?dept=${dept.id}&ticket=$ticketNum',
    );

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => QueueInfoScreen(ticket: ticket),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dept = _activeDept;
    final services = dept.services;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF7),
      appBar: KioskAppBar(
        breadcrumb: dept.name,
        onMenuTap: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: [
          Container(height: 4, color: AppColors.primary.withAlpha(40)),
          Expanded(
            child: Row(
              children: [
                // Sidebar — shows departments; selected is highlighted
                DepartmentSidebar(
                  items: _depts.map((d) => d.name).toList(),
                  selectedIndex: _selectedDeptIndex,
                  onSelect: (i) => setState(() => _selectedDeptIndex = i),
                ),
                // Main grid
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sub-header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(color: AppColors.border),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Back chip
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withAlpha(15),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.primary.withAlpha(50),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.arrow_back_ios_new,
                                      size: 12,
                                      color: AppColors.primary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Departments',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              Icons.chevron_right,
                              size: 16,
                              color: AppColors.textTertiary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              dept.shortName,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Select a service to get your queue number',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Grid
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 14,
                                  crossAxisSpacing: 14,
                                  childAspectRatio: 1.4,
                                ),
                            itemCount: services.length,
                            itemBuilder: (_, i) {
                              final svc = services[i];
                              return ServiceTile(
                                label: svc.name,
                                isAvailable: svc.isAvailable,
                                onTap: () => _selectService(svc),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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
