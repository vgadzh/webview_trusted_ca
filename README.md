# webview_trusted_ca
This project demonstrates how to add a custom trusted CA certificate to a WebView in Flutter.
## Usage
1. Download the certificate in PEM format from the website https://www.gosuslugi.ru/crt
2. Convert the certificate to DER format using the following command:
```shell
openssl x509 -outform der -in certificatename.pem -out certificatename.der
 ```
3. Move the DER certificate to the `assets/ca` folder
4. Check the permissions in `ios/Runner/Info.plist` and make sure the following key-value pairs are present:
```
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```
5. Check the `minSdkVersion` in `android/app/build.gradle` and ensure it is set to at least 17:
```
    defaultConfig {
        ...
        minSdkVersion 17
        ...
    }
```
6. Run the app and check the result