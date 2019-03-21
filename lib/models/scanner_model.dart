
class ScannerModel {
  String eanCode;
  DateTime date;
  String cDate;
  int id;

  ScannerModel({
    this.eanCode,
    this.date,
    this.cDate,
    this.id
  });

  factory ScannerModel.fromJson(Map<String, dynamic> parsedJson) {
    return ScannerModel(
      eanCode: parsedJson['eanCode'],
      date: parsedJson['date'],
      cDate: parsedJson['cDate'],
      id: parsedJson['id'],
    );
  }

  ScannerModel.fromMapObject(Map<String, dynamic> map) {
    this.eanCode = map['eanCode'];
    this.date = map['date'];
    this.cDate = map['cDate'];
    this.id = map['id'];
  }
}
