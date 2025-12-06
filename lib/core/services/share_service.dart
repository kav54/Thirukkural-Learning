import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../features/kural/domain/entities/kural.dart';

/// Service to handle sharing kurals and achievements
class ShareService {
  /// Share a kural as a beautiful quote card
  Future<void> shareKural(Kural kural, {BuildContext? context}) async {
    try {
      // Generate the quote card image
      final imageFile = await _generateQuoteCard(kural);
      
      // Share the image
      await Share.shareXFiles(
        [XFile(imageFile.path)],
        text: 'Thirukkural #${kural.number}\n\n${kural.line1Tamil}\n${kural.line2Tamil}\n\n${kural.meaningEnglish}',
        subject: 'Thirukkural #${kural.number}',
      );
    } catch (e) {
      print('Error sharing kural: $e');
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to share. Please try again.')),
        );
      }
    }
  }

  /// Share kural as text only
  Future<void> shareKuralText(Kural kural) async {
    await Share.share(
      'Thirukkural #${kural.number}\n\n'
      '${kural.line1Tamil}\n'
      '${kural.line2Tamil}\n\n'
      'Meaning:\n${kural.meaningEnglish}\n\n'
      '- From Thirukkural Learning App',
      subject: 'Thirukkural #${kural.number}',
    );
  }

  /// Share achievement/streak
  Future<void> shareAchievement({
    required String title,
    required String description,
    String? emoji,
  }) async {
    await Share.share(
      '${emoji ?? '🎉'} $title\n\n$description\n\n- Thirukkural Learning App',
      subject: title,
    );
  }

  /// Share streak milestone
  Future<void> shareStreak(int days) async {
    String message;
    String emoji;

    if (days >= 365) {
      message = 'I\'ve been learning Thirukkural for $days days straight! 🔥';
      emoji = '🏆';
    } else if (days >= 100) {
      message = 'I\'ve maintained a $days-day learning streak! 🔥';
      emoji = '💪';
    } else if (days >= 30) {
      message = 'I\'ve been learning Thirukkural for $days days! 🔥';
      emoji = '🌟';
    } else if (days >= 7) {
      message = 'I\'ve completed a $days-day learning streak! 🔥';
      emoji = '✨';
    } else {
      message = 'I\'m on a $days-day learning streak! 🔥';
      emoji = '🎯';
    }

    await shareAchievement(
      title: '$emoji $days-Day Streak!',
      description: message,
    );
  }

  /// Generate a beautiful quote card image
  Future<File> _generateQuoteCard(Kural kural) async {
    // Create a custom painter for the quote card
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = const Size(1080, 1920); // Instagram story size

    // Background gradient
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF8B5CF6),
        const Color(0xFF7C3AED),
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw decorative elements
    _drawDecorativeElements(canvas, size);

    // Draw kural number badge
    _drawKuralBadge(canvas, size, kural.number);

    // Draw kural text
    _drawKuralText(canvas, size, kural);

    // Draw meaning
    _drawMeaning(canvas, size, kural.meaningEnglish);

    // Draw app branding
    _drawBranding(canvas, size);

    // Convert to image
    final picture = recorder.endRecording();
    final image = await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    // Save to temporary file
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/kural_${kural.number}_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(bytes);

    return file;
  }

  void _drawDecorativeElements(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw decorative circles
    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.15),
      80,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.85),
      60,
      paint,
    );
  }

  void _drawKuralBadge(Canvas canvas, Size size, int kuralNumber) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.2),
        width: 200,
        height: 60,
      ),
      const Radius.circular(30),
    );

    canvas.drawRRect(rect, paint);

    // Draw text
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'KURAL #$kuralNumber',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        size.height * 0.2 - textPainter.height / 2,
      ),
    );
  }

  void _drawKuralText(Canvas canvas, Size size, Kural kural) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${kural.line1Tamil}\n${kural.line2Tamil}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.w700,
          height: 1.8,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 2,
    );

    textPainter.layout(maxWidth: size.width * 0.8);
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        size.height * 0.4,
      ),
    );
  }

  void _drawMeaning(Canvas canvas, Size size, String meaning) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: meaning,
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 28,
          fontStyle: FontStyle.italic,
          height: 1.5,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 4,
    );

    textPainter.layout(maxWidth: size.width * 0.85);
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        size.height * 0.65,
      ),
    );
  }

  void _drawBranding(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Thirukkural Learning',
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        size.height * 0.9,
      ),
    );
  }
}
