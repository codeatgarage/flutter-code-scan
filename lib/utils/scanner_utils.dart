import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class ScannerUtils {
//  Get the EAN CODE from barcode
  static Future<String> getBarCode() async {
    String eanCode;
    try {
      String qrResult = await BarcodeScanner.scan();
      eanCode = qrResult;
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        eanCode = "Err: Camera permission was denied";
      } else {
        eanCode = "Err: Unknown Error $ex";
      }
    } on FormatException {
      eanCode = "back";
    } catch (ex) {
      eanCode = "Err: Unknown Error $ex";
    }
    return eanCode;
  }

//  check is isBarCode valid or not
  static bool isBarCodeValid(eanCode) {
    bool isValid = true;
    if (isValid) {
      return isValid;
    } else {
      return isValid;
    }
  }
}
