import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(
    varName: 'PexelsKey',
    obfuscate: true,
  )
  static final String pexelsApiKey = _Env.pexelsApiKey;
}
