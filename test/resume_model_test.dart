import 'package:flutter_test/flutter_test.dart';
import 'package:neobrutalist_resume/models/resume_model.dart';
import 'package:neobrutalist_resume/services/resume_repository.dart';

void main() {
  group('ResumeData Model Tests', () {
    test('Fallback data is valid and fully populated', () {
      final fallback = ResumeRepository.fallbackData;
      expect(fallback.nameFirst, 'JAYESHGIRI');
      expect(fallback.nameLast, 'BAVAJII');
      expect(fallback.experience.isNotEmpty, true);
      expect(fallback.skills.isNotEmpty, true);
      expect(fallback.projects.isNotEmpty, true);
      expect(fallback.education.isNotEmpty, true);
      expect(fallback.certifications.isNotEmpty, true);
      expect(fallback.contact.email, 'jbavaji@gmail.com');
    });

    test('JSON serialization round-trip retains all fields', () {
      final original = ResumeRepository.fallbackData;
      final jsonMap = original.toJson();
      final reconstructed = ResumeData.fromJson(jsonMap);

      expect(reconstructed.nameFirst, original.nameFirst);
      expect(reconstructed.nameLast, original.nameLast);
      expect(reconstructed.bio, original.bio);
      expect(reconstructed.experience.length, original.experience.length);
      expect(reconstructed.skills.length, original.skills.length);
      expect(reconstructed.projects.length, original.projects.length);
      expect(reconstructed.education.length, original.education.length);
      expect(
          reconstructed.certifications.length, original.certifications.length);
      expect(reconstructed.contact.email, original.contact.email);
    });

    test(
        'Handles empty and malformed JSON maps gracefully with default fallbacks',
        () {
      final empty = ResumeData.fromJson({});
      expect(empty.nameFirst, '');
      expect(empty.nameLast, '');
      expect(empty.bio, '');
      expect(empty.experience, isEmpty);
      expect(empty.skills, isEmpty);
      expect(empty.projects, isEmpty);
      expect(empty.education, isEmpty);
      expect(empty.certifications, isEmpty);
      expect(empty.contact.phone, '');
    });
  });
}
