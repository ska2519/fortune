import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortune/src/features/face_reading/domain/records.dart';

class StatisticsRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final String collection = 'statistics'; // 문서 ID를 상수로 관리
  final String recordDocId = 'records'; // 문서 ID를 상수로 관리
  final String faceReadingsField = 'faceReadings'; // 필드명을 상수로 관리

  Future<void> updateCounts() async {
    try {
      await db.collection(collection).doc(recordDocId).update({
        faceReadingsField: FieldValue.increment(1),
        'remainingFaceReadings': FieldValue.increment(-1),
        "timestamp": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error incrementing face reading count: $e');
    }
  }

  Future<int> getFaceReadingsCount() async {
    final snapshot = await db.collection(collection).doc(recordDocId).get();
    return snapshot.data()?[faceReadingsField] ?? 0; // 데이터가 없을 경우 0으로 처리
  }

  Future<Records> getRecords() async {
    final snapshot = await db.collection(collection).doc(recordDocId).get();
    return Records.fromJson(snapshot.data() ?? {});
  }

  Stream<Records> recordsStream() => db
      .collection(collection)
      .doc(recordDocId)
      .snapshots()
      .asBroadcastStream()
      .map(
        (snapshot) => Records.fromJson(snapshot.data() ?? {}),
      ); // 데이터가 없을 경우 0으로 처리

  Stream<int> faceReadingsCountStream() => db
      .collection(collection)
      .doc(recordDocId)
      .snapshots()
      .asBroadcastStream()
      .map((snapshot) =>
          snapshot.data()?[faceReadingsField] ?? 0); // 데이터가 없을 경우 0으로 처리
}

final statisticsRepositoryProvider = Provider<StatisticsRepository>((ref) {
  return StatisticsRepository();
});

final faceReadingsStreamProvider = StreamProvider<int>((ref) async* {
  yield* ref.read(statisticsRepositoryProvider).faceReadingsCountStream();
});
final recordsStreamProvider = StreamProvider<Records>((ref) async* {
  yield* ref.read(statisticsRepositoryProvider).recordsStream();
});
