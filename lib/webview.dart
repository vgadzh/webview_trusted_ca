import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'utils/x509_certificate_helper.dart';

class WebView extends StatelessWidget {
  const WebView({super.key});

  @override
  Widget build(BuildContext context) {
    return  InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse('https://www.sberbank.ru/ru/certificates')),
      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        try {
          final russianTrustedCa = await X509CertificateHelper.getRussianTrustedCa();
          final der = challenge.protectionSpace.sslCertificate!.x509Certificate!.encoded!;
          final serverCert = X509CertificateHelper.x509CertificateFromDer(der);
          if (X509CertificateHelper.isChainValid([serverCert, russianTrustedCa])) {
            return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
          }
        } catch (_) {}
        // Return null to certificate validation by system
        return null;
      },
    );
  }
}
