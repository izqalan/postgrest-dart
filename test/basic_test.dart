import 'package:test/test.dart';
import 'package:postgrest/postgrest.dart';

void main() {
  String rootUrl = 'http://localhost:3000';
  var postgrest = PostgrestClient(rootUrl);

  test('basic select table', () async {
    var res = await postgrest.from('users').select().end();
    print(res['body']);
    expect(res['body'].length, 4);
  });

  test('stored procedure', () async {
    // TODO: KIV - what is dart equivelent for toMatchSnapshot
    var res = await postgrest.rpc('get_status', {'name_param': 'supabot'});
    print(res.body);
    expect(res.body.length, 1);
  });

  test('custom headers', () async {
    var postgrest = PostgrestClient(rootUrl, {
      'headers': {'apiKey': 'foo'}
    });
    var res = postgrest.from('users').select().headers['apiKey'].toString();
    expect(res, equals('foo'));
  });

  test('auth', () async {
    var postgrest = PostgrestClient(rootUrl).auth('foo');
    expect(postgrest.from('users').select().headers['Authorization'],
        equals('Bearer foo'));
  });

  test('switch schema', () async {
    var postgrest = PostgrestClient(rootUrl, {'schema': 'public'});
    var res = await postgrest.from('messages').select().end();
    print(res);
  });

  test('basic insert', () async {});

  test('upsert', () async {});

  test('bulk insert', () async {});

  test('basic delete', () async {});

  test('missing table', () async {});

  test('auth', () async {});
}
