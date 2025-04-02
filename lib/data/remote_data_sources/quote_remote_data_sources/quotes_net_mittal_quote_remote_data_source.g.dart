// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes_net_mittal_quote_remote_data_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuotesNetMittalResponseImpl _$$QuotesNetMittalResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$QuotesNetMittalResponseImpl(
      quote: json['quoteText'] as String,
      author: json['author'] as String?,
    );

Map<String, dynamic> _$$QuotesNetMittalResponseImplToJson(
        _$QuotesNetMittalResponseImpl instance) =>
    <String, dynamic>{
      'quoteText': instance.quote,
      'author': instance.author,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _QuotesNetMittalQuoteRemoteRetrofitDataSource
    implements QuotesNetMittalQuoteRemoteRetrofitDataSource {
  _QuotesNetMittalQuoteRemoteRetrofitDataSource(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  }) {
    baseUrl ??= 'https://florinbobis-quotes-net.hf.space';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<List<QuotesNetMittalResponse>> getQuoteData({
    required int pageNumber,
    required int pageSize,
    String dataset = 'mittal',
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'pageNumber': pageNumber,
      r'pageSize': pageSize,
      r'dataset': dataset,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<QuotesNetMittalResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/quotes',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<List<dynamic>>(_options);
    late List<QuotesNetMittalResponse> _value;
    try {
      _value = _result.data!
          .map((dynamic i) =>
              QuotesNetMittalResponse.fromJson(i as Map<String, dynamic>))
          .toList();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
