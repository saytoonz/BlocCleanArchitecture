import 'package:mockito/mockito.dart';
import 'network_info_test.mocks.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_clean_architecture/core/platform/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfo;
  MockInternetConnectionChecker mockInternetConnectionChecker =
      MockInternetConnectionChecker();

  setUp(() {
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);

        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        // NOTICE: We're NOT awaiting the result
        final result = networkInfo.isConnected;
        // assert
        verify(mockInternetConnectionChecker.hasConnection);
        // Utilizing Dart's default referential equality.
        // Only references to the same object are equal.
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
