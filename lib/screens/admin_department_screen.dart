import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_colors.dart';
import '../data/hospital_data.dart';
import '../models/department.dart';
import '../widgets/kiosk_widgets.dart';
import 'admin_service_screen.dart';

/// Figure 16F — Admin Department Page
class AdminDepartmentScreen extends StatefulWidget {
  const AdminDepartmentScreen({super.key});

  @override
  State<AdminDepartmentScreen> createState() => _AdminDepartmentScreenState();
}

class _AdminDepartmentScreenState extends State<AdminDepartmentScreen> {
  final List<Department> _departments = List.from(HospitalData.departments);
  int _selectedIndex = 0;

  void _toggleDept(int index, bool value) {
    setState(
      () => _departments[index] = _departments[index].copyWith(isActive: value),
    );
  }

  void _addDepartment() {
    showDialog(
      context: context,
      builder: (_) => _AddItemDialog(
        title: 'Add Department',
        hintText: 'Department name',
        onAdd: (name) {
          setState(() {
            _departments.add(
              Department(
                id: 'dept_${DateTime.now().millisecondsSinceEpoch}',
                name: name,
                shortName: name,
                isActive: true,
                services: [],
              ),
            );
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedDept = _departments.isNotEmpty
        ? _departments[_selectedIndex]
        : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF7),
      appBar: KioskAppBar(
        breadcrumb: 'Admin  ›  Department Management',
        onMenuTap: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: [
          _AdminTopBar(title: 'Department Management'),
          Expanded(
            child: Row(
              children: [
                // Left sidebar with dept list + add button + toggles
                Container(
                  width: 185,
                  decoration: const BoxDecoration(
                    color: AppColors.sidebarBg,
                    border: Border(right: BorderSide(color: AppColors.border)),
                  ),
                  child: Column(
                    children: [
                      // Add button
                      GestureDetector(
                        onTap: _addDepartment,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha(15),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.primary.withAlpha(60),
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                size: 18,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Add Dept',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 1, color: AppColors.border),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          itemCount: _departments.length,
                          separatorBuilder: (_, __) => const Divider(
                            height: 1,
                            indent: 12,
                            endIndent: 12,
                            color: AppColors.border,
                          ),
                          itemBuilder: (_, i) {
                            final dept = _departments[i];
                            final selected = i == _selectedIndex;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedIndex = i),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? AppColors.sidebarSelected
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        dept.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          fontWeight: selected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                          color: selected
                                              ? Colors.white
                                              : AppColors.textPrimary,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 0.75,
                                      child: Switch(
                                        value: dept.isActive,
                                        onChanged: (v) => _toggleDept(i, v),
                                        activeColor: selected
                                            ? Colors.white
                                            : AppColors.primaryLight,
                                        activeTrackColor: selected
                                            ? AppColors.primaryLight
                                            : AppColors.primaryDark,
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor: AppColors.border,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Main content — tiles for selected dept
                Expanded(
                  child: selectedDept == null
                      ? const SizedBox()
                      : _DeptTileGrid(
                          department: selectedDept,
                          onManageServices: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  AdminServiceScreen(department: selectedDept),
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

class _DeptTileGrid extends StatelessWidget {
  final Department department;
  final VoidCallback onManageServices;

  const _DeptTileGrid({
    required this.department,
    required this.onManageServices,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      department.isActive
                          ? 'Department is ACTIVE'
                          : 'Department is INACTIVE',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: department.isActive
                            ? AppColors.success
                            : AppColors.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: onManageServices,
                icon: const Icon(Icons.settings, size: 14),
                label: Text(
                  'Manage Services',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
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
              itemCount: department.services.length,
              itemBuilder: (_, i) {
                final svc = department.services[i];
                return ServiceTile(
                  label: svc.name,
                  isAvailable: svc.isAvailable,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _AdminTopBar extends StatelessWidget {
  final String title;

  const _AdminTopBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 4,
      color: AppColors.primary.withAlpha(40),
    );
  }
}

class _AddItemDialog extends StatefulWidget {
  final String title;
  final String hintText;
  final ValueChanged<String> onAdd;

  const _AddItemDialog({
    required this.title,
    required this.hintText,
    required this.onAdd,
  });

  @override
  State<_AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<_AddItemDialog> {
  final _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
      content: TextField(
        controller: _ctrl,
        autofocus: true,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        style: GoogleFonts.poppins(fontSize: 14),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: GoogleFonts.poppins(color: AppColors.textSecondary),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_ctrl.text.trim().isNotEmpty) {
              widget.onAdd(_ctrl.text.trim());
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Add',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
