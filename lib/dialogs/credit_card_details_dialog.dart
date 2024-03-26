import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tele_communication_helper/dialogs/disable_user_interaction_dialog.dart';
import 'package:tele_communication_helper/models/credit_card.dart';
import 'package:tele_communication_helper/models/reload.dart';
import 'package:tele_communication_helper/screens/home_screen.dart';

class CreditCardDetailsDialog extends StatefulWidget {
  final String phoneNumer;
  final double amount;
  const CreditCardDetailsDialog(
      {super.key, required this.phoneNumer, required this.amount});

  @override
  State<CreditCardDetailsDialog> createState() =>
      _CreditCardDetailsDialogState();
}

class _CreditCardDetailsDialogState extends State<CreditCardDetailsDialog> {
  CreditCard? selectedCard;
  var cards = {'card1', 'card2', 'card3'};
  final TextEditingController _cardNumber = TextEditingController();
  final TextEditingController _expireDate = TextEditingController();
  final TextEditingController _cvcCode = TextEditingController();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<CreditCard> savedCards = [];

  bool doSave = false;
  bool isSavedCard = false;

  @override
  void initState() {
    getSavedCards();
    super.initState();
  }

  Future<List<CreditCard>> fetchCreditCards() async {
    List<CreditCard> creditCards = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('card').get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in querySnapshot.docs) {
        CreditCard card = CreditCard.fromFirestore(doc, null);
        creditCards.add(card);
      }
    } catch (e) {
      print('Error fetching credit cards: $e');
    }

    return creditCards;
  }

  void getSavedCards() async {
    savedCards = await fetchCreditCards();
    setState(() {});
  }

  void saveReloadDetails() async {
    showDialog(
        context: context,
        builder: ((context) => const DisableUserInteractionDialog()));

    if (doSave) {
      saveCardDetails();
    }

    try {
      Reload reload = Reload(
          cardNumber: _cardNumber.text,
          expireDate: _expireDate.text,
          cvc: _cvcCode.text,
          phoneNumber: widget.phoneNumer,
          amount: widget.amount,
          date: DateFormat('yyyy-MM-dd hh-mm a').format(DateTime.now()));

      final docRef = db
          .collection('reload')
          .withConverter(
            fromFirestore: Reload.fromFirestore,
            toFirestore: (Reload reload, options) => reload.toFirestore(),
          )
          .doc();
      await docRef.set(reload);

      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));

      showSuccessSnackBar('Realod Successfull');
    } catch (e) {
      Navigator.pop(context);
      showErrorSnackBar(e.toString());
    }
  }

  void saveCardDetails() async {
    try {
      CreditCard card = CreditCard(
        cardNumber: _cardNumber.text,
        expireDate: _expireDate.text,
        cvc: _cvcCode.text,
      );

      final docRef = db
          .collection('card')
          .withConverter(
            fromFirestore: CreditCard.fromFirestore,
            toFirestore: (CreditCard card, options) => card.toFirestore(),
          )
          .doc(_cardNumber.text);
      await docRef.set(card);
    } catch (e) {
      showErrorSnackBar(e.toString());
    }
  }

  void validateUserInput() {
    if (_cardNumber.text.isEmpty ||
        _expireDate.text.isEmpty ||
        _cvcCode.text.isEmpty) {
      showErrorSnackBar('Please fill out all the card details');
    } else if (_cardNumber.text.length != 16 ||
        !RegExp(r'^[0-9]+$').hasMatch(_cardNumber.text)) {
      showErrorSnackBar('Please enter valid card number');
    } else if (!RegExp(r'^[0-9]+/[0-9]+$').hasMatch(_expireDate.text)) {
      showErrorSnackBar('Please enter valid expire date');
    } else if (_cvcCode.text.length != 3 ||
        !RegExp(r'^[0-9]+$').hasMatch(_cvcCode.text)) {
      showErrorSnackBar('Please enter valid cvc code');
    } else {
      saveReloadDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                  child: Text(
                'Enter Payment Details',
                style: TextStyle(color: Color(0xff329BFC)),
              )),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel))
            ],
          ),
          titlePadding: const EdgeInsets.all(15.0),
          contentPadding: const EdgeInsets.all(15.0),
          actionsPadding: const EdgeInsets.all(15.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              savedCardsDropdown(),
              divider(),
              cardNumberInputField(_cardNumber),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: expireDateInputField(_expireDate)),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(child: cvcInputField(_cvcCode))
                ],
              ),
              saveCardcheckBox(),
              payButton()
            ],
          ),
        ));
  }

  Widget savedCardsDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.transparent),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: DropdownButtonFormField(
            value: selectedCard,
            decoration: InputDecoration.collapsed(
                hintText: "Select previously saved card",
                hintStyle: TextStyle(color: Colors.grey.shade500)),
            onChanged: (newValue) {
              setState(() {
                selectedCard = newValue!;
                if (selectedCard != null) {
                  _cardNumber.text = selectedCard!.cardNumber.toString();
                  _expireDate.text = selectedCard!.expireDate.toString();
                  _cvcCode.text = selectedCard!.cvc.toString();
                  isSavedCard = true;
                }
              });
            },
            items: savedCards
                .map<DropdownMenuItem<CreditCard>>((CreditCard value) {
              return DropdownMenuItem<CreditCard>(
                value: value,
                child: Text(value.cardNumber.toString()),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Divider(
            color: Color(0xff329BFC),
            thickness: 2,
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              'Or add card details',
              style: TextStyle(color: Color(0xff329BFC)),
            ),
          ),
          Expanded(
              child: Divider(
            color: Color(0xff329BFC),
            thickness: 2,
          ))
        ],
      ),
    );
  }

  Widget cardNumberInputField(controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.transparent),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 5),
              )
            ],
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: controller,
            maxLength: 16,
            decoration: InputDecoration(
                isCollapsed: true,
                counterText: '',
                border: InputBorder.none,
                hintText: 'Card Number',
                hintStyle: TextStyle(color: Colors.grey.shade500)),
          ),
        ),
      ),
    );
  }

  Widget expireDateInputField(controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.transparent),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 5),
              )
            ],
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: controller,
            maxLength: 5,
            decoration: InputDecoration(
                isCollapsed: true,
                counterText: '',
                border: InputBorder.none,
                hintText: 'Expire (MM/YY)',
                hintStyle: TextStyle(color: Colors.grey.shade500)),
          ),
        ),
      ),
    );
  }

  Widget cvcInputField(controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.transparent),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 5),
              )
            ],
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: controller,
            maxLength: 3,
            decoration: InputDecoration(
                isCollapsed: true,
                counterText: '',
                border: InputBorder.none,
                hintText: 'CVC',
                hintStyle: TextStyle(color: Colors.grey.shade500)),
          ),
        ),
      ),
    );
  }

  Widget payButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: () {
          validateUserInput();
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.transparent),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
              color: const Color(0xff329BFC)),
          child: const Text(
            'Pay',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget saveCardcheckBox() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Visibility(
        visible: !isSavedCard,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
                value: doSave,
                onChanged: (newValue) {
                  setState(() {
                    doSave = newValue!;
                  });
                }),
            Text(
              'Save card details for future payments',
              style: TextStyle(color: Colors.grey.shade500),
            )
          ],
        ),
      ),
    );
  }

  void showErrorSnackBar(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
  }

  void showSuccessSnackBar(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    ));
  }
}
