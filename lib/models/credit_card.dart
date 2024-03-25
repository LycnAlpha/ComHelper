import 'package:cloud_firestore/cloud_firestore.dart';

class CreditCard {
  final String? cardNumber;
  final String? expireDate;
  final String? cvc;

  CreditCard({
    this.cardNumber,
    this.expireDate,
    this.cvc,
  });

  factory CreditCard.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return CreditCard(
      cardNumber: data?['cardNumber'],
      expireDate: data?['expireDate'],
      cvc: data?['cvc'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (cardNumber != null) "cardNumber": cardNumber,
      if (expireDate != null) "expireDate": expireDate,
      if (cvc != null) "cvc": cvc,
    };
  }
}
