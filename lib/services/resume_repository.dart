import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/resume_model.dart';

class ResumeRepository {
  static const String defaultAssetPath = 'assets/data/resume_data.json';
  static const String templateAssetPath =
      'assets/data/template_resume_data.json';
  static const String storageKey = 'neobrutalist_resume_saved_v1';

  /// Loads locally saved edits if available
  static Future<ResumeData?> loadSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedJson = prefs.getString(storageKey);
      if (savedJson != null && savedJson.isNotEmpty) {
        return ResumeData.fromJsonString(savedJson);
      }
    } catch (_) {}
    return null;
  }

  /// Saves edited resume data to persistent local storage
  static Future<void> saveData(ResumeData data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(storageKey, data.toJsonString());
    } catch (_) {}
  }

  /// Clears persistent edits and resets to defaults
  static Future<void> clearSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(storageKey);
    } catch (_) {}
  }

  /// Loads resume data from an asset JSON path with resilient fallback
  static Future<ResumeData> loadFromAsset(
      [String path = defaultAssetPath]) async {
    try {
      final jsonString = await rootBundle.loadString(path);
      return ResumeData.fromJsonString(jsonString);
    } catch (e) {
      // In case bundle is not available (e.g. pure unit tests without asset bundle), return fallback
      return fallbackData;
    }
  }

  /// Default in-memory fallback resume data
  static const ResumeData fallbackData = ResumeData(
    nameFirst: 'JAYESHGIRI',
    nameLast: 'BAVAJII',
    bio:
        "Hi, I'm JBavajii, an Engineering Manager & Technical Architect based in Pune, India with 14+ years building cross-platform mobile, web, and Agentic AI solutions across FinTech, InsurTech, and enterprise innovation.",
    experience: [
      ExperienceItem(
        role: 'Associate Specialist Technology (Lead)',
        company: 'Synechron',
        period: '2018 – Present (8+ Years)',
        bullets: [
          'Lead architecture and deployment for Sandbox Platform (enterprise cloud-native accelerator on Azure/Kubernetes with React 19) and InfraSec.AI.',
          'Architected FinTouch touchscreen collaboration platform (Flutter/Dart) and pioneered Synechron\'s first-of-kind Web3/Solana employee rewards app.',
          'Lead cross-functional engineering teams, establish CI/CD release pipelines, enforce quality gates, and bridge product vision with shipped code.',
        ],
      ),
      ExperienceItem(
        role: 'Software Engineer – Android',
        company: 'iCoderz Solutions',
        period: '2013 – 2018 (5 Years)',
        bullets: [
          'Architected and delivered 10+ Android applications end-to-end from concept to Google Play Store releases across consumer, B2B, and enterprise domains.',
          'Engineered real-time location tracking, Firebase cloud messaging, and robust multi-language localization features.',
        ],
      ),
    ],
    skills: [
      'Mobile & Cross-Platform (Flutter / React Native)',
      'Frontend & Web (React 19 / Tailwind / Redux)',
      'Agentic AI & LLMs',
      'Cloud & DevOps (Azure / Kubernetes / CI/CD)',
      'Technical Architecture & RBAC',
      'Agile Engineering Leadership',
    ],
    projects: [
      ProjectItem(
        name: 'Sandbox Platform',
        description:
            'Enterprise Kubernetes unified control plane on Azure with React 19, RBAC, cost governance & observability.',
      ),
      ProjectItem(
        name: 'FinTouch & InfraSec.AI',
        description:
            'Touchscreen collaboration platform (Flutter/Dart) & automated security monitoring reducing MTTR.',
      ),
    ],
    education: [
      EducationItem(
        degree: 'Master of Computer Applications (MCA)',
        institution: 'Saurashtra University, Rajkot',
        period: '2009 – 2012',
      ),
      EducationItem(
        degree: 'Bachelor of Computer Applications (BCA)',
        institution: 'Saurashtra University, Jamnagar',
        period: '2006 – 2009',
      ),
    ],
    certifications: [
      CertificationItem(
        title: 'GitHub Certified: Agentic AI Developer',
        issuer: 'GitHub',
        year: '2026',
      ),
      CertificationItem(
        title: 'Claude Code in Action',
        issuer: 'Anthropic',
        year: '2026',
      ),
      CertificationItem(
        title: 'Azure AI Engineer Associate',
        issuer: 'Microsoft',
        year: '2025',
      ),
      CertificationItem(
        title: 'Flutter & Dart: SOLID & Design Patterns',
        issuer: 'Udemy',
        year: '2024',
      ),
    ],
    contact: ContactInfo(
      phone: '+91 9601833544',
      location: 'Pune, Maharashtra, India',
      email: 'jbavaji@gmail.com',
      linkedin: 'https://linkedin.com/in/jbavaji',
      website: 'https://jbavaji.github.io',
    ),
  );
}
