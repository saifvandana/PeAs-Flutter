import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

main() async {
  var encrypt = 'q=ckQzSXFvVDdCTy9WYm9nVURxb1lVeGF6eU5YWWZnckw0YS96aXQ0MDZrc3hmbDd4STQzV1k0UGdmVGxnb3dHSldvMXBNMThuOExYWWhBPT0';
  var url = 'http://139.179.21.33/PeAsF/a.php?' + encrypt;
  final response = await http.Client().get(Uri.parse(url));

  if (response.statusCode == 200) {
    var document = parse(response.body);
    var par = document.getElementsByTagName("p")[12].children[0];
    print(par);
  }
  else{
    throw Exception();
  }
}