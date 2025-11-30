import 'package:isar/isar.dart';
import '../../domain/entities/kural.dart';

part 'kural_model.g.dart';

@collection
class KuralModel {
  Id id = Isar.autoIncrement;

  @Index()
  late int number;
  
  late String line1Tamil;
  late String line2Tamil;
  late String meaningTamil;
  late String meaningEnglish;
  
  @Index()
  late int chapterNumber;
  
  late String chapterName;

  KuralModel();

  KuralModel.fromEntity(Kural kural) {
    number = kural.number;
    line1Tamil = kural.line1Tamil;
    line2Tamil = kural.line2Tamil;
    meaningTamil = kural.meaningTamil;
    meaningEnglish = kural.meaningEnglish;
    chapterNumber = kural.chapterNumber;
    chapterName = kural.chapterName;
  }

  factory KuralModel.fromJson(Map<String, dynamic> json) {
    return KuralModel()
      ..number = json['number'] as int
      ..line1Tamil = json['line1Tamil'] as String
      ..line2Tamil = json['line2Tamil'] as String
      ..meaningTamil = json['meaningTamil'] as String
      ..meaningEnglish = json['meaningEnglish'] as String
      ..chapterNumber = json['chapterNumber'] as int
      ..chapterName = json['chapterName'] as String;
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'line1Tamil': line1Tamil,
      'line2Tamil': line2Tamil,
      'meaningTamil': meaningTamil,
      'meaningEnglish': meaningEnglish,
      'chapterNumber': chapterNumber,
      'chapterName': chapterName,
    };
  }

  Kural toEntity() {
    return Kural(
      number: number,
      line1Tamil: line1Tamil,
      line2Tamil: line2Tamil,
      meaningTamil: meaningTamil,
      meaningEnglish: meaningEnglish,
      chapterNumber: chapterNumber,
      chapterName: chapterName,
    );
  }
}
