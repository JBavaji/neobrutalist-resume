import 'package:flutter/material.dart';
import 'models/resume_model.dart';
import 'services/resume_repository.dart';
import 'theme/neobrutalist_theme.dart';
import 'widgets/brutalist_badge.dart';
import 'widgets/floating_toolbar.dart';
import 'widgets/inline_editable_text.dart';
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
      title: 'Jayeshgiri R. Bavajii - Neobrutalist Resume',
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
  bool _isUsingTemplate = false;
  bool _isEditing = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    if (!_isUsingTemplate) {
      final savedData = await ResumeRepository.loadSavedData();
      if (savedData != null) {
        setState(() {
          _resumeData = savedData;
          _isLoading = false;
        });
        return;
      }
    }

    final path = _isUsingTemplate
        ? ResumeRepository.templateAssetPath
        : ResumeRepository.defaultAssetPath;

    final data = await ResumeRepository.loadFromAsset(path);
    setState(() {
      _resumeData = data;
      _isLoading = false;
    });
  }

  void _onDataChanged(ResumeData updated) {
    setState(() => _resumeData = updated);
    ResumeRepository.saveData(updated);
  }

  void _toggleData() {
    _isUsingTemplate = !_isUsingTemplate;
    _loadData();
  }

  void _toggleEdit() {
    setState(() => _isEditing = !_isEditing);
  }

  Future<void> _resetData() async {
    await ResumeRepository.clearSavedData();
    _isUsingTemplate = false;
    await _loadData();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('↺ Resume content reset to default.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
                    // Sticky / Top Controls Toolbar
                    FloatingToolbar(
                      currentData: data,
                      isUsingTemplate: _isUsingTemplate,
                      isEditing: _isEditing,
                      onToggleData: _toggleData,
                      onToggleEdit: _toggleEdit,
                      onResetData: _resetData,
                    ),
                    const SizedBox(height: 24),

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
                                for (int i = 0; i < data.experience.length; i++)
                                  ExperienceItemWidget(
                                    item: data.experience[i],
                                    isEditing: _isEditing,
                                    onRoleChanged: (val) {
                                      final expList =
                                          List<ExperienceItem>.from(
                                              data.experience);
                                      expList[i] = ExperienceItem(
                                        role: val,
                                        company: expList[i].company,
                                        period: expList[i].period,
                                        bullets: expList[i].bullets,
                                      );
                                      _onDataChanged(
                                          data.copyWith(experience: expList));
                                    },
                                    onCompanyChanged: (val) {
                                      final expList =
                                          List<ExperienceItem>.from(
                                              data.experience);
                                      expList[i] = ExperienceItem(
                                        role: expList[i].role,
                                        company: val,
                                        period: expList[i].period,
                                        bullets: expList[i].bullets,
                                      );
                                      _onDataChanged(
                                          data.copyWith(experience: expList));
                                    },
                                    onPeriodChanged: (val) {
                                      final expList =
                                          List<ExperienceItem>.from(
                                              data.experience);
                                      expList[i] = ExperienceItem(
                                        role: expList[i].role,
                                        company: expList[i].company,
                                        period: val,
                                        bullets: expList[i].bullets,
                                      );
                                      _onDataChanged(
                                          data.copyWith(experience: expList));
                                    },
                                    onBulletChanged: (bIndex, bVal) {
                                      final expList =
                                          List<ExperienceItem>.from(
                                              data.experience);
                                      final bList = List<String>.from(
                                          expList[i].bullets);
                                      bList[bIndex] = bVal;
                                      expList[i] = ExperienceItem(
                                        role: expList[i].role,
                                        company: expList[i].company,
                                        period: expList[i].period,
                                        bullets: bList,
                                      );
                                      _onDataChanged(
                                          data.copyWith(experience: expList));
                                    },
                                  ),
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
                                for (int i = 0; i < data.skills.length; i++)
                                  SkillPillWidget(
                                    skill: data.skills[i],
                                    isEditing: _isEditing,
                                    onChanged: (val) {
                                      final skills =
                                          List<String>.from(data.skills);
                                      skills[i] = val;
                                      _onDataChanged(
                                          data.copyWith(skills: skills));
                                    },
                                  ),
                              ],
                            ),
                          ),

                          // Recent Projects Section
                          SectionRow(
                            title: 'RECENT\nPROJECTS',
                            isMobile: isMobile,
                            content: _buildTwoColumnGrid(
                              isMobile: isMobile,
                              children: [
                                for (int i = 0; i < data.projects.length; i++)
                                  ProjectItemWidget(
                                    item: data.projects[i],
                                    isEditing: _isEditing,
                                    onNameChanged: (val) {
                                      final proj = List<ProjectItem>.from(
                                          data.projects);
                                      proj[i] = ProjectItem(
                                        name: val,
                                        description: proj[i].description,
                                      );
                                      _onDataChanged(
                                          data.copyWith(projects: proj));
                                    },
                                    onDescriptionChanged: (val) {
                                      final proj = List<ProjectItem>.from(
                                          data.projects);
                                      proj[i] = ProjectItem(
                                        name: proj[i].name,
                                        description: val,
                                      );
                                      _onDataChanged(
                                          data.copyWith(projects: proj));
                                    },
                                  ),
                              ],
                            ),
                          ),

                          // Education Section
                          SectionRow(
                            title: 'EDUCATION',
                            isMobile: isMobile,
                            content: _buildTwoColumnGrid(
                              isMobile: isMobile,
                              children: [
                                for (int i = 0; i < data.education.length; i++)
                                  EducationItemWidget(
                                    item: data.education[i],
                                    isEditing: _isEditing,
                                    onDegreeChanged: (val) {
                                      final edu = List<EducationItem>.from(
                                          data.education);
                                      edu[i] = EducationItem(
                                        degree: val,
                                        institution: edu[i].institution,
                                        period: edu[i].period,
                                      );
                                      _onDataChanged(
                                          data.copyWith(education: edu));
                                    },
                                    onInstitutionChanged: (val) {
                                      final edu = List<EducationItem>.from(
                                          data.education);
                                      edu[i] = EducationItem(
                                        degree: edu[i].degree,
                                        institution: val,
                                        period: edu[i].period,
                                      );
                                      _onDataChanged(
                                          data.copyWith(education: edu));
                                    },
                                    onPeriodChanged: (val) {
                                      final edu = List<EducationItem>.from(
                                          data.education);
                                      edu[i] = EducationItem(
                                        degree: edu[i].degree,
                                        institution: edu[i].institution,
                                        period: val,
                                      );
                                      _onDataChanged(
                                          data.copyWith(education: edu));
                                    },
                                  ),
                              ],
                            ),
                          ),

                          // Certifications Section
                          SectionRow(
                            title: 'CERTIFICATIONS',
                            isMobile: isMobile,
                            bottomMargin: 16,
                            content: _buildTwoColumnGrid(
                              isMobile: isMobile,
                              children: [
                                for (int i = 0;
                                    i < data.certifications.length;
                                    i++)
                                  CertificationItemWidget(
                                    item: data.certifications[i],
                                    isEditing: _isEditing,
                                    onTitleChanged: (val) {
                                      final certs =
                                          List<CertificationItem>.from(
                                              data.certifications);
                                      certs[i] = CertificationItem(
                                        title: val,
                                        issuer: certs[i].issuer,
                                        year: certs[i].year,
                                      );
                                      _onDataChanged(
                                          data.copyWith(certifications: certs));
                                    },
                                    onIssuerChanged: (val) {
                                      final certs =
                                          List<CertificationItem>.from(
                                              data.certifications);
                                      certs[i] = CertificationItem(
                                        title: certs[i].title,
                                        issuer: val,
                                        year: certs[i].year,
                                      );
                                      _onDataChanged(
                                          data.copyWith(certifications: certs));
                                    },
                                    onYearChanged: (val) {
                                      final certs =
                                          List<CertificationItem>.from(
                                              data.certifications);
                                      certs[i] = CertificationItem(
                                        title: certs[i].title,
                                        issuer: certs[i].issuer,
                                        year: val,
                                      );
                                      _onDataChanged(
                                          data.copyWith(certifications: certs));
                                    },
                                  ),
                              ],
                            ),
                          ),

                          // Footer / Contact
                          ResumeFooterWidget(
                            contact: data.contact,
                            isMobile: isMobile,
                            isEditing: _isEditing,
                            onPhoneChanged: (val) => _onDataChanged(
                              data.copyWith(
                                contact: ContactInfo(
                                  phone: val,
                                  location: data.contact.location,
                                  email: data.contact.email,
                                  linkedin: data.contact.linkedin,
                                  website: data.contact.website,
                                ),
                              ),
                            ),
                            onLocationChanged: (val) => _onDataChanged(
                              data.copyWith(
                                contact: ContactInfo(
                                  phone: data.contact.phone,
                                  location: val,
                                  email: data.contact.email,
                                  linkedin: data.contact.linkedin,
                                  website: data.contact.website,
                                ),
                              ),
                            ),
                            onEmailChanged: (val) => _onDataChanged(
                              data.copyWith(
                                contact: ContactInfo(
                                  phone: data.contact.phone,
                                  location: data.contact.location,
                                  email: val,
                                  linkedin: data.contact.linkedin,
                                  website: data.contact.website,
                                ),
                              ),
                            ),
                            onLinkedinChanged: (val) => _onDataChanged(
                              data.copyWith(
                                contact: ContactInfo(
                                  phone: data.contact.phone,
                                  location: data.contact.location,
                                  email: data.contact.email,
                                  linkedin: val,
                                  website: data.contact.website,
                                ),
                              ),
                            ),
                            onWebsiteChanged: (val) => _onDataChanged(
                              data.copyWith(
                                contact: ContactInfo(
                                  phone: data.contact.phone,
                                  location: data.contact.location,
                                  email: data.contact.email,
                                  linkedin: data.contact.linkedin,
                                  website: val,
                                ),
                              ),
                            ),
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
      isEditing: _isEditing,
      onFirstNameChanged: (val) => _onDataChanged(data.copyWith(nameFirst: val)),
      onLastNameChanged: (val) => _onDataChanged(data.copyWith(nameLast: val)),
    );

    final bioWidget = Padding(
      padding: EdgeInsets.only(top: isMobile ? 18 : 0, left: isMobile ? 0 : 4),
      child: InlineEditableText(
        text: data.bio,
        style: AppTypography.monoBody(
          fontSize: 14.5,
          height: 1.55,
        ),
        multiline: true,
        isEditing: _isEditing,
        onChanged: (val) => _onDataChanged(data.copyWith(bio: val)),
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

  Widget _buildTwoColumnGrid({
    required bool isMobile,
    required List<Widget> children,
  }) {
    if (isMobile || children.length <= 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children
            .map((w) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: w,
                ))
            .toList(),
      );
    }

    // 2-Column layout on desktop
    final List<Widget> rows = [];
    for (int i = 0; i < children.length; i += 2) {
      final left = children[i];
      final right =
          (i + 1 < children.length) ? children[i + 1] : const SizedBox();
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: left),
              const SizedBox(width: 32),
              Expanded(child: right),
            ],
          ),
        ),
      );
    }

    return Column(children: rows);
  }
}
