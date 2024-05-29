class DeliveryOrder {
  final String? doNo;
  final String? date;
  final String? userId;
  final String? marketingPerson;
  final String? vendorName;
  final String? vendorAddress;
  final String? contactPerson;
  final String? vendorMobile;
  final List<List<dynamic>>? data;
  final dynamic? totalInWord;
  final String? deliveryDate;

  DeliveryOrder({
    this.doNo,
    this.date,
    this.userId,
    this.marketingPerson,
    this.vendorName,
    this.vendorAddress,
    this.contactPerson,
    this.vendorMobile,
    this.data,
    this.totalInWord,
    this.deliveryDate,
  });

  // Convert the DeliveryOrder object to a Map for Firebase storage
  Map<String, dynamic> toMap() {
    return {
      'doNo': doNo,
      'date': date,
      'userId': userId,
      'marketingPerson': marketingPerson,
      'vendorName': vendorName,
      'vendorAddress': vendorAddress,
      'contactPerson': contactPerson,
      'vendorMobile': vendorMobile,
      // 'data': data,
      'data': data!.map((list) => {'items': list}).toList(),

      'totalInWord': totalInWord,
      'deliveryDate': deliveryDate,
    };
  }

  // Create a DeliveryOrder object from a Map
  factory DeliveryOrder.fromMap(Map<String, dynamic> map) {
    return DeliveryOrder(
      doNo: map['doNo'],
      date: map['date'],
      userId: map['userId'],
      marketingPerson: map['marketingPerson'],
      vendorName: map['vendorName'],
      vendorAddress: map['vendorAddress'],
      contactPerson: map['contactPerson'],
      vendorMobile: map['vendorMobile'],
      data: List<List<dynamic>>.from(map['data']),
      totalInWord: map['totalInWord'],
      deliveryDate: map['deliveryDate'],
    );
  }
}
