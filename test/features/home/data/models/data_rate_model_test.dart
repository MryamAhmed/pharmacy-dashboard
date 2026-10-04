import 'package:flutter_test/flutter_test.dart';
import 'package:pharmacy_app/features/home/data/models/data_rate_model.dart';
// import your DataRateModel here

void main() {
  //test is a function built into Flutter's test package , take a description and a callback and amethod that hold the test  code
  test('fromJson maps fields correctly', () {
    // Arrange: a JSON map shaped like what your API returns
    final json = <String, dynamic>{
      "id": "33966c51-5d07-41f6-b9de-76d6bfcba494",
      "comment": "was wonderfull2",
      "profilePicture": null,
      "reviewerName": "test teSt",
      "reviewerPosition": null,
      "rate": 4,
      "reviewerId": null,
      "revieweeId": null,
      "revieweeName": "manger mmm",
      "createdAt": "2026-09-10T00:29:47.3586339",
    };
    // Act ,What am I testing?
    //In this test the answer is: "Does my model convert JSON into a Dart object correctly?"
    final model = DataRateModel.fromJson(json);

    // Assert: one expect per field
    // ↑ what your code produced    ↑ what it SHOULD be
    expect(model.id, '33966c51-5d07-41f6-b9de-76d6bfcba494');
    expect(model.comment, 'was wonderfull2');
    expect(model.profilePicture, null);
    expect(model.reviewerName, "test teSt");
    expect(model.reviewerPosition, null);
    expect(model.rate, 4);
    expect(model.reviewerId, null);
    expect(model.revieweeId, null);
    expect(model.revieweeName, 'manger mmm');
    expect(model.createdAt, '2026-09-10T00:29:47.3586339');
  });
}
