// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advice_quote_remote_data_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdviceResponseImpl _$$AdviceResponseImplFromJson(Map<String, dynamic> json) =>
    _$AdviceResponseImpl(
      slip: AdviceSlip.fromJson(json['slip'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AdviceResponseImplToJson(
        _$AdviceResponseImpl instance) =>
    <String, dynamic>{
      'slip': instance.slip,
    };

_$AdviceSlipImpl _$$AdviceSlipImplFromJson(Map<String, dynamic> json) =>
    _$AdviceSlipImpl(
      advice: json['advice'] as String,
    );

Map<String, dynamic> _$$AdviceSlipImplToJson(_$AdviceSlipImpl instance) =>
    <String, dynamic>{
      'advice': instance.advice,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _AdviceQuoteRemoteRetrofitDataSource
    implements AdviceQuoteRemoteRetrofitDataSource {
  _AdviceQuoteRemoteRetrofitDataSource(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  }) {
    baseUrl ??= 'https://api.adviceslip.com';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<String> getQuoteData() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<String>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/advice',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<String>(_options);
    late String _value;
    try {
      _value = _result.data!;
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
