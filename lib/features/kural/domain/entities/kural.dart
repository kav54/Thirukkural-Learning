import 'package:equatable/equatable.dart';

class Kural extends Equatable {
  final int number;
  final String line1Tamil;
  final String line2Tamil;
  final String meaningTamil;
  final String meaningEnglish;
  final int chapterNumber;
  final String chapterName;

  const Kural({
    required this.number,
    required this.line1Tamil,
    required this.line2Tamil,
    required this.meaningTamil,
    required this.meaningEnglish,
    required this.chapterNumber,
    required this.chapterName,
  });

  @override
  List<Object> get props => [
        number,
        line1Tamil,
        line2Tamil,
        meaningTamil,
        meaningEnglish,
        chapterNumber,
        chapterName,
      ];
}
