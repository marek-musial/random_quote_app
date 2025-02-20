// coverage:ignore-file
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/image_remote_data_sources/cataas_image_remote_data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/image_remote_data_sources/pexels_image_remote_data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/image_remote_data_sources/picsum_image_remote_data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/advice_quote_remote_data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/affirmations_quote_remote_data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/kanye_quote_remote_data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_sources/quoteslate_quote_remote_data_source.dart';

import 'package:random_quote_app/core/injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class DioModule {
  @lazySingleton
  Dio dio() => Dio();
}

@module
abstract class RegisterModule {
  @lazySingleton
  PicsumImageRemoteDataSource get picsum => PicsumImageRemoteDataSource();

  @lazySingleton
  CataasImageRemoteDataSource get cataas => CataasImageRemoteDataSource();

  @lazySingleton
  PexelsImageRemoteDataSource get pexels => PexelsImageRemoteDataSource();

  @lazySingleton
  List<ImageDataSource> imageDataSources(
    PicsumImageRemoteDataSource picsum,
    CataasImageRemoteDataSource cataas,
    PexelsImageRemoteDataSource pexels,
  ) =>
      [
        picsum,
        cataas,
        pexels,
      ];

  @lazySingleton
  AdviceQuoteRemoteDataSource get advice => AdviceQuoteRemoteDataSource();

  @lazySingleton
  AffirmationsQuoteRemoteDataSource get affirmations => AffirmationsQuoteRemoteDataSource();

  @lazySingleton
  KanyeQuoteRemoteDataSource get kanye => KanyeQuoteRemoteDataSource();

  @lazySingleton
  QuoteslateQuoteRemoteDataSource get quoteslate => QuoteslateQuoteRemoteDataSource();

  @lazySingleton
  List<QuoteDataSource> quoteDataSources(
    AdviceQuoteRemoteDataSource advice,
    AffirmationsQuoteRemoteDataSource affirmations,
    KanyeQuoteRemoteDataSource kanye,
    QuoteslateQuoteRemoteDataSource quoteslate,
  ) =>
      [
        advice,
        affirmations,
        kanye,
        quoteslate,
      ];

  @lazySingleton
  List<DataSource> dataSources(
    List<ImageDataSource> imageDataSources,
    List<QuoteDataSource> quoteDataSources,
  ) =>
      [
        ...imageDataSources,
        ...quoteDataSources,
      ];

  @lazySingleton
  Map<String, DataSource> dataSourcesMap(
    List<DataSource> dataSources,
  ) =>
      {
        for (var ds in dataSources) (ds).title: ds,
      };
}
