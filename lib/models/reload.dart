import 'package:cloud_firestore/cloud_firestore.dart';

class Reload {
  final String? cardNumber;
  final String? expireDate;
  final String? cvc;
  final String? phoneNumber;
  final double? amount;
  final String? date;

  Reload({
    this.cardNumber,
    this.expireDate,
    this.cvc,
    this.phoneNumber,
    this.amount,
    this.date,
  });

  factory Reload.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Reload(
        cardNumber: data?['cardNumber'],
        expireDate: data?['expireDate'],
        cvc: data?['cvc'],
        phoneNumber: data?['phoneNumber'],
        amount: data?['amount'],
        date: data?['date']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (cardNumber != null) "cardNumber": cardNumber,
      if (expireDate != null) "expireDate": expireDate,
      if (cvc != null) "cvc": cvc,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      if (amount != null) "amount": amount,
      if (date != null) "date": date,
    };
  }
}
