import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/api_param_constatnts.dart';
import '../../../../core/constants/app_endpoints.dart';
import '../../../../shared/data/models/failure.dart';
import '../../../../shared/data/network/call_api.dart';
import '../../../../shared/data/network/dio_client_service.dart';
import '../models/pharmasy_data_model.dart';

/// Remote API contract for the Pharmacy Management tab.
abstract class PharmasyRemoteDataSource {
  Future<Either<Failure, List<PharmasyDataModel>>> getPharmasyData();

  /// `Dashboard/verify?pharmacyId=` — marks the pharmacy as verified.
  Future<Either<Failure, Unit>> verifyPharmacy(String pharmacyId);

  /// `Dashboard/unverify?pharmacyId=` — removes the pharmacy's verification.
  Future<Either<Failure, Unit>> unverifyPharmacy(String pharmacyId);
}

/// Calls the dashboard pharmacy endpoints through the shared, authenticated
/// [DioClientService].
@LazySingleton(as: PharmasyRemoteDataSource)
class PharmasyRemoteDataSourceImpl implements PharmasyRemoteDataSource {
  // Injected by DI so this uses the app-wide client that carries the auth
  // token. Creating `DioClientService()` here made a second client with no
  // token, so the request was unauthorized and returned nothing.
  PharmasyRemoteDataSourceImpl(this._dioClientService);

  final DioClientService _dioClientService;

  @override
  Future<Either<Failure, List<PharmasyDataModel>>> getPharmasyData() {
    return callApiList(
      request: () {
        return _dioClientService.get(url: AppEndPoints.pharmacies);
      },
      mapItem: (Map<String, dynamic> data) {
        // TEMP DEBUG: prints every item's real keys/values so they can be
        // compared with the names PharmasyDataModel.fromJson reads. Long
        // strings (base64 logo/taxCard) are shortened to keep the log usable.
        debugPrint(
          '[PharmacyDebug] item: ${data.map((k, v) => MapEntry(k, v is String && v.length > 80 ? '<${v.length} chars>' : v))}',
        );
        return PharmasyDataModel.fromJson(data);
      },
    );
  }

  // Both responses are `{ message, success, data: bool }`. `data` only echoes
  // the new verified flag, which the caller already knows, so a 2xx is
  // treated as success and nothing is parsed (callApiNoData).
  // Both endpoints are PUT — POST returns 405 Method Not Allowed (checked
  // against the server: POST → 405, PUT → 401 without a token).
  @override
  Future<Either<Failure, Unit>> verifyPharmacy(String pharmacyId) {
    return callApiNoData(
      request: () => _dioClientService.put(
        url: AppEndPoints.verifyPharmacy,
        queryParameters: {ApiParamConstants.pharmacyId: pharmacyId},
      ),
    );
  }

  @override
  Future<Either<Failure, Unit>> unverifyPharmacy(String pharmacyId) {
    return callApiNoData(
      request: () => _dioClientService.put(
        url: AppEndPoints.unverifyPharmacy,
        queryParameters: {ApiParamConstants.pharmacyId: pharmacyId},
      ),
    );
  }
}
