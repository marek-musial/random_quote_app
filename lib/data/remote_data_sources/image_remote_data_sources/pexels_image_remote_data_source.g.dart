// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pexels_image_remote_data_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PexelsResponseImpl _$$PexelsResponseImplFromJson(Map<String, dynamic> json) =>
    _$PexelsResponseImpl(
      photos: (json['photos'] as List<dynamic>)
          .map((e) => PexelsPhoto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PexelsResponseImplToJson(
        _$PexelsResponseImpl instance) =>
    <String, dynamic>{
      'photos': instance.photos,
    };

_$PexelsPhotoImpl _$$PexelsPhotoImplFromJson(Map<String, dynamic> json) =>
    _$PexelsPhotoImpl(
      photographer: json['photographer'] as String?,
      sizes: PexelsSizes.fromJson(json['src'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PexelsPhotoImplToJson(_$PexelsPhotoImpl instance) =>
    <String, dynamic>{
      'photographer': instance.photographer,
      'src': instance.sizes,
    };

_$PexelsSizesImpl _$$PexelsSizesImplFromJson(Map<String, dynamic> json) =>
    _$PexelsSizesImpl(
      large: json['large'] as String,
    );

Map<String, dynamic> _$$PexelsSizesImplToJson(_$PexelsSizesImpl instance) =>
    <String, dynamic>{
      'large': instance.large,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _PexelsImageRemoteRetrofitDataSource
    implements PexelsImageRemoteRetrofitDataSource {
  _PexelsImageRemoteRetrofitDataSource(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  }) {
    baseUrl ??= 'https://api.pexels.com/v1/';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<PexelsResponse> getImageData({
    required int page,
    required int perPage,
    required String key,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'per_page': perPage,
    };
    final _headers = <String, dynamic>{r'Authorization': key};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<PexelsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/curated/',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late PexelsResponse _value;
    try {
      _value = PexelsResponse.fromJson(_result.data!);
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
