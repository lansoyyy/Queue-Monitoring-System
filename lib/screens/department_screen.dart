import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_colors.dart';
import '../data/hospital_data.dart';
import '../models/department.dart';
import '../widgets/kiosk_widgets.dart';
import 'service_screen.dart';

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({super.key});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  int _selectedIndex = 0;

  List<Department> get _activeDepts =>
      HospitalData.departments.where((d) => d.isActive).toList();

  void _selectDept(int i) {
    setState(() => _selectedIndex = i);
  }

  void _openService(Department dept) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => ServiceScreen(department: dept),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final depts = _activeDepts;
    final selectedDept = depts.isNotEmpty ? depts[_selectedIndex] : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF7),
      appBar: KioskAppBar(
        breadcrumb: 'Select Department',
        onMenuTap: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: [
          Container(height: 4, color: AppColors.primary.withAlpha(40)),
          Expanded(
            child: Row(
              children: [
                // Sidebar
                DepartmentSidebar(
                  items: depts.map((d) => d.name).toList(),
                  selectedIndex: _selectedIndex,
                  onSelect: _selectDept,
                ),
                // Main content — grid of service preview tiles
                Expanded(
                  child: selectedDept == null
                      ? const Center(child: Text('No departments available'))
                      : _DeptOverviewGrid(
                          department: selectedDept,
                          onConfirm: () => _openService(selectedDept),
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

class _DeptOverviewGrid extends StatelessWidget {
  final Department department;
  final VoidCallback onConfirm;

  const _DeptOverviewGrid({
    required this.department,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final services = department.services;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header strip
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      department.name,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      '${services.where((s) => s.isAvailable).length} of ${services.length} services available',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: onConfirm,
                icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                label: Text(
                  'View Services',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.6,
              ),
              itemCount: services.length,
              itemBuilder: (_, i) {
                final svc = services[i];
                return ServiceTile(
                  label: svc.name,
                  isAvailable: svc.isAvailable,
                  onTap: onConfirm,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
