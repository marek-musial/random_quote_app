// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quoteslate_quote_remote_data_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuoteslateResponseImpl _$$QuoteslateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$QuoteslateResponseImpl(
      quote: json['quote'] as String,
      author: json['author'] as String?,
    );

Map<String, dynamic> _$$QuoteslateResponseImplToJson(
        _$QuoteslateResponseImpl instance) =>
    <String, dynamic>{
      'quote': instance.quote,
      'author': instance.author,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _QuoteslateQuoteRemoteRetrofitDataSource
    implements QuoteslateQuoteRemoteRetrofitDataSource {
  _QuoteslateQuoteRemoteRetrofitDataSource(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  }) {
    baseUrl ??= 'https://quoteslate.vercel.app';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<QuoteslateResponse> getQuoteData() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<QuoteslateResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/api/quotes/random',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late QuoteslateResponse _value;
    try {
      _value = QuoteslateResponse.fromJson(_result.data!);
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
