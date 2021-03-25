import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';

class FireBaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //funtion to change the format of date to DATEDDMMYYYY
  String dateFormat(DateTime dt) {
    String st = 'DATE';
    if (dt.day < 10) st += '0';
    st += dt.day.toString();
    if (dt.month < 10) st += '0';
    st += dt.month.toString();
    st += dt.year.toString();
    return st;
  }

  void getTeams() async {
    // getting snapshot of the slot to be booked, to know whether the document exists
    QuerySnapshot quesnap = await firestore.collection('Fantasy Results').get();
    // .doc('Dates')
    // .collection(dateFormat(date))
    // .doc(place)
    // .collection('Slots')
    // .doc('${slot.display()}')
    // .get();
    for (QueryDocumentSnapshot snap in quesnap.docs) snap.data();
    // if exists, read and store variables
    // if (docsnap.exists) {
    //   curr = docsnap.data()['current_slot'];
    //   maxnow = docsnap.data()['max_booking_index'];
    // }

    // making reference to that slot
    /*DocumentReference documentReference = firestore
        .collection('ProdLab Data')
        .doc('Dates')
        .collection(dateFormat(date))
        .doc(place)
        .collection('Slots')
        .doc('${slot.display()}');

    // getting snapshot of the place, to know whether the document exists
    docsnap = await firestore
        .collection('ProdLab Data')
        .doc('Dates')
        .collection(dateFormat(date))
        .doc(place)
        .get();

    //if existing,  update a field with key = email and value = slot + his index in that slot(that index should not be decremented when a slot is deleted)
    if (docsnap.exists) {
      await firestore
          .collection('ProdLab Data')
          .doc('Dates')
          .collection(dateFormat(date))
          .doc(place)
          .update({email: slot.display() + ' ${maxnow + 1}'});
    }
    // if not existing, make a new field
    else {
      await firestore
          .collection('ProdLab Data')
          .doc('Dates')
          .collection(dateFormat(date))
          .doc(place)
          .set({email: slot.display() + ' ${maxnow + 1}'});
    }

    //adding user to bookings collection
    await documentReference
        .collection('Bookings')
        .doc('${(1 + maxnow)}')
        .set({'user': email});

    //updating slot details
    await documentReference.set({
      'current_slot': curr + 1,
      'max_booking_index': maxnow + 1,
      'max_slot': 15
    });
  }

//same logic for the next 2 functions...

  void cancelSlot(Slot slot, String email, DateTime date, String place) async {
    email = email.replaceAll('.', '%');
    int curr = 0, index = 0;
    String indexString = '';
    DocumentSnapshot docsnap = await firestore
        .collection('ProdLab Data')
        .doc('Dates')
        .collection(dateFormat(date))
        .doc(place)
        .collection('Slots')
        .doc('${slot.display()}')
        .get();
    if (docsnap.exists) {
      curr = docsnap.data()['current_slot'];
    }
    docsnap = await firestore
        .collection('ProdLab Data')
        .doc('Dates')
        .collection(dateFormat(date))
        .doc(place)
        .get();
    if (docsnap.exists) {
      indexString = docsnap.data()[email];
      indexString = indexString.substring(14);
      index = int.tryParse(indexString);
      if (index == null) return;
    } else
      return;
    DocumentReference documentReference = firestore
        .collection('ProdLab Data')
        .doc('Dates')
        .collection(dateFormat(date))
        .doc(place)
        .collection('Slots')
        .doc('${slot.display()}');
    if (docsnap.exists) {
      await firestore
          .collection('ProdLab Data')
          .doc('Dates')
          .collection(dateFormat(date))
          .doc(place)
          .set({email: FieldValue.delete()}, SetOptions(merge: true));
      print('line 112');
    }
    docsnap =
        await documentReference.collection('Bookings').doc('$index').get();
    if (docsnap.exists)
      await documentReference.collection('Bookings').doc('$index').delete();
    await documentReference.update({'current_slot': curr - 1});
  }

  void changeSlot(String bookedSlot, Slot slot, String email, DateTime date,
      String place) async {
    email = email.replaceAll('.', '%');
    int curr = 0, booked = 0, index = 0, maxslot = 0;

    String indexString = '';
    DocumentSnapshot docsnap = await firestore
        .collection('ProdLab Data')
        .doc('Dates')
        .collection(dateFormat(date))
        .doc(place)
        .collection('Slots')
        .doc('${slot.display()}')
        .get();
    if (docsnap.exists) {
      curr = docsnap.data()['current_slot'];
      maxslot = docsnap.data()['max_booking_index'];
    }
    docsnap = await firestore
        .collection('ProdLab Data')
        .doc('Dates')
        .collection(dateFormat(date))
        .doc(place)
        .collection('Slots')
        .doc('$bookedSlot')
        .get();
    if (docsnap.exists) booked = docsnap.data()['current_slot'];

    docsnap = await firestore
        .collection('ProdLab Data')
        .doc('Dates')
        .collection(dateFormat(date))
        .doc(place)
        .get();
    if (docsnap.exists) {
      indexString = docsnap.data()[email];
      indexString = indexString.substring(14);
      index = int.tryParse(indexString);
      if (index == null) return;
    } else
      return;
    DocumentReference documentReference = firestore
        .collection('ProdLab Data')
        .doc('Dates')
        .collection(dateFormat(date))
        .doc(place);
    await documentReference.set(
        {email: slot.display() + ' ${maxslot + 1}'}, SetOptions(merge: true));
    await documentReference
        .collection('Slots')
        .doc('${slot.display()}')
        .collection('Bookings')
        .doc('${(1 + maxslot)}')
        .set({'user': email});
    await documentReference
        .collection('Slots')
        .doc('$bookedSlot')
        .collection('Bookings')
        .doc('$index')
        .delete();
    docsnap =
        await documentReference.collection('Slots').doc('$bookedSlot').get();
    if (docsnap.exists)
      await documentReference
          .collection('Slots')
          .doc('$bookedSlot')
          .update({'current_slot': booked - 1});
    await documentReference.collection('Slots').doc('${slot.display()}').set({
      'current_slot': curr + 1,
      'max_booking_index': maxslot + 1,
      'max_slot': 15
    });*/
  }
}
