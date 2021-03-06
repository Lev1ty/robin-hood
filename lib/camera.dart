import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'the_people.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File _image;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 1600);

    setState(() {
      _image = image;
    });
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  String isAddress(Map line) {
    List streetSuffixes = [
      'ALLEY',
      'ALY',
      'ANEX',
      'ANX',
      'ARCADE',
      'ARC',
      'AVENUE',
      'AVE',
      'BAYOU',
      'BYU',
      'BEACH',
      'BCH',
      'BEND',
      'BND',
      'BLUFF',
      'BLF',
      'BLUFFS',
      'BLFS',
      'BOTTOM',
      'BTM',
      'BOULEVARD',
      'BLVD',
      'BRANCH',
      'BR',
      'BRIDGE',
      'BRG',
      'BROOK',
      'BRK',
      'BROOKS',
      'BRKS',
      'BURG',
      'BG',
      'BURGS',
      'BGS',
      'BYPASS',
      'BYP',
      'CAMP',
      'CP',
      'CANYON',
      'CYN',
      'CAPE',
      'CPE',
      'CAUSEWAY',
      'CSWY',
      'CENTER',
      'CTR',
      'CENTERS',
      'CTRS',
      'CIRCLE',
      'CIR',
      'CIRCLES',
      'CIRS',
      'CLIFF',
      'CLF',
      'CLIFFS',
      'CLFS',
      'CLUB',
      'CLB',
      'COMMON',
      'CMN',
      'COMMONS',
      'CMNS',
      'CORNER',
      'COR',
      'CORNERS',
      'CORS',
      'COURSE',
      'CRSE',
      'COURT',
      'CT',
      'COURTS',
      'CTS',
      'COVE',
      'CV',
      'COVES',
      'CVS',
      'CREEK',
      'CRK',
      'CRESCENT',
      'CRES',
      'CREST',
      'CRST',
      'CROSSING',
      'XING',
      'CROSSROAD',
      'XRD',
      'CROSSROADS',
      'XRDS',
      'CURVE',
      'CURV',
      'DALE',
      'DL',
      'DAM',
      'DM',
      'DIVIDE',
      'DV',
      'DRIVE',
      'DR',
      'DRIVES',
      'DRS',
      'ESTATE',
      'EST',
      'ESTATES',
      'ESTS',
      'EXPRESSWAY',
      'EXPY',
      'EXTENSION',
      'EXT',
      'EXTENSIONS',
      'EXTS',
      'FALL',
      'FALL',
      'FALLS',
      'FLS',
      'FERRY',
      'FRY',
      'FIELD',
      'FLD',
      'FIELDS',
      'FLDS',
      'FLAT',
      'FLT',
      'FLATS',
      'FLTS',
      'FORD',
      'FRD',
      'FORDS',
      'FRDS',
      'FOREST',
      'FRST',
      'FORGE',
      'FRG',
      'FORGES',
      'FRGS',
      'FORK',
      'FRK',
      'FORKS',
      'FRKS',
      'FORT',
      'FT',
      'FREEWAY',
      'FWY',
      'GARDEN',
      'GDN',
      'GARDENS',
      'GDNS',
      'GATEWAY',
      'GTWY',
      'GLEN',
      'GLN',
      'GLENS',
      'GLNS',
      'GREEN',
      'GRN',
      'GREENS',
      'GRNS',
      'GROVE',
      'GRV',
      'GROVES',
      'GRVS',
      'HARBOR',
      'HBR',
      'HARBORS',
      'HBRS',
      'HAVEN',
      'HVN',
      'HEIGHTS',
      'HTS',
      'HIGHWAY',
      'HWY',
      'HILL',
      'HL',
      'HILLS',
      'HLS',
      'HOLLOW',
      'HOLW',
      'INLET',
      'INLT',
      'ISLAND',
      'IS',
      'ISLANDS',
      'ISS',
      'ISLE',
      'ISLE',
      'JUNCTION',
      'JCT',
      'JUNCTIONS',
      'JCTS',
      'KEY',
      'KY',
      'KEYS',
      'KYS',
      'KNOLL',
      'KNL',
      'KNOLLS',
      'KNLS',
      'LAKE',
      'LK',
      'LAKES',
      'LKS',
      'LAND',
      'LAND',
      'LANDING',
      'LNDG',
      'LANE',
      'LN',
      'LIGHT',
      'LGT',
      'LIGHTS',
      'LGTS',
      'LOAF',
      'LF',
      'LOCK',
      'LCK',
      'LOCKS',
      'LCKS',
      'LODGE',
      'LDG',
      'LOOP',
      'LOOP',
      'MALL',
      'MALL',
      'MANOR',
      'MNR',
      'MANORS',
      'MNRS',
      'MEADOW',
      'MDW',
      'MEADOWS',
      'MDWS',
      'MEWS',
      'MEWS',
      'MILL',
      'ML',
      'MILLS',
      'MLS',
      'MISSION',
      'MSN',
      'MOTORWAY',
      'MTWY',
      'MOUNT',
      'MT',
      'MOUNTAIN',
      'MTN',
      'MOUNTAINS',
      'MTNS',
      'NECK',
      'NCK',
      'ORCHARD',
      'ORCH',
      'OVAL',
      'OVAL',
      'OVERPASS',
      'OPAS',
      'PARK',
      'PARK',
      'PARKS',
      'PARK',
      'PARKWAY',
      'PKWY',
      'PARKWAYS',
      'PKWY',
      'PASS',
      'PASS',
      'PASSAGE',
      'PSGE',
      'PATH',
      'PATH',
      'PIKE',
      'PIKE',
      'PINE',
      'PNE',
      'PINES',
      'PNES',
      'PLACE',
      'PL',
      'PLAIN',
      'PLN',
      'PLAINS',
      'PLNS',
      'PLAZA',
      'PLZ',
      'POINT',
      'PT',
      'POINTS',
      'PTS',
      'PORT',
      'PRT',
      'PORTS',
      'PRTS',
      'PRAIRIE',
      'PR',
      'RADIAL',
      'RADL',
      'RAMP',
      'RAMP',
      'RANCH',
      'RNCH',
      'RAPID',
      'RPD',
      'RAPIDS',
      'RPDS',
      'REST',
      'RST',
      'RIDGE',
      'RDG',
      'RIDGES',
      'RDGS',
      'RIVER',
      'RIV',
      'ROAD',
      'RD',
      'ROADS',
      'RDS',
      'ROUTE',
      'RTE',
      'ROW',
      'ROW',
      'RUE',
      'RUE',
      'RUN',
      'RUN',
      'SHOAL',
      'SHL',
      'SHOALS',
      'SHLS',
      'SHORE',
      'SHR',
      'SHORES',
      'SHRS',
      'SKYWAY',
      'SKWY',
      'SPRING',
      'SPG',
      'SPRINGS',
      'SPGS',
      'SPUR',
      'SPUR',
      'SPURS',
      'SPUR',
      'SQUARE',
      'SQ',
      'SQUARES',
      'SQS',
      'STATION',
      'STA',
      'STRAVENUE',
      'STRA',
      'STREAM',
      'STRM',
      'STREET',
      'ST',
      'STREETS',
      'STS',
      'SUMMIT',
      'SMT',
      'TERRACE',
      'TER',
      'THROUGHWAY',
      'TRWY',
      'TRACE',
      'TRCE',
      'TRACK',
      'TRAK',
      'TRAFFICWAY',
      'TRFY',
      'TRAIL',
      'TRL',
      'TRAILER',
      'TRLR',
      'TUNNEL',
      'TUNL',
      'TURNPIKE',
      'TPKE',
      'UNDERPASS',
      'UPAS',
      'UNION',
      'UN',
      'UNIONS',
      'UNS',
      'VALLEY',
      'VLY',
      'VALLEYS',
      'VLYS',
      'VIADUCT',
      'VIA',
      'VIEW',
      'VW',
      'VIEWS',
      'VWS',
      'VILLAGE',
      'VLG',
      'VILLAGES',
      'VLGS',
      'VILLE',
      'VL',
      'VISTA',
      'VIS',
      'WALK',
      'WALK',
      'WALKS',
      'WALK',
      'WALL',
      'WALL',
      'WAY',
      'WAY',
      'WAYS',
      'WAYS',
      'WELL',
      'WL',
      'WELLS',
      'WLS'
    ];

    List words = [];

    for (Map word in line['words']) {
      words.add(word['text']);
    }

    if (!isNumeric(words[0])) return '';

    bool valid = false;
    int lastIndex = 0;
    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      if (streetSuffixes.contains(word.toUpperCase())) {
        valid = true;
        lastIndex = i;
      }
    }

    if (!valid) return '';

    // construct address
    String address = words.sublist(0, lastIndex + 1).join(" ");
    print(address);

    return address;
  }

  Future<bool> useAzure(String imgUrl) async {
    // final String url = "https://canadacentral.api.cognitive.microsoft.com/vision/v2.0/ocr";
    final String url =
        "https://canadacentral.api.cognitive.microsoft.com/vision/v2.0/ocr?detectOrientation=true&language=unk";
    final String key = "68d2c9111c95476798620f32134362bc";

    // Shoppers Drug Mart receipt
    //imgUrl = "https://i.imgur.com/ArVOOTjl.jpg";

    // Costco receipt
    imgUrl =
        "https://3.bp.blogspot.com/-mY8IX1i3GH8/VrF7oiJJAGI/AAAAAAAAA-k/obsJXB8GdMc/s1600/costco%2B5.jpg";

    // Walmart receipt
    // imgUrl = "https://images.sampletemplates.com/wp-content/uploads/2018/04/Detailed-Grocery-Payment-Receipt-Samples.jpg";

    var res = await http
        .post(url,
            headers: {
              'Ocp-Apim-Subscription-Key': key,
              'Content-Type': 'application/json'
            },
            body: jsonEncode({'url': imgUrl}))
        .then((response) {
      for (Map region in jsonDecode(response.body)['regions']) {
        for (Map line in region['lines']) {
          print(line);
//          if (isAddress(line)) {
//            print("ADDRESS FOUND!");
//          }
          String address = isAddress(line);
          if (address.length > 0) return address;
          // for (Map word in line['words']) {
          // print(word['text']);
          // }
        }
      }
      return '';
    });
/*
    setState(() {
      var resBody = json.decode(res.body);
      words = resBody["regions"];
    });
*/
    if (res.length > 0) {
      Position position = await Geolocator().getCurrentPosition();
      List<Placemark> receipt = await Geolocator().placemarkFromAddress(res);
      print(receipt);
      num distance = await Geolocator().distanceBetween(
          position.latitude,
          position.longitude,
          receipt[0].position.latitude,
          receipt[0].position.longitude);
      print(distance);
      if (distance < 100)
        return true;
      else
        return false;
    }
    return false;
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0,
        'Your proof of purchase has been accepted!',
        'Flutter Local Notification',
        platform,
        payload: 'reciept recognized');

//    Navigator.of(context).push(
//      MaterialPageRoute(
//        builder: (BuildContext context) {
//          return ThePeople();
//        },
//      ),
//    );
  }

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text('Notification'),
            content: new Text('$payload'),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Proof of Purchase'),
      ),
      body: new Center(
        child: _image == null
            ? Text('Please take a photo of your reciept')
            : Container(
                color: Colors.lightGreen,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        _image,
                        scale: 0.6,
//                    height: 1000,
                      ),
                    ),
                    RaisedButton(
                      elevation: 7.0,
                      child: Text('Upload'),
                      textColor: Colors.white,
                      color: Colors.lightBlue,
                      onPressed: () async {
                        final StorageReference firebaseStorageRef =
                            FirebaseStorage.instance
                                .ref()
                                .child('reciept1.jpg');
                        final StorageUploadTask task =
                            firebaseStorageRef.putFile(_image);
                        var downUrl =
                            await (await task.onComplete).ref.getDownloadURL();
                        var url = downUrl.toString();
                        print(url);
//                      useAzure(url);
                        Navigator.pop(context, useAzure(url));
                        showNotification();
                      },
                    )
                  ],
                )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Take Photo',
        child: Icon(Icons.photo_camera),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}
