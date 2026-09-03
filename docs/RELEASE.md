# RELEASE.md — Android APK Release Procedure

## 1. Release Goal

Produce a reproducible installable APK that:
- runs offline;
- contains all required assets;
- contains no secrets;
- is tested on physical Android.

## 2. Versioning

Recommended:

```text
1.0.0+1
```

Increment build number for each distributed build.

Examples:

```text
1.0.0+1
1.0.0+2
1.0.1+3
```

## 3. Application ID

Do not finalize production application ID without project/customer confirmation.

Changing it after distribution affects upgrade identity.

Record final ID in `DECISIONS.md`.

## 4. Signing

Release key:
- outside Git;
- no password in Markdown;
- no keystore in repository;
- secure local config.

Ensure `.gitignore`.

## 5. Pre-release Gates

```bash
dart format lib test
flutter analyze
flutter test
flutter build apk --release
```

If `integration_test/` exists, use `dart format lib test integration_test`.

No release on failure.

## 6. Asset Gate

Validate:
- 3 module JSON;
- all required images;
- reading 5;
- vocabulary 15;
- glossary 26 unique;
- local font if used.

## 7. Offline Gate

Install release APK.

Airplane mode ON.

Smoke:
- launch;
- reading/audio;
- practice;
- assessment;
- save;
- restart.

## 8. Output

Standard:

```text
build/app/outputs/flutter-apk/app-release.apk
```

Customer filename example:

```text
EVP-Learn-v1.0.0-build1.apk
```

## 9. Release Notes

Example:

```text
EVP Learn v1.0.0
- 3 offline learning modules
- Local reading/pronunciation audio
- Pre/Post assessment
- Interactive practice
- Progress and evaluation history
- Indonesian/English UI
```

Do not claim academically final question banks unless approved.

## 10. SHA-256

Recommended.

Linux/macOS:

```bash
sha256sum EVP-Learn-v1.0.0-build1.apk
```

PowerShell:

```powershell
Get-FileHash .\EVP-Learn-v1.0.0-build1.apk -Algorithm SHA256
```

## 11. Installation Test

Test:
- clean install;
- launch;
- permissions;
- sound;
- persistence;
- uninstall/reinstall behavior.

## 12. Update Test

Same app ID/signing:
- install over prior build;
- DB migrates;
- history remains.

Never ship destructive migration silently.

## 13. Permissions

Do not request unnecessary:
- camera;
- location;
- microphone;
- contacts;
- broad storage.

Core release must not require Internet.

## 14. Future AAB

If Play Store requested:

```bash
flutter build appbundle --release
```

Not a current requirement.

## 15. Customer Handoff

Recommended:
- APK;
- version;
- install note;
- academic pending note where relevant;
- optional screenshots.

Never send:
- signing key;
- secrets;
- node_modules;
- build cache.
