import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:random_quote_app/domain/models/quote_model.dart';

abstract class QuoteDataSource {
  Future<QuoteModel?> getQuoteData();
}

class KanyeQuoteRemoteDataSource implements QuoteDataSource {
  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final response = await Dio().get<Map<String, dynamic>>(
        'https://api.kanye.rest',
      );

      final json = response.data;

      if (json == null) {
        return null;
      }

      final quoteModel = QuoteModel(
        quote: json['quote'],
        author: 'Kanye West',
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Unknown error');
    }
  }
}

class AffirmationsQuoteRemoteDataSource implements QuoteDataSource {
  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final response = await Dio().get<Map<String, dynamic>>(
        'https://www.affirmations.dev/',
      );

      final json = response.data;

      if (json == null) {
        return null;
      }

      final quoteModel = QuoteModel(
        quote: json['affirmation'],
        author: null,
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Unknown error');
    }
  }
}

class BoredApiQuoteRemoteDataSource implements QuoteDataSource {
  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final response = await Dio().get<Map<String, dynamic>>(
        'https://www.boredapi.com/api/activity/',
      );

      final json = response.data;

      if (json == null) {
        return null;
      }

      if (json['error'] != null) {
        throw Exception(json['error']);
      }

      final quoteModel = QuoteModel(
        quote: json['activity'],
        author: null,
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Unknown error');
    }
  }
}

class AdviceQuoteRemoteDataSource implements QuoteDataSource {
  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final response = await Dio().get<String>(
        'https://api.adviceslip.com/advice',
      );

      final json = response.data;

      if (json == null) {
        return null;
      }
      final map = jsonDecode(json);

      final quoteModel = QuoteModel(
        quote: map['slip']['advice'],
        author: null,
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Unknown error');
    }
  }
}

class QuotableQuoteRemoteDataSource implements QuoteDataSource {
  @override
  Future<QuoteModel?> getQuoteData() async {
    try {
      final response = await Dio().get<List<dynamic>>(
        'https://api.quotable.io/quotes/random',
      );

      final jsons = response.data;
      if (jsons == null || jsons.isEmpty) {
        return null;
      }
      final Map<String, dynamic> json = jsons[0];

      final quoteModel = QuoteModel(
        quote: json['content'],
        author: json['author'],
      );
      return quoteModel;
    } on DioException catch (error) {
      throw Exception(error.response?.data ?? 'Unknown error');
    }
  }
}
