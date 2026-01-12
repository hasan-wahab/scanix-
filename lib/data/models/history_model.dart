class HistoryModel {
  final String? productName;
  final String? category;
  final String? scanType;
  final String? date;
  final String? data;

  HistoryModel({
    this.productName,
    this.category,
    this.scanType,
    this.data,
    this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'category': category,
      'scanType': scanType,
      'data': data,
      'date': date,
    };
  }

  factory HistoryModel.fromJson(Map<String, dynamic> map) {
    return HistoryModel(
      productName: map['productName'],
      category: map['category'],
      data: map['data'],
      date: map['date'],
      scanType: map['scanType'],
    );
  }
}
