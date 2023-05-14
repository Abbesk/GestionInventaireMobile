import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inventaire_mobile/Models/Depot.dart';
import 'package:inventaire_mobile/Models/Inventaire.dart';
import '../Models/UserPV.dart';
import '../Models/UserSoc.dart';

class InventaireController extends GetxController {

  final _inventaires = RxList<Inventaire>([]);
  final _pvs = RxList<UserPV>([]);
  final _deps = RxList<Depot>([]);
  final _usersocs = RxList<UserSoc>([]);
  int? responseCode;
String baseURL="http://localhost:44328/api/";
  RxList<Inventaire> get inventaires => _inventaires;

  RxList<UserSoc> get usersocs => _usersocs;
  final storage = FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    fetchInventaires();
  }

  Future<Map<String, String>> getHeaders() async {
    final token = await storage.read(key: "jwt_token");
    return <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Access-Control-Allow-Origin': '*', // This is the cross-origin header
    };
  }


  Future<List<UserSoc>> fetchUserSocs() async {
    try {
      final token = (await storage.read(key: "jwt_token"))?.replaceAll('"', '');
      final codeuser = (await storage.read(key: "codeuser"));
      final url = 'http://localhost:44328/api/SocieteUser/GetusersocParUser?codeuser=';
      final encodedUrl = Uri.parse(url + codeuser!); // added token to the url
      final response = await http.get(
        encodedUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Access-Control-Allow-Origin': '*', // This is the cross-origin header
        },
      );
      if (response.statusCode == 200) {
        final Iterable jsonList = json.decode(response.body);
        final List<UserSoc> usersocs = [];
        usersocs.addAll(jsonList.map((model) => UserSoc.fromJson(model)));
        return usersocs;
      } else {
        // Handle authentication errors
        print('Failed to fetch usersocs due to authentication error');
        throw Exception(
            'Authentication error occurred while fetching inventaires');
      }
    } catch (e) {
      print('Failed to fetch usersocs due to $e');
      throw Exception('Failed to fetch usersocs due to $e');
    }
  }

//http://172.20.10.5:44328/api/
  Future<List<Inventaire>> fetchInventaires() async {
    try {
      final token = (await storage.read(key: "jwt_token"))?.replaceAll('"', '');
      final url = 'http://localhost:44328/api/Inventaire/GetInventaires';
      final encodedUrl = Uri.encodeFull(url);
      final response = await http.get(
        Uri.parse(encodedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Access-Control-Allow-Origin': '*', // This is the cross-origin header
        },
      );
      if (response.statusCode == 200) {
        final Iterable jsonList = json.decode(response.body);
        _inventaires.clear();
        _inventaires.addAll(
            jsonList.map((model) => Inventaire.fromJson(model)));
        return _inventaires;
      } else if (response.statusCode == 401) {
        // Handle authentication errors
        print('Failed to fetch inventaires due to authentication error');
        throw Exception(
            'Authentication error occurred while fetching inventaires');
      } else if (response.statusCode == 404) {
        // Handle not found errors
        print('Failed to fetch inventaires. Reason: ${response.reasonPhrase}');
        throw Exception('Inventaires not found');
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        // Handle server errors
        final errorMessage = response.reasonPhrase ?? 'Unknown error';
        print(
            'Failed to fetch inventaires due to server error. Reason: $errorMessage');
        throw Exception('Server error occurred while fetching inventaires');
      } else {
        // Handle other errors
        final errorMessage = response.reasonPhrase ?? 'Unknown error';
        print('Failed to fetch inventaires. Reason: $errorMessage');
        throw Exception('Unexpected error occurred while fetching inventaires');
      }
    } on SocketException catch (e) {
      // Handle network error
      print('Failed to fetch inventaires due to network error. Reason: $e');
      throw Exception('Network error occurred while fetching inventaires');
    } on TimeoutException catch (e) {
      // Handle timeout error
      print('Failed to fetch inventaires due to timeout error. Reason: $e');
      throw Exception('Timeout error occurred while fetching inventaires');
    } on Exception catch (e) {
      // Handle other exceptions
      print('Failed to fetch inventaires due to unexpected error. Reason: $e');
      throw Exception('Unexpected error occurred while fetching inventaires');
    }
  }


  Future<void> selectionnerArticles(String id, Inventaire invphysique) async {
    final url ='http://localhost:44328/api/Inventaire/SelectionnerArticles?id=$id';
    final token = (await storage.read(key: "jwt_token"))!.replaceAll('"', '');
    final encodedUrl = Uri.parse(url);

    final response = await http.put(
      encodedUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Access-Control-Allow-Origin': '*', // This is the cross-origin header
      },
      body: json.encode(invphysique.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update inventory: ${response.body}');
    }
  }

  Future<void> SaisiComptage(String id, Inventaire invphysique) async {
    final url = 'http://localhost:44328/api/Inventaire/SaisirComptagePhysique?id=$id';
    final token = (await storage.read(key: "jwt_token"))!.replaceAll('"', '');
    final encodedUrl = Uri.parse(url);

    final response = await http.put(
      encodedUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Access-Control-Allow-Origin': '*', // This is the cross-origin header
      },
      body: json.encode(invphysique.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update inventory: ${response.body}');
    }
  }

  Future<void> CloturerInventaire(String id, Inventaire invphysique) async {
    final url = 'http://localhost:44328/api/Inventaire/CloturerInventaire/?id=$id';
    final token = (await storage.read(key: "jwt_token"))!.replaceAll('"', '');
    final encodedUrl = Uri.parse(url);
    final response = await http.put(
      encodedUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Access-Control-Allow-Origin': '*', // This is the cross-origin header
      },
      body: json.encode(invphysique.toJson()),
    );

    if (response.statusCode != 200  ) {
      throw Exception('Failed to update inventory: ${response.body}');
    }
  }

  Future<String> getNouveauIndex() async {
    final token = (await storage.read(key: "jwt_token"))!.replaceAll('"', '');
    final response = await http.get(
      Uri.parse('http://localhost:44328/api/Inventaire/NouveauIndex'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Access-Control-Allow-Origin': '*', // This is the cross-origin header
      },);

    if (response.statusCode == 200) {
      // the API call was successful
      return json.decode(response.body);
    } else {
      // the API call failed
      throw Exception('Failed to load nouveau index');
    }
  }

  Future<void> CreerInventaire(Inventaire invphysique) async {
    final url = 'http://localhost:44328/api/Inventaire/Create';
    final token = (await storage.read(key: "jwt_token"))!.replaceAll('"', '');
    final encodedUrl = Uri.parse(url);

    final response = await http.post(
      encodedUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Access-Control-Allow-Origin': '*', // This is the cross-origin header
      },
      body: json.encode(invphysique.toJson()),
    );
    responseCode = response.statusCode;

    if (response.statusCode == 403) {
      print('HTTP error: ${response.statusCode}');

    } else {
      // Handle success case here
      print('HTTP success: ${response.statusCode}');
    }
  }


  Future<List<UserPV>> getAllPVS() async {
    try {
      String? codeuser = await storage.read(key: 'codeuser');
      final token = (await storage.read(key: "jwt_token"))?.replaceAll('"', '');
      final url = 'http://localhost:44328/api/UserPV/GetUtilisateurpvs?codeuser='+codeuser!;
      final encodedUrl = Uri.encodeFull(url);
      final response = await http.get(
        Uri.parse(encodedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Access-Control-Allow-Origin': '*', // This is the cross-origin header
        },
      );
      if (response.statusCode == 200) {
        final Iterable jsonList = json.decode(response.body);
        _pvs.clear();
        _pvs.addAll(
            jsonList.map((model) => UserPV.fromJson(model)));
        return _pvs;
      } else {
        // Handle authentication errors
        print('Failed to fetch point de ventes due to authentication error');
        throw Exception(
            'Authentication error occurred while fetching point de ventes');
      }
    } catch (e) {
      print('Failed to fetch point de ventes due to ${e.toString()}');
      throw Exception('Failed to fetch point de ventes due to ${e.toString()}');
    }
  }
  Future<List<Depot>> getAllDeps() async {
    try {
      final token = (await storage.read(key: "jwt_token"))?.replaceAll('"', '');
      final url = 'http://localhost:44328/api/Depot/GetAllDeps';
      final encodedUrl = Uri.encodeFull(url);
      final response = await http.get(
        Uri.parse(encodedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Access-Control-Allow-Origin': '*', // This is the cross-origin header
        },
      );
      if (response.statusCode == 200) {
        final Iterable jsonList = json.decode(response.body);
        _deps.clear();
        _deps.addAll(
            jsonList.map((model) => Depot.fromJson(model)));
        return _deps;
      } else {
        // Handle authentication errors
        print('Failed to fetch point de ventes due to authentication error');
        throw Exception(
            'Authentication error occurred while fetching point de ventes');
      }
    } catch (e) {
      print('Failed to fetch point de ventes due to ${e.toString()}');
      throw Exception('Failed to fetch point de ventes due to ${e.toString()}');
    }
  }
  Future<Inventaire> getInventaireById(String id) async {
    final token = (await storage.read(key: "jwt_token"))?.replaceAll('"', '');
    final response = await http.get(Uri.parse('http://localhost:44328/api/Inventaire/GetInventaireById/?id=$id') ,headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    'Access-Control-Allow-Origin': '*', // This is the cross-origin header
    },);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return Inventaire.fromJson(jsonDecode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load inventaire by ID');
    }
  }
  Future<List<Inventaire>> fetchInventairesNonClotures() async {
    try {
      final token = (await storage.read(key: "jwt_token"))?.replaceAll('"', '');
      final url = 'http://localhost:44328/api/Inventaire/InventairesNonClotures';
      final encodedUrl = Uri.encodeFull(url);
      final response = await http.get(
        Uri.parse(encodedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Access-Control-Allow-Origin': '*', // This is the cross-origin header
        },
      );
      if (response.statusCode == 200) {
        final Iterable jsonList = json.decode(response.body);
        _inventaires.clear();
        _inventaires.addAll(
            jsonList.map((model) => Inventaire.fromJson(model)));
        return _inventaires;
      } else if (response.statusCode == 401) {
        // Handle authentication errors
        print('Failed to fetch inventaires due to authentication error');
        throw Exception(
            'Authentication error occurred while fetching inventaires');
      } else if (response.statusCode == 404) {
        // Handle not found errors
        print('Failed to fetch inventaires. Reason: ${response.reasonPhrase}');
        throw Exception('Inventaires not found');
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        // Handle server errors
        final errorMessage = response.reasonPhrase ?? 'Unknown error';
        print(
            'Failed to fetch inventaires due to server error. Reason: $errorMessage');
        throw Exception('Server error occurred while fetching inventaires');
      } else {
        // Handle other errors
        final errorMessage = response.reasonPhrase ?? 'Unknown error';
        print('Failed to fetch inventaires. Reason: $errorMessage');
        throw Exception('Unexpected error occurred while fetching inventaires');
      }
    } on SocketException catch (e) {
      // Handle network error
      print('Failed to fetch inventaires due to network error. Reason: $e');
      throw Exception('Network error occurred while fetching inventaires');
    } on TimeoutException catch (e) {
      // Handle timeout error
      print('Failed to fetch inventaires due to timeout error. Reason: $e');
      throw Exception('Timeout error occurred while fetching inventaires');
    } on Exception catch (e) {
      // Handle other exceptions
      print('Failed to fetch inventaires due to unexpected error. Reason: $e');
      throw Exception('Unexpected error occurred while fetching inventaires');
    }
  }

}

