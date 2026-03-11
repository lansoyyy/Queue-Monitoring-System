import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_colors.dart';
import '../models/department.dart';
import '../widgets/kiosk_widgets.dart';

/// Figure 16G — Admin Sub Service Page
class AdminServiceScreen extends StatefulWidget {
  final Department department;

  const AdminServiceScreen({super.key, required this.department});

  @override
  State<AdminServiceScreen> createState() => _AdminServiceScreenState();
}

class _AdminServiceScreenState extends State<AdminServiceScreen> {
  late List<ServiceItem> _services;

  @override
  void initState() {
    super.initState();
    _services = List.from(widget.department.services);
  }

  void _toggleService(int index, bool value) {
    setState(() =>
        _services[index] = _services[index].copyWith(isAvailable: value));
  }

  void _addService() {
    showDialog(
      context: context,
      builder: (_) => _AddServiceDialog(
        departmentId: widget.department.id,
        onAdd: (svc) => setState(() => _services.add(svc)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF7),
      appBar: KioskAppBar(
        breadcrumb:
            'Admin  ›  ${widget.department.shortName}  ›  Services',
        onMenuTap: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: [
          Container(height: 4, color: AppColors.primary.withAlpha(40)),
          // Sub-header
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            color: Colors.white,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColors.primary.withAlpha(50)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_back_ios_new,
                            size: 12, color: AppColors.primary),
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
                const Icon(Icons.chevron_right,
                    size: 16, color: AppColors.textTertiary),
                const SizedBox(width: 8),
                Text(
                  widget.department.shortName,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_services.where((s) => s.isAvailable).length} of ${_services.length} active',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          Expanded(
            child: Row(
              children: [
                // Left sidebar — service list with toggles
                Container(
                  width: 185,
                  decoration: const BoxDecoration(
                    color: AppColors.sidebarBg,
                    border: Border(
                        right: BorderSide(color: AppColors.border)),
                  ),
                  child: Column(
                    children: [
                      // Service list
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          itemCount: _services.length,
                          separatorBuilder: (_, __) => const Divider(
                              height: 1,
                              indent: 12,
                              endIndent: 12,
                              color: AppColors.border),
                          itemBuilder: (_, i) {
                            final svc = _services[i];
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      svc.name
                                          .replaceAll('\n', ' '),
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textPrimary,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: 0.75,
                                    child: Switch(
                                      value: svc.isAvailable,
                                      onChanged: (v) =>
                                          _toggleService(i, v),
                                      activeColor: AppColors.primaryLight,
                                      activeTrackColor: AppColors.primary,
                                      inactiveThumbColor: Colors.white,
                                      inactiveTrackColor: AppColors.border,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Main grid with add tile first
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
                      itemCount: _services.length + 1,
                      itemBuilder: (_, i) {
                        if (i == 0) {
                          // Add service tile
                          return GestureDetector(
                            onTap: _addService,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color:
                                      AppColors.primary.withAlpha(80),
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_circle_outline,
                                      size: 28,
                                      color: AppColors.primary
                                          .withAlpha(180)),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Add Service',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        final svc = _services[i - 1];
                        return ServiceTile(
                          label: svc.name,
                          isAvailable: svc.isAvailable,
                          trailing: Transform.scale(
                            scale: 0.7,
                            child: Switch(
                              value: svc.isAvailable,
                              onChanged: (v) => _toggleService(i - 1, v),
                              activeColor: Colors.white,
                              activeTrackColor: AppColors.primaryDark,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor:
                                  Colors.white.withAlpha(80),
                            ),
                          ),
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
    );
  }
}

class _AddServiceDialog extends StatefulWidget {
  final String departmentId;
  final ValueChanged<ServiceItem> onAdd;

  const _AddServiceDialog({
    required this.departmentId,
    required this.onAdd,
  });

  @override
  State<_AddServiceDialog> createState() => _AddServiceDialogState();
}

class _AddServiceDialogState extends State<_AddServiceDialog> {
  final _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add Service',
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
          hintText: 'Service name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        style: GoogleFonts.poppins(fontSize: 14),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel',
              style:
                  GoogleFonts.poppins(color: AppColors.textSecondary)),
        ),
        ElevatedButton(
          onPressed: () {
            if (_ctrl.text.trim().isNotEmpty) {
              widget.onAdd(ServiceItem(
                id: 'svc_${DateTime.now().millisecondsSinceEpoch}',
                name: _ctrl.text.trim(),
                departmentId: widget.departmentId,
                isAvailable: true,
              ));
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
          ),
          child: Text('Add',
              style:
                  GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
