import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/resume_model.dart';

class PdfExportService {
  /// Builds the vector PDF document conforming to the Neobrutalist design
  static Future<Uint8List> generatePdf(
    ResumeData data, [
    PdfPageFormat format = PdfPageFormat.a4,
  ]) async {
    final pdf = pw.Document(
      title: '${data.nameFirst} ${data.nameLast} - Resume',
      author: '${data.nameFirst} ${data.nameLast}',
    );

    // Load google fonts for PDF
    final fontHeading = await PdfGoogleFonts.plusJakartaSansBold();
    final fontMono = await PdfGoogleFonts.spaceMonoRegular();
    final fontMonoBold = await PdfGoogleFonts.spaceMonoBold();

    const inkColor = PdfColor.fromInt(0xFF111111);
    const cardBgColor = PdfColor.fromInt(0xFFDBD7CE);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Header Section
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: pw.BoxDecoration(
                    color: cardBgColor,
                    border: pw.Border.all(color: inkColor, width: 2),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        data.nameFirst.toUpperCase(),
                        style: pw.TextStyle(
                          font: fontHeading,
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          color: inkColor,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        data.nameLast.toUpperCase(),
                        style: pw.TextStyle(
                          font: fontMonoBold,
                          fontSize: 18,
                          color: inkColor,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(width: 24),
                pw.Expanded(
                  child: pw.Text(
                    data.bio,
                    style: pw.TextStyle(
                      font: fontMono,
                      fontSize: 10.5,
                      lineSpacing: 2,
                      color: inkColor,
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),

            // Experience Section
            _buildPdfSection(
              title: 'EXPERIENCE',
              fontHeading: fontHeading,
              inkColor: inkColor,
              content: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: data.experience.map((exp) {
                  return pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 12),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          exp.role,
                          style: pw.TextStyle(
                            font: fontMonoBold,
                            fontSize: 10.5,
                            decoration: pw.TextDecoration.underline,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          exp.company,
                          style: pw.TextStyle(
                            font: fontMono,
                            fontSize: 10,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          exp.period,
                          style: pw.TextStyle(
                            font: fontMonoBold,
                            fontSize: 10,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        ...exp.bullets.map(
                          (bullet) => pw.Padding(
                            padding:
                                const pw.EdgeInsets.only(left: 8, bottom: 3),
                            child: pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text('• ',
                                    style: pw.TextStyle(
                                        font: fontMonoBold, fontSize: 10)),
                                pw.Expanded(
                                  child: pw.Text(
                                    bullet,
                                    style: pw.TextStyle(
                                        font: fontMono, fontSize: 9.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            pw.SizedBox(height: 16),

            // Skills Section
            _buildPdfSection(
              title: 'CORE\nSKILLS',
              fontHeading: fontHeading,
              inkColor: inkColor,
              content: pw.Wrap(
                spacing: 6,
                runSpacing: 6,
                children: data.skills.map((skill) {
                  return pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: inkColor, width: 1.5),
                    ),
                    child: pw.Text(
                      skill,
                      style: pw.TextStyle(font: fontMono, fontSize: 9),
                    ),
                  );
                }).toList(),
              ),
            ),
            pw.SizedBox(height: 16),

            // Recent Projects
            _buildPdfSection(
              title: 'RECENT\nPROJECTS',
              fontHeading: fontHeading,
              inkColor: inkColor,
              content: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: data.projects.map((proj) {
                  return pw.Expanded(
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 12),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            proj.name,
                            style:
                                pw.TextStyle(font: fontHeading, fontSize: 10.5),
                          ),
                          pw.SizedBox(height: 2),
                          pw.Text(
                            proj.description,
                            style: pw.TextStyle(font: fontMono, fontSize: 9),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            pw.SizedBox(height: 16),

            // Education Section
            _buildPdfSection(
              title: 'EDUCATION',
              fontHeading: fontHeading,
              inkColor: inkColor,
              content: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: data.education.map((edu) {
                  return pw.Expanded(
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 12),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            edu.degree,
                            style:
                                pw.TextStyle(font: fontHeading, fontSize: 10),
                          ),
                          pw.SizedBox(height: 2),
                          pw.Text(
                            edu.institution,
                            style: pw.TextStyle(font: fontMono, fontSize: 9),
                          ),
                          pw.SizedBox(height: 2),
                          pw.Text(
                            edu.period,
                            style:
                                pw.TextStyle(font: fontMonoBold, fontSize: 8.5),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            pw.SizedBox(height: 16),

            // Certifications
            _buildPdfSection(
              title: 'CERTIFICATES',
              fontHeading: fontHeading,
              inkColor: inkColor,
              content: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: data.certifications.map((cert) {
                  return pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 4),
                    child: pw.Text(
                      '* ${cert.title} — ${cert.issuer} (${cert.year})',
                      style: pw.TextStyle(font: fontMono, fontSize: 9),
                    ),
                  );
                }).toList(),
              ),
            ),
            pw.SizedBox(height: 16),

            // Divider & Footer
            pw.Divider(color: inkColor, thickness: 0.5),
            pw.SizedBox(height: 6),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(data.contact.phone,
                    style: pw.TextStyle(font: fontMono, fontSize: 9)),
                pw.Text(data.contact.location,
                    style: pw.TextStyle(font: fontMono, fontSize: 9)),
                pw.Text(data.contact.email,
                    style: pw.TextStyle(font: fontMono, fontSize: 9)),
              ],
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildPdfSection({
    required String title,
    required pw.Font fontHeading,
    required PdfColor inkColor,
    required pw.Widget content,
  }) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 140,
          child: pw.Text(
            title,
            style: pw.TextStyle(
              font: fontHeading,
              fontSize: 12,
              decoration: pw.TextDecoration.underline,
              color: inkColor,
            ),
          ),
        ),
        pw.SizedBox(width: 20),
        pw.Expanded(child: content),
      ],
    );
  }

  /// Triggers the browser print modal
  static Future<void> printResume(ResumeData data) async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) => generatePdf(data, format),
      name: '${data.nameFirst}_${data.nameLast}_Resume',
    );
  }

  /// Triggers vector PDF file download/sharing
  static Future<void> shareOrDownloadPdf(ResumeData data) async {
    final pdfBytes = await generatePdf(data);
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: '${data.nameFirst}_${data.nameLast}_Resume.pdf',
    );
  }
}
