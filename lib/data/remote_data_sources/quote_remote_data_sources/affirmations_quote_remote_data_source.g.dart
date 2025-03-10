// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'affirmations_quote_remote_data_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AffirmationsResponseImpl _$$AffirmationsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AffirmationsResponseImpl(
      affirmation: json['affirmation'] as String,
    );

Map<String, dynamic> _$$AffirmationsResponseImplToJson(
        _$AffirmationsResponseImpl instance) =>
    <String, dynamic>{
      'affirmation': instance.affirmation,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _AffirmationsQuoteRemoteRetrofitDataSource
    implements AffirmationsQuoteRemoteRetrofitDataSource {
  _AffirmationsQuoteRemoteRetrofitDataSource(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  }) {
    baseUrl ??= 'https://www.affirmations.dev/';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<AffirmationsResponse> getQuoteData() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<AffirmationsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late AffirmationsResponse _value;
    try {
      _value = AffirmationsResponse.fromJson(_result.data!);
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
