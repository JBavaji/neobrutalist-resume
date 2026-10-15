import 'dart:convert';

class ResumeData {
  final String nameFirst;
  final String nameLast;
  final String bio;
  final List<ExperienceItem> experience;
  final List<String> skills;
  final List<ProjectItem> projects;
  final List<EducationItem> education;
  final List<CertificationItem> certifications;
  final ContactInfo contact;

  const ResumeData({
    required this.nameFirst,
    required this.nameLast,
    required this.bio,
    required this.experience,
    required this.skills,
    required this.projects,
    required this.education,
    required this.certifications,
    required this.contact,
  });

  factory ResumeData.fromJson(Map<String, dynamic> json) {
    return ResumeData(
      nameFirst: json['nameFirst'] as String? ?? '',
      nameLast: json['nameLast'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      experience: (json['experience'] as List<dynamic>?)
              ?.map((e) => ExperienceItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      projects: (json['projects'] as List<dynamic>?)
              ?.map((e) => ProjectItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      education: (json['education'] as List<dynamic>?)
              ?.map((e) => EducationItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      certifications: (json['certifications'] as List<dynamic>?)
              ?.map(
                  (e) => CertificationItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      contact: ContactInfo.fromJson(
        json['contact'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameFirst': nameFirst,
      'nameLast': nameLast,
      'bio': bio,
      'experience': experience.map((e) => e.toJson()).toList(),
      'skills': skills,
      'projects': projects.map((e) => e.toJson()).toList(),
      'education': education.map((e) => e.toJson()).toList(),
      'certifications': certifications.map((e) => e.toJson()).toList(),
      'contact': contact.toJson(),
    };
  }

  ResumeData copyWith({
    String? nameFirst,
    String? nameLast,
    String? bio,
    List<ExperienceItem>? experience,
    List<String>? skills,
    List<ProjectItem>? projects,
    List<EducationItem>? education,
    List<CertificationItem>? certifications,
    ContactInfo? contact,
  }) {
    return ResumeData(
      nameFirst: nameFirst ?? this.nameFirst,
      nameLast: nameLast ?? this.nameLast,
      bio: bio ?? this.bio,
      experience: experience ?? this.experience,
      skills: skills ?? this.skills,
      projects: projects ?? this.projects,
      education: education ?? this.education,
      certifications: certifications ?? this.certifications,
      contact: contact ?? this.contact,
    );
  }

  String toJsonString() => jsonEncode(toJson());

  static ResumeData fromJsonString(String jsonString) {
    return ResumeData.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
  }
}

class ExperienceItem {
  final String role;
  final String company;
  final String period;
  final List<String> bullets;

  const ExperienceItem({
    required this.role,
    required this.company,
    required this.period,
    required this.bullets,
  });

  factory ExperienceItem.fromJson(Map<String, dynamic> json) {
    return ExperienceItem(
      role: json['role'] as String? ?? '',
      company: json['company'] as String? ?? '',
      period: json['period'] as String? ?? '',
      bullets: (json['bullets'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'company': company,
      'period': period,
      'bullets': bullets,
    };
  }
}

class ProjectItem {
  final String name;
  final String description;

  const ProjectItem({
    required this.name,
    required this.description,
  });

  factory ProjectItem.fromJson(Map<String, dynamic> json) {
    return ProjectItem(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}

class EducationItem {
  final String degree;
  final String institution;
  final String period;

  const EducationItem({
    required this.degree,
    required this.institution,
    required this.period,
  });

  factory EducationItem.fromJson(Map<String, dynamic> json) {
    return EducationItem(
      degree: json['degree'] as String? ?? '',
      institution: json['institution'] as String? ?? '',
      period: json['period'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
      'institution': institution,
      'period': period,
    };
  }
}

class CertificationItem {
  final String title;
  final String issuer;
  final String year;

  const CertificationItem({
    required this.title,
    required this.issuer,
    required this.year,
  });

  factory CertificationItem.fromJson(Map<String, dynamic> json) {
    return CertificationItem(
      title: json['title'] as String? ?? '',
      issuer: json['issuer'] as String? ?? '',
      year: json['year'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'issuer': issuer,
      'year': year,
    };
  }
}

class ContactInfo {
  final String phone;
  final String location;
  final String email;
  final String linkedin;
  final String website;

  const ContactInfo({
    required this.phone,
    required this.location,
    required this.email,
    required this.linkedin,
    required this.website,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      phone: json['phone'] as String? ?? '',
      location: json['location'] as String? ?? '',
      email: json['email'] as String? ?? '',
      linkedin: json['linkedin'] as String? ?? '',
      website: json['website'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'location': location,
      'email': email,
      'linkedin': linkedin,
      'website': website,
    };
  }
}
