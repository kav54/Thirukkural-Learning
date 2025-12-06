import 'package:equatable/equatable.dart';

class Kural extends Equatable {
  final int number;
  final String line1Tamil;
  final String line2Tamil;
  final String meaningTamil;
  final String meaningEnglish;
  final int chapterNumber;
  final String chapterName;
  final bool isFavorite;

  const Kural({
    required this.number,
    required this.line1Tamil,
    required this.line2Tamil,
    required this.meaningTamil,
    required this.meaningEnglish,
    required this.chapterNumber,
    required this.chapterName,
    this.isFavorite = false,
  });

  Kural copyWith({
    int? number,
    String? line1Tamil,
    String? line2Tamil,
    String? meaningTamil,
    String? meaningEnglish,
    int? chapterNumber,
    String? chapterName,
    bool? isFavorite,
  }) {
    return Kural(
      number: number ?? this.number,
      line1Tamil: line1Tamil ?? this.line1Tamil,
      line2Tamil: line2Tamil ?? this.line2Tamil,
      meaningTamil: meaningTamil ?? this.meaningTamil,
      meaningEnglish: meaningEnglish ?? this.meaningEnglish,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      chapterName: chapterName ?? this.chapterName,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object> get props => [
        number,
        line1Tamil,
        line2Tamil,
        meaningTamil,
        meaningEnglish,
        chapterNumber,
        chapterName,
        isFavorite,
      ];
}
