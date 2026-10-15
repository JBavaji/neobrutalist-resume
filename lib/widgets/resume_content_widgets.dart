import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/resume_model.dart';
import '../theme/neobrutalist_theme.dart';
import 'custom_icons.dart';
import 'inline_editable_text.dart';

/// Skill Pill Widget
class SkillPillWidget extends StatelessWidget {
  final String skill;
  final bool isEditing;
  final ValueChanged<String>? onChanged;

  const SkillPillWidget({
    super.key,
    required this.skill,
    this.isEditing = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColors.ink, width: 1.8),
      ),
      child: InlineEditableText(
        text: skill,
        style: AppTypography.monoPill(),
        isEditing: isEditing,
        onChanged: (val) => onChanged?.call(val),
      ),
    );
  }
}

/// Experience Item Widget
class ExperienceItemWidget extends StatelessWidget {
  final ExperienceItem item;
  final bool isEditing;
  final ValueChanged<String>? onRoleChanged;
  final ValueChanged<String>? onCompanyChanged;
  final ValueChanged<String>? onPeriodChanged;
  final void Function(int index, String value)? onBulletChanged;

  const ExperienceItemWidget({
    super.key,
    required this.item,
    this.isEditing = false,
    this.onRoleChanged,
    this.onCompanyChanged,
    this.onPeriodChanged,
    this.onBulletChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: InlineEditableText(
                  text: '${item.role} | ${item.company}',
                  style: AppTypography.monoBody(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.5,
                  isEditing: isEditing,
                  onChanged: (val) {
                    final parts = val.split('|');
                    if (parts.length >= 2) {
                      onRoleChanged?.call(parts[0].trim());
                      onCompanyChanged?.call(parts.sublist(1).join('|').trim());
                    } else {
                      onRoleChanged?.call(val.trim());
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          InlineEditableText(
            text: item.period,
            style: AppTypography.monoBody(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
            isEditing: isEditing,
            onChanged: (val) => onPeriodChanged?.call(val),
          ),
          const SizedBox(height: 6),
          for (int i = 0; i < item.bullets.length; i++)
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: InlineEditableText(
                      text: item.bullets[i],
                      style: AppTypography.monoBody(
                        fontSize: 13.5,
                        height: 1.45,
                      ),
                      multiline: true,
                      isEditing: isEditing,
                      onChanged: (val) => onBulletChanged?.call(i, val),
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

/// Project Item Widget
class ProjectItemWidget extends StatelessWidget {
  final ProjectItem item;
  final bool isEditing;
  final ValueChanged<String>? onNameChanged;
  final ValueChanged<String>? onDescriptionChanged;

  const ProjectItemWidget({
    super.key,
    required this.item,
    this.isEditing = false,
    this.onNameChanged,
    this.onDescriptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InlineEditableText(
          text: item.name,
          style: AppTypography.headingSub(),
          isEditing: isEditing,
          onChanged: (val) => onNameChanged?.call(val),
        ),
        const SizedBox(height: 2),
        InlineEditableText(
          text: item.description,
          style: AppTypography.monoBody(fontSize: 13.5, height: 1.4),
          multiline: true,
          isEditing: isEditing,
          onChanged: (val) => onDescriptionChanged?.call(val),
        ),
      ],
    );
  }
}

/// Education Item Widget
class EducationItemWidget extends StatelessWidget {
  final EducationItem item;
  final bool isEditing;
  final ValueChanged<String>? onDegreeChanged;
  final ValueChanged<String>? onInstitutionChanged;
  final ValueChanged<String>? onPeriodChanged;

  const EducationItemWidget({
    super.key,
    required this.item,
    this.isEditing = false,
    this.onDegreeChanged,
    this.onInstitutionChanged,
    this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InlineEditableText(
          text: item.degree,
          style: AppTypography.headingSub(),
          isEditing: isEditing,
          onChanged: (val) => onDegreeChanged?.call(val),
        ),
        const SizedBox(height: 2),
        InlineEditableText(
          text: item.institution,
          style: AppTypography.monoBody(fontSize: 13.5, height: 1.4),
          isEditing: isEditing,
          onChanged: (val) => onInstitutionChanged?.call(val),
        ),
        const SizedBox(height: 2),
        InlineEditableText(
          text: item.period,
          style: AppTypography.monoBody(
              fontSize: 13.0, fontWeight: FontWeight.w700),
          isEditing: isEditing,
          onChanged: (val) => onPeriodChanged?.call(val),
        ),
      ],
    );
  }
}

/// Certification Item Widget
class CertificationItemWidget extends StatelessWidget {
  final CertificationItem item;
  final bool isEditing;
  final ValueChanged<String>? onTitleChanged;
  final ValueChanged<String>? onIssuerChanged;
  final ValueChanged<String>? onYearChanged;

  const CertificationItemWidget({
    super.key,
    required this.item,
    this.isEditing = false,
    this.onTitleChanged,
    this.onIssuerChanged,
    this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2, right: 10),
          child: AsteriskIconWidget(size: 18),
        ),
        Expanded(
          child: isEditing
              ? Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: InlineEditableText(
                        text: item.title,
                        style: AppTypography.monoBody(
                            fontSize: 13.0, fontWeight: FontWeight.bold),
                        isEditing: true,
                        onChanged: (val) => onTitleChanged?.call(val),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text('—'),
                    const SizedBox(width: 4),
                    Expanded(
                      flex: 2,
                      child: InlineEditableText(
                        text: item.issuer,
                        style: AppTypography.monoBody(fontSize: 13.0),
                        isEditing: true,
                        onChanged: (val) => onIssuerChanged?.call(val),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      flex: 1,
                      child: InlineEditableText(
                        text: item.year,
                        style: AppTypography.monoBody(fontSize: 13.0),
                        isEditing: true,
                        onChanged: (val) => onYearChanged?.call(val),
                      ),
                    ),
                  ],
                )
              : Text(
                  item.issuer.isNotEmpty
                      ? '${item.title} — ${item.issuer} (${item.year})'
                      : '${item.title} (${item.year})',
                  style: AppTypography.monoBody(fontSize: 13.0, height: 1.35),
                ),
        ),
      ],
    );
  }
}

/// Footer Widget with Contact Links
class ResumeFooterWidget extends StatelessWidget {
  final ContactInfo contact;
  final bool isMobile;
  final bool isEditing;
  final ValueChanged<String>? onPhoneChanged;
  final ValueChanged<String>? onLocationChanged;
  final ValueChanged<String>? onEmailChanged;
  final ValueChanged<String>? onLinkedinChanged;
  final ValueChanged<String>? onWebsiteChanged;

  const ResumeFooterWidget({
    super.key,
    required this.contact,
    required this.isMobile,
    this.isEditing = false,
    this.onPhoneChanged,
    this.onLocationChanged,
    this.onEmailChanged,
    this.onLinkedinChanged,
    this.onWebsiteChanged,
  });

  Future<void> _launchUrl(String urlString) async {
    final uri = Uri.tryParse(urlString);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          height: 1.0,
          color: AppColors.dividerColor,
        ),
        const SizedBox(height: 18),
        if (isMobile)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InlineEditableText(
                text: contact.phone,
                style: AppTypography.monoBody(fontSize: 12.5),
                isEditing: isEditing,
                onChanged: (val) => onPhoneChanged?.call(val),
              ),
              const SizedBox(height: 6),
              InlineEditableText(
                text: contact.location,
                style: AppTypography.monoBody(fontSize: 12.5),
                isEditing: isEditing,
                onChanged: (val) => onLocationChanged?.call(val),
              ),
              const SizedBox(height: 10),
              _buildLinks(),
            ],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: InlineEditableText(
                  text: contact.phone,
                  style: AppTypography.monoBody(fontSize: 12.5),
                  isEditing: isEditing,
                  onChanged: (val) => onPhoneChanged?.call(val),
                ),
              ),
              Expanded(
                child: InlineEditableText(
                  text: contact.location,
                  textAlign: TextAlign.center,
                  style: AppTypography.monoBody(fontSize: 12.5),
                  isEditing: isEditing,
                  onChanged: (val) => onLocationChanged?.call(val),
                ),
              ),
              Expanded(
                child: _buildLinks(),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildLinks() {
    if (isEditing) {
      return Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          InlineEditableText(
            text: contact.email,
            style: AppTypography.monoBody(fontSize: 12.5),
            isEditing: true,
            onChanged: (val) => onEmailChanged?.call(val),
          ),
          InlineEditableText(
            text: contact.linkedin,
            style: AppTypography.monoBody(fontSize: 12.5),
            isEditing: true,
            onChanged: (val) => onLinkedinChanged?.call(val),
          ),
          InlineEditableText(
            text: contact.website,
            style: AppTypography.monoBody(fontSize: 12.5),
            isEditing: true,
            onChanged: (val) => onWebsiteChanged?.call(val),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        if (contact.email.isNotEmpty)
          _linkButton(contact.email, 'mailto:${contact.email}'),
        if (contact.linkedin.isNotEmpty)
          _linkButton('linkedin.com/in/jbavaji', contact.linkedin),
        if (contact.website.isNotEmpty)
          _linkButton('jbavaji.github.io', contact.website),
      ],
    );
  }

  Widget _linkButton(String label, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(url),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(
            label,
            style: AppTypography.monoBody(fontSize: 12.5).copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
