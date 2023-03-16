import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'trivia_repo_impl_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_clean_architecture/core/errors/app_error.dart';
import 'package:bloc_clean_architecture/core/errors/exception.dart';
import 'package:bloc_clean_architecture/core/platform/network_info.dart';
import 'package:bloc_clean_architecture/features/trivial/data/models/trivia_model.dart';
import 'package:bloc_clean_architecture/features/trivial/domain/entities/trivia_entity.dart';
import 'package:bloc_clean_architecture/features/trivial/data/repositories/trivia_repo_impl.dart';
import 'package:bloc_clean_architecture/features/trivial/data/data_sources/trivia_local_data_source.dart';
import 'package:bloc_clean_architecture/features/trivial/data/data_sources/trivia_remote_data_source.dart';

@GenerateMocks([TriviaRemoteDataSource])
@GenerateMocks([TriviaLocalDataSource])
@GenerateMocks([NetworkInfo])
void main() {
  late TriviaRepoImpl repository;
  final mockRemoteDataSource = MockTriviaRemoteDataSource();
  final mockLocalDataSource = MockTriviaLocalDataSource();
  final mockNetworkInfo = MockNetworkInfo();

  setUp(() {
    repository = TriviaRepoImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestForOnline(Function() body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestForOffline(Function() body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getConcreteTrivia', () {
    const int testNumber = 1;
    const testTriviaModel = TriviaModel(
      number: testNumber,
      text: 'test trivia',
    );
    const TriviaEntity testTriviaEntity = testTriviaModel;

    // test(
    //   'should check if the device is online',
    //   () async {
    //     //arrange
    //     when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    //     //   // act
    //     repository.getConcreteTrivia(testNumber);
    //     //   // assert
    //     verify(mockNetworkInfo.isConnected);
    //   },
    // );

    runTestForOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getConcreteTrivia(testNumber))
              .thenAnswer((_) async => testTriviaModel);
          // act
          final result = await repository.getConcreteTrivia(testNumber);

          // assert
          verify(mockRemoteDataSource.getConcreteTrivia(testNumber));
          expect(result, equals(const Right(testTriviaEntity)));
        },
      );

      test(
        'should return cached data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getConcreteTrivia(testNumber))
              .thenAnswer((_) async => testTriviaModel);
          // act
          await repository.getConcreteTrivia(testNumber);

          // assert
          verify(mockRemoteDataSource.getConcreteTrivia(testNumber));
          verify(mockLocalDataSource.cacheTrivia(testTriviaModel));
        },
      );

      test(
        'should return server error when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getConcreteTrivia(testNumber))
              .thenThrow(ServerException());
          // act
          final result = await repository.getConcreteTrivia(testNumber);

          // assert
          // verifyZeroInteractions(mockLocalDataSource);
          verify(mockRemoteDataSource.getConcreteTrivia(testNumber));
          expect(result, equals(Left(ServerError())));
        },
      );
    });

    runTestForOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastTrivia())
              .thenAnswer((_) async => testTriviaModel);

          // act
          final result = await repository.getConcreteTrivia(testNumber);

          // assert
          // verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastTrivia());
          expect(result, equals(const Right(testTriviaEntity)));
        },
      );

      test(
        'should return CachedError when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastTrivia()).thenThrow(CacheException());

          // act
          final result = await repository.getConcreteTrivia(testNumber);

          // assert
          // verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastTrivia());
          expect(result, equals(Left(CacheError())));
        },
      );
    });
  });

  group('getRandomTrivia', () {
    const testTriviaModel = TriviaModel(
      number: 1,
      text: 'test trivia',
    );
    const TriviaEntity testTriviaEntity = testTriviaModel;

    // test(
    //   'should check if the device is online',
    //   () async {
    //     //arrange
    //     when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    //     //   // act
    //     repository.getConcreteTrivia(testNumber);
    //     //   // assert
    //     verify(mockNetworkInfo.isConnected);
    //   },
    // );

    runTestForOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomTrivia())
              .thenAnswer((_) async => testTriviaModel);
          // act
          final result = await repository.getRandomTrivia();

          // assert
          verify(mockRemoteDataSource.getRandomTrivia());
          expect(result, equals(const Right(testTriviaEntity)));
        },
      );

      test(
        'should return cached data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomTrivia())
              .thenAnswer((_) async => testTriviaModel);
          // act
          await repository.getRandomTrivia();

          // assert
          verify(mockRemoteDataSource.getRandomTrivia());
          verify(mockLocalDataSource.cacheTrivia(testTriviaModel));
        },
      );

      test(
        'should return server error when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomTrivia())
              .thenThrow(ServerException());
          // act
          final result = await repository.getRandomTrivia();

          // assert
          // verifyZeroInteractions(mockLocalDataSource);
          verify(mockRemoteDataSource.getRandomTrivia());
          expect(result, equals(Left(ServerError())));
        },
      );
    });

    runTestForOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastTrivia())
              .thenAnswer((_) async => testTriviaModel);

          // act
          final result = await repository.getRandomTrivia();

          // assert
          // verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastTrivia());
          expect(result, equals(const Right(testTriviaEntity)));
        },
      );

      test(
        'should return CachedError when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastTrivia()).thenThrow(CacheException());

          // act
          final result = await repository.getRandomTrivia();

          // assert
          // verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastTrivia());
          expect(result, equals(Left(CacheError())));
        },
      );
    });
  });
}
