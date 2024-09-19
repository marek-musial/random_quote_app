// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:random_quote_app/core/injection_container.dart' as _i408;
import 'package:random_quote_app/data/dio_client.dart' as _i427;
import 'package:random_quote_app/data/remote_data_sources/image_remote_data_sources/cataas_image_remote_data_source.dart'
    as _i131;
import 'package:random_quote_app/data/remote_data_sources/image_remote_data_sources/pexels_image_remote_data_source.dart'
    as _i971;
import 'package:random_quote_app/data/remote_data_sources/image_remote_data_sources/picsum_image_remote_data_source.dart'
    as _i210;
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/advice_quote_remote_data_source.dart'
    as _i817;
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/affirmations_quote_remote_data_source.dart'
    as _i187;
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/kanye_quote_remote_data_source.dart'
    as _i1048;
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/quotable_quote_remote_data_source.dart'
    as _i201;
import 'package:random_quote_app/domain/repositories/image_repository.dart'
    as _i501;
import 'package:random_quote_app/domain/repositories/quote_repository.dart'
    as _i1031;
import 'package:random_quote_app/features/home/cubit/home_cubit.dart' as _i532;
import 'package:random_quote_app/features/root/cubit/root_cubit.dart' as _i701;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.factory<_i501.ImageRepository>(() => _i501.ImageRepository());
    gh.factory<_i1031.QuoteRepository>(() => _i1031.QuoteRepository());
    gh.factory<_i701.RootCubit>(() => _i701.RootCubit());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio());
    gh.factory<_i131.CataasImageRemoteRetrofitDataSource>(
        () => _i131.CataasImageRemoteRetrofitDataSource(gh<_i361.Dio>()));
    gh.factory<_i971.PexelsImageRemoteRetrofitDataSource>(
        () => _i971.PexelsImageRemoteRetrofitDataSource(gh<_i361.Dio>()));
    gh.factory<_i210.PicsumImageRemoteRetrofitDataSource>(
        () => _i210.PicsumImageRemoteRetrofitDataSource(gh<_i361.Dio>()));
    gh.factory<_i817.AdviceQuoteRemoteRetrofitDataSource>(
        () => _i817.AdviceQuoteRemoteRetrofitDataSource(gh<_i361.Dio>()));
    gh.factory<_i187.AffirmationsQuoteRemoteRetrofitDataSource>(
        () => _i187.AffirmationsQuoteRemoteRetrofitDataSource(gh<_i361.Dio>()));
    gh.factory<_i1048.KanyeQuoteRemoteRetrofitDataSource>(
        () => _i1048.KanyeQuoteRemoteRetrofitDataSource(gh<_i361.Dio>()));
    gh.factory<_i201.QuotableQuoteRemoteRetrofitDataSource>(
        () => _i201.QuotableQuoteRemoteRetrofitDataSource(gh<_i361.Dio>()));
    gh.singleton<_i427.DioClient>(() => _i427.DioClient(gh<_i361.Dio>()));
    gh.factory<_i532.HomeCubit>(() => _i532.HomeCubit(
          gh<_i501.ImageRepository>(),
          gh<_i1031.QuoteRepository>(),
        ));
    return this;
  }
}

class _$DioModule extends _i408.DioModule {}
