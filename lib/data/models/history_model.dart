class HistoryModel {
  final String? productName;
  final String? category;
  final String? scanType;
  final String? dateTime;
  final String? data;
  bool isSaved;

  HistoryModel({
    this.productName,
    this.category,
    this.scanType,
    this.dateTime,
    this.data,
    this.isSaved = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'category': category,
      'scanType': scanType,
      'date': dateTime,
      'data': data,
      'isSaved': isSaved,
    };
  }

  factory HistoryModel.fromJson(Map<String, dynamic> map) {
    return HistoryModel(
      productName: map['productName'],
      category: map['category'],
      dateTime: map['date'],
      data: map['data'],
      scanType: map['scanType'],
      isSaved: map['isSaved']??false,
    );
  }
}
