import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queue_monitoring_system/core/constants/app_colors.dart';

/// Top bar used across all kiosk screens (shows hospital name + progress bar + menu icon)
class KioskAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? breadcrumb;
  final bool showMenu;
  final VoidCallback? onMenuTap;
  final String? timeDisplay;

  const KioskAppBar({
    super.key,
    this.breadcrumb,
    this.showMenu = true,
    this.onMenuTap,
    this.timeDisplay,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // Decorative dots like wireframe
            Row(
              children: List.generate(
                3,
                (i) => Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: [
                      const Color(0xFFFF5F56),
                      const Color(0xFFFFBD2E),
                      const Color(0xFF27C93F),
                    ][i],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Breadcrumb / hospital name bar
            Expanded(
              child: Container(
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.backgroundDark,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: breadcrumb != null
                    ? Text(
                        breadcrumb!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    : Text(
                        'Northern Mindanao Medical Center — OPD Queue System',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            ),
            const SizedBox(width: 12),
            if (showMenu)
              GestureDetector(
                onTap: onMenuTap,
                child: const Icon(
                  Icons.menu,
                  color: AppColors.textSecondary,
                  size: 22,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Sidebar used across Department / Service selection screens
class DepartmentSidebar extends StatelessWidget {
  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final Widget? header;

  const DepartmentSidebar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      decoration: const BoxDecoration(
        color: AppColors.sidebarBg,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          if (header != null) ...[
            header!,
            const Divider(height: 1, color: AppColors.border),
          ],
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                indent: 12,
                endIndent: 12,
                color: AppColors.border,
              ),
              itemBuilder: (_, i) {
                final selected = i == selectedIndex;
                return GestureDetector(
                  onTap: () => onSelect(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.sidebarSelected
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      items[i],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: selected ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// A single service tile used in the grid
class ServiceTile extends StatelessWidget {
  final String label;
  final bool isAvailable;
  final bool isSelected;
  final VoidCallback? onTap;
  final Widget? trailing; // for admin toggle

  const ServiceTile({
    super.key,
    required this.label,
    required this.isAvailable,
    this.isSelected = false,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isSelected
        ? AppColors.primaryDark
        : isAvailable
        ? AppColors.tileActive
        : AppColors.tileUnavailable;

    final textColor = isAvailable ? Colors.white : AppColors.textSecondary;

    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          boxShadow: isAvailable
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(60),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                  if (!isAvailable)
                    Text(
                      'SERVICE NOT AVAILABLE',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textTertiary,
                        letterSpacing: 0.5,
                      ),
                    ),
                ],
              ),
            ),
            if (trailing != null)
              Positioned(top: 6, right: 6, child: trailing!),
          ],
        ),
      ),
    );
  }
}

/// Green pill button used for queue info display
class InfoPill extends StatelessWidget {
  final String label;
  final String value;

  const InfoPill({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(70),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
