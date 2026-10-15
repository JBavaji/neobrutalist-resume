import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/resume_model.dart';
import '../theme/neobrutalist_theme.dart';
import 'custom_icons.dart';

/// Skill Pill Widget
class SkillPillWidget extends StatelessWidget {
  final String skill;

  const SkillPillWidget({
    super.key,
    required this.skill,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColors.ink, width: 1.8),
      ),
      child: Text(
        skill,
        style: AppTypography.monoPill(),
      ),
    );
  }
}

/// Experience Item Widget
class ExperienceItemWidget extends StatelessWidget {
  final ExperienceItem item;

  const ExperienceItemWidget({
    super.key,
    required this.item,
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
                child: Text(
                  '${item.role} | ${item.company}',
                  style: AppTypography.monoBody(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ).copyWith(
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            item.period,
            style: AppTypography.monoBody(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
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
                    child: Text(
                      item.bullets[i],
                      style: AppTypography.monoBody(
                        fontSize: 13.5,
                        height: 1.45,
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

/// Project Item Widget
class ProjectItemWidget extends StatelessWidget {
  final ProjectItem item;

  const ProjectItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name,
          style: AppTypography.headingSub(),
        ),
        const SizedBox(height: 2),
        Text(
          item.description,
          style: AppTypography.monoBody(fontSize: 13.5, height: 1.4),
        ),
      ],
    );
  }
}

/// Education Item Widget
class EducationItemWidget extends StatelessWidget {
  final EducationItem item;

  const EducationItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.degree,
          style: AppTypography.headingSub(),
        ),
        const SizedBox(height: 2),
        Text(
          item.institution,
          style: AppTypography.monoBody(fontSize: 13.5, height: 1.4),
        ),
        const SizedBox(height: 2),
        Text(
          item.period,
          style: AppTypography.monoBody(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

/// Certification Item Widget
class CertificationItemWidget extends StatelessWidget {
  final CertificationItem item;

  const CertificationItemWidget({
    super.key,
    required this.item,
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
          child: Text(
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

  const ResumeFooterWidget({
    super.key,
    required this.contact,
    required this.isMobile,
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
              Text(
                contact.phone,
                style: AppTypography.monoBody(fontSize: 12.5),
              ),
              const SizedBox(height: 6),
              Text(
                contact.location,
                style: AppTypography.monoBody(fontSize: 12.5),
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
                child: Text(
                  contact.phone,
                  style: AppTypography.monoBody(fontSize: 12.5),
                ),
              ),
              Expanded(
                child: Text(
                  contact.location,
                  textAlign: TextAlign.center,
                  style: AppTypography.monoBody(fontSize: 12.5),
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
