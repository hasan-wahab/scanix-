class HistoryModel {
  final String? productName;
  final String? category;
  final String? scanType;
  final String? dateTime;
  final String? data;

  HistoryModel({
    this.productName,
    this.category,
    this.scanType,
    this.dateTime,
    this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'category': category,
      'scanType': scanType,
      'date': dateTime,
      'data': data,
    };
  }

  factory HistoryModel.fromJson(Map<String, dynamic> map) {
    return HistoryModel(
      productName: map['productName'],
      category: map['category'],
      dateTime: map['date'],
      data: map['data'],
      scanType: map['scanType'],
    );
  }
}
