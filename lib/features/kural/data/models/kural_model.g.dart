// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kural_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetKuralModelCollection on Isar {
  IsarCollection<KuralModel> get kuralModels => this.collection();
}

const KuralModelSchema = CollectionSchema(
  name: r'KuralModel',
  id: -6036968111495078799,
  properties: {
    r'chapterName': PropertySchema(
      id: 0,
      name: r'chapterName',
      type: IsarType.string,
    ),
    r'chapterNumber': PropertySchema(
      id: 1,
      name: r'chapterNumber',
      type: IsarType.long,
    ),
    r'isFavorite': PropertySchema(
      id: 2,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'line1Tamil': PropertySchema(
      id: 3,
      name: r'line1Tamil',
      type: IsarType.string,
    ),
    r'line2Tamil': PropertySchema(
      id: 4,
      name: r'line2Tamil',
      type: IsarType.string,
    ),
    r'meaningEnglish': PropertySchema(
      id: 5,
      name: r'meaningEnglish',
      type: IsarType.string,
    ),
    r'meaningTamil': PropertySchema(
      id: 6,
      name: r'meaningTamil',
      type: IsarType.string,
    ),
    r'number': PropertySchema(
      id: 7,
      name: r'number',
      type: IsarType.long,
    )
  },
  estimateSize: _kuralModelEstimateSize,
  serialize: _kuralModelSerialize,
  deserialize: _kuralModelDeserialize,
  deserializeProp: _kuralModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'number': IndexSchema(
      id: 5012388430481709372,
      name: r'number',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'number',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'chapterNumber': IndexSchema(
      id: -7659654328869413098,
      name: r'chapterNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'chapterNumber',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _kuralModelGetId,
  getLinks: _kuralModelGetLinks,
  attach: _kuralModelAttach,
  version: '3.1.0+1',
);

int _kuralModelEstimateSize(
  KuralModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.chapterName.length * 3;
  bytesCount += 3 + object.line1Tamil.length * 3;
  bytesCount += 3 + object.line2Tamil.length * 3;
  bytesCount += 3 + object.meaningEnglish.length * 3;
  bytesCount += 3 + object.meaningTamil.length * 3;
  return bytesCount;
}

void _kuralModelSerialize(
  KuralModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.chapterName);
  writer.writeLong(offsets[1], object.chapterNumber);
  writer.writeBool(offsets[2], object.isFavorite);
  writer.writeString(offsets[3], object.line1Tamil);
  writer.writeString(offsets[4], object.line2Tamil);
  writer.writeString(offsets[5], object.meaningEnglish);
  writer.writeString(offsets[6], object.meaningTamil);
  writer.writeLong(offsets[7], object.number);
}

KuralModel _kuralModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = KuralModel();
  object.chapterName = reader.readString(offsets[0]);
  object.chapterNumber = reader.readLong(offsets[1]);
  object.id = id;
  object.isFavorite = reader.readBool(offsets[2]);
  object.line1Tamil = reader.readString(offsets[3]);
  object.line2Tamil = reader.readString(offsets[4]);
  object.meaningEnglish = reader.readString(offsets[5]);
  object.meaningTamil = reader.readString(offsets[6]);
  object.number = reader.readLong(offsets[7]);
  return object;
}

P _kuralModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _kuralModelGetId(KuralModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _kuralModelGetLinks(KuralModel object) {
  return [];
}

void _kuralModelAttach(IsarCollection<dynamic> col, Id id, KuralModel object) {
  object.id = id;
}

extension KuralModelQueryWhereSort
    on QueryBuilder<KuralModel, KuralModel, QWhere> {
  QueryBuilder<KuralModel, KuralModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhere> anyNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'number'),
      );
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhere> anyChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'chapterNumber'),
      );
    });
  }
}

extension KuralModelQueryWhere
    on QueryBuilder<KuralModel, KuralModel, QWhereClause> {
  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause> numberEqualTo(
      int number) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'number',
        value: [number],
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause> numberNotEqualTo(
      int number) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'number',
              lower: [],
              upper: [number],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'number',
              lower: [number],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'number',
              lower: [number],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'number',
              lower: [],
              upper: [number],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause> numberGreaterThan(
    int number, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'number',
        lower: [number],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause> numberLessThan(
    int number, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'number',
        lower: [],
        upper: [number],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause> numberBetween(
    int lowerNumber,
    int upperNumber, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'number',
        lower: [lowerNumber],
        includeLower: includeLower,
        upper: [upperNumber],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause> chapterNumberEqualTo(
      int chapterNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'chapterNumber',
        value: [chapterNumber],
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause>
      chapterNumberNotEqualTo(int chapterNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterNumber',
              lower: [],
              upper: [chapterNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterNumber',
              lower: [chapterNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterNumber',
              lower: [chapterNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterNumber',
              lower: [],
              upper: [chapterNumber],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause>
      chapterNumberGreaterThan(
    int chapterNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'chapterNumber',
        lower: [chapterNumber],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause> chapterNumberLessThan(
    int chapterNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'chapterNumber',
        lower: [],
        upper: [chapterNumber],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterWhereClause> chapterNumberBetween(
    int lowerChapterNumber,
    int upperChapterNumber, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'chapterNumber',
        lower: [lowerChapterNumber],
        includeLower: includeLower,
        upper: [upperChapterNumber],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension KuralModelQueryFilter
    on QueryBuilder<KuralModel, KuralModel, QFilterCondition> {
  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      chapterNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      chapterNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapterName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      chapterNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapterName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      chapterNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapterName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      chapterNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chapterName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      chapterNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chapterName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      chapterNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chapterName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      chapterNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chapterName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      chapterNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterName',
        value: '',
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      chapterNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chapterName',
        value: '',
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      chapterNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      chapterNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapterNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      chapterNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapterNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      chapterNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapterNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> isFavoriteEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> line1TamilEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'line1Tamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      line1TamilGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'line1Tamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      line1TamilLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'line1Tamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> line1TamilBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'line1Tamil',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      line1TamilStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'line1Tamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      line1TamilEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'line1Tamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      line1TamilContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'line1Tamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> line1TamilMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'line1Tamil',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      line1TamilIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'line1Tamil',
        value: '',
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      line1TamilIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'line1Tamil',
        value: '',
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> line2TamilEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'line2Tamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      line2TamilGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'line2Tamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      line2TamilLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'line2Tamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> line2TamilBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'line2Tamil',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      line2TamilStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'line2Tamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      line2TamilEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'line2Tamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      line2TamilContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'line2Tamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> line2TamilMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'line2Tamil',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      line2TamilIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'line2Tamil',
        value: '',
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      line2TamilIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'line2Tamil',
        value: '',
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningEnglishEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meaningEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningEnglishGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'meaningEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningEnglishLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'meaningEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningEnglishBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'meaningEnglish',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningEnglishStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'meaningEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningEnglishEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'meaningEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningEnglishContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'meaningEnglish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningEnglishMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'meaningEnglish',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningEnglishIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meaningEnglish',
        value: '',
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningEnglishIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'meaningEnglish',
        value: '',
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningTamilEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meaningTamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningTamilGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'meaningTamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningTamilLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'meaningTamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningTamilBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'meaningTamil',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningTamilStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'meaningTamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningTamilEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'meaningTamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningTamilContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'meaningTamil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningTamilMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'meaningTamil',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningTamilIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meaningTamil',
        value: '',
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition>
      meaningTamilIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'meaningTamil',
        value: '',
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> numberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> numberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> numberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterFilterCondition> numberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'number',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension KuralModelQueryObject
    on QueryBuilder<KuralModel, KuralModel, QFilterCondition> {}

extension KuralModelQueryLinks
    on QueryBuilder<KuralModel, KuralModel, QFilterCondition> {}

extension KuralModelQuerySortBy
    on QueryBuilder<KuralModel, KuralModel, QSortBy> {
  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByChapterName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterName', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByChapterNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterName', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByChapterNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByLine1Tamil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'line1Tamil', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByLine1TamilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'line1Tamil', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByLine2Tamil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'line2Tamil', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByLine2TamilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'line2Tamil', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByMeaningEnglish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaningEnglish', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy>
      sortByMeaningEnglishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaningEnglish', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByMeaningTamil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaningTamil', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByMeaningTamilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaningTamil', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> sortByNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.desc);
    });
  }
}

extension KuralModelQuerySortThenBy
    on QueryBuilder<KuralModel, KuralModel, QSortThenBy> {
  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByChapterName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterName', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByChapterNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterName', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByChapterNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByLine1Tamil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'line1Tamil', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByLine1TamilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'line1Tamil', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByLine2Tamil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'line2Tamil', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByLine2TamilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'line2Tamil', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByMeaningEnglish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaningEnglish', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy>
      thenByMeaningEnglishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaningEnglish', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByMeaningTamil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaningTamil', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByMeaningTamilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaningTamil', Sort.desc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.asc);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QAfterSortBy> thenByNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.desc);
    });
  }
}

extension KuralModelQueryWhereDistinct
    on QueryBuilder<KuralModel, KuralModel, QDistinct> {
  QueryBuilder<KuralModel, KuralModel, QDistinct> distinctByChapterName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QDistinct> distinctByChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterNumber');
    });
  }

  QueryBuilder<KuralModel, KuralModel, QDistinct> distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<KuralModel, KuralModel, QDistinct> distinctByLine1Tamil(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'line1Tamil', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QDistinct> distinctByLine2Tamil(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'line2Tamil', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QDistinct> distinctByMeaningEnglish(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'meaningEnglish',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QDistinct> distinctByMeaningTamil(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'meaningTamil', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KuralModel, KuralModel, QDistinct> distinctByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'number');
    });
  }
}

extension KuralModelQueryProperty
    on QueryBuilder<KuralModel, KuralModel, QQueryProperty> {
  QueryBuilder<KuralModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<KuralModel, String, QQueryOperations> chapterNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterName');
    });
  }

  QueryBuilder<KuralModel, int, QQueryOperations> chapterNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterNumber');
    });
  }

  QueryBuilder<KuralModel, bool, QQueryOperations> isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<KuralModel, String, QQueryOperations> line1TamilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'line1Tamil');
    });
  }

  QueryBuilder<KuralModel, String, QQueryOperations> line2TamilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'line2Tamil');
    });
  }

  QueryBuilder<KuralModel, String, QQueryOperations> meaningEnglishProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meaningEnglish');
    });
  }

  QueryBuilder<KuralModel, String, QQueryOperations> meaningTamilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meaningTamil');
    });
  }

  QueryBuilder<KuralModel, int, QQueryOperations> numberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'number');
    });
  }
}
