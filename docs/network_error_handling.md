# Network Error Handling Notes

## Purpose

This note explains how API errors move through the app, and why both
`call_api.dart` and `failure.dart` are needed.

## The Main Confusion

At first, it can look like this check in `call_api.dart` is enough:

```dart
if (status < 200 || status >= 300 || body is! Map<String, dynamic>) {
  return Left(Failure.fromResponse(response));
}
```

That check only runs when Dio returns a `Response` normally.

But Dio can also throw before `final response = await request();` completes.
For example, default Dio behavior throws `DioException.badResponse` for many
non-2xx status codes. In that case, the code jumps directly to `catch`.

## Two Backend Error Paths

Path 1: Dio returns a `Response`.

```dart
final response = await request();
return Left(Failure.fromResponse(response));
```

Path 2: Dio throws, but the backend response is inside the exception.

```dart
if (e is DioException && e.response != null) {
  return Failure.fromResponse(e.response!);
}
```

The JSON body is not what decides the path. Dio decides using `validateStatus`.
With the default behavior, `2xx` responses return normally and many non-2xx
responses throw `DioException.badResponse`.

## No-Internet Versus General Error

When Dio throws with no backend response, the app now checks real internet
reachability using `InternetConnectionUtility`.

If internet access is not available:

```dart
return const Failure(isNetwork: true);
```

The UI can then show the specific no-internet message.

If internet access is available, the app returns a generic failure:

```dart
return const Failure();
```

This covers cases such as server unreachable, DNS failure, timeout, SSL issue,
request cancellation, or unexpected exceptions. Those are transport or runtime
failures, but they are not confirmed no-internet cases.

## Final Flow

Data source calls `callApi`, `callApiList`, or `callApiNoData`.

If the request succeeds and the body shape is valid, the helper returns
`Right(model)`.

If Dio returns an error response normally, `call_api.dart` passes it to
`Failure.fromResponse(response)`.

If Dio throws and includes `e.response`, `Failure.fromException(e)` still passes
that response to `Failure.fromResponse(e.response!)`.

If Dio throws without `e.response`, the app checks internet access.

If there is no internet, the result is `Failure(isNetwork: true)`.

If there is internet, the result is `Failure()`, which becomes the generic error
message in the UI.

Repositories convert `Failure` into `AppError` using `failure.toAppError()`.

The UI resolves the final text through `AppError.localized(context)`.
