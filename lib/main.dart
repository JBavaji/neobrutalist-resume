import 'package:flutter/material.dart';
import 'models/resume_model.dart';
import 'services/resume_repository.dart';
import 'theme/neobrutalist_theme.dart';
import 'widgets/brutalist_badge.dart';
import 'widgets/resume_content_widgets.dart';
import 'widgets/section_row.dart';

void main() {
  runApp(const NeobrutalistResumeApp());
}

class NeobrutalistResumeApp extends StatelessWidget {
  const NeobrutalistResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jayeshgiri R. Bavaji - Neobrutalist Resume',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.canvasBg,
        useMaterial3: true,
      ),
      home: const ResumeScreen(),
    );
  }
}

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  ResumeData? _resumeData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await ResumeRepository.loadFromAsset(
        ResumeRepository.defaultAssetPath);
    setState(() {
      _resumeData = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _resumeData == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.ink),
        ),
      );
    }

    final data = _resumeData!;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 24,
              vertical: isMobile ? 20 : 36,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 840),
                child: Column(
                  children: [
                    // Main Neobrutalist Resume Card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(isMobile ? 20 : 36),
                        border: Border.all(color: const Color(0x0F000000)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x12000000), // rgba(0, 0, 0, 0.07)
                            offset: Offset(0, 16),
                            blurRadius: 40,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 20 : 64,
                        vertical: isMobile ? 32 : 56,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header (Sticker Badges & Bio)
                          _buildHeader(data, isMobile),
                          const SizedBox(height: 36),

                          // Experience Section
                          SectionRow(
                            title: 'EXPERIENCE',
                            isMobile: isMobile,
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (final exp in data.experience)
                                  ExperienceItemWidget(item: exp),
                              ],
                            ),
                          ),

                          // Core Skills Section
                          SectionRow(
                            title: 'CORE\nSKILLS',
                            isMobile: isMobile,
                            content: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                for (final skill in data.skills)
                                  SkillPillWidget(skill: skill),
                              ],
                            ),
                          ),

                          // Projects Section
                          if (data.projects.isNotEmpty)
                            SectionRow(
                              title: 'FEATURED\nPROJECTS',
                              isMobile: isMobile,
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0; i < data.projects.length; i++)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom:
                                            i < data.projects.length - 1 ? 16 : 0,
                                      ),
                                      child: ProjectItemWidget(
                                        item: data.projects[i],
                                      ),
                                    ),
                                ],
                              ),
                            ),

                          // Education Section
                          if (data.education.isNotEmpty)
                            SectionRow(
                              title: 'EDUCATION',
                              isMobile: isMobile,
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (final edu in data.education)
                                    EducationItemWidget(item: edu),
                                ],
                              ),
                            ),

                          // Certifications Section
                          if (data.certifications.isNotEmpty)
                            SectionRow(
                              title: 'CERTIFICA-\nTIONS',
                              isMobile: isMobile,
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0;
                                      i < data.certifications.length;
                                      i++)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom:
                                            i < data.certifications.length - 1
                                                ? 8
                                                : 0,
                                      ),
                                      child: CertificationItemWidget(
                                        item: data.certifications[i],
                                      ),
                                    ),
                                ],
                              ),
                            ),

                          // Footer with Contacts
                          ResumeFooterWidget(
                            contact: data.contact,
                            isMobile: isMobile,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(ResumeData data, bool isMobile) {
    final badgeWidget = BrutalistBadge(
      nameFirst: data.nameFirst,
      nameLast: data.nameLast,
    );

    final bioWidget = Padding(
      padding: EdgeInsets.only(top: isMobile ? 18 : 0, left: isMobile ? 0 : 4),
      child: Text(
        data.bio,
        style: AppTypography.monoBody(
          fontSize: 14.5,
          height: 1.55,
        ),
      ),
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          badgeWidget,
          bioWidget,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 310, child: badgeWidget),
        const SizedBox(width: 36),
        Expanded(child: bioWidget),
      ],
    );
  }
}
