import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/services.dart';

class X509CertificateHelper {
  static String getPemFromDer(List<int> bytes) {
    return '-----BEGIN CERTIFICATE-----\n${base64Encode(bytes)}\n-----END CERTIFICATE-----\n';
  }

  static X509CertificateData x509CertificateFromDer(List<int> bytes) {
    final pem = getPemFromDer(bytes);
    return X509Utils.x509CertificateFromPem(pem);
  }

  static Future<X509CertificateData> getRussianTrustedCa() async {
    final ByteData caBytes = await rootBundle.load('assets/ca/russiantrustedca.der');
    final caPem = getPemFromDer(caBytes.buffer.asUint8List());
    return X509Utils.x509CertificateFromPem(caPem);
  }

  static bool isChainValid(List<X509CertificateData> certificates) {
    final result = X509Utils.checkChain(certificates);
    if (result.pairs == null) {
      return false;
    } else {
      return result.isValid();
    }
  }
}
