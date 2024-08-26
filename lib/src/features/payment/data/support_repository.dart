import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortune/src/features/payment/domain/purchase.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fortune/src/features/face_reading/domain/records.dart';

class SupportRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final String collection = 'purchases'; // 문서 ID를 상수로 관리

  Stream<List<Purchase>> purchaseStream() => db
      .collection(collection)
      .where('total_amount_charged', isNotEqualTo: '0.00')
      .snapshots()
      .asBroadcastStream()
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => Purchase.fromJson(doc.data())).toList(),
      );
}

final supportRepositoryProvider =
    Provider<SupportRepository>((ref) => SupportRepository());

final purchaseStreamProvider = StreamProvider<List<Purchase>>((ref) async* {
  yield* ref.read(supportRepositoryProvider).purchaseStream();
});
