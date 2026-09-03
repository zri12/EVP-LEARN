# SECURITY_PRIVACY.md — Offline Privacy Baseline

## 1. Privacy Model

EVP Learn is a local offline learning app.

No learner account.

No automatic learner-data upload.

## 2. Local Data

May include:
- progress;
- current stage;
- quiz drafts;
- Pre;
- Practice;
- Post;
- Final;
- Gain;
- timestamps;
- history;
- locale.

Remains on device unless future explicit export/sync is approved.

## 3. Static Researcher Information

Profile identity is intentional static content, not a private logged-in profile.

Verify final spelling before release.

## 4. No Secrets

Never commit:
- signing password;
- API key;
- token;
- keystore;
- credentials.

## 5. Network

Core release has no network requirement.

Do not add:
- analytics;
- ads;
- remote crash reporting;
- remote logging;
- API

without approval.

## 6. Permissions

Avoid unnecessary:
- location;
- camera;
- microphone;
- contacts;
- phone;
- broad storage.

Bundled audio needs no media-library permission.

## 7. Local Database

Learning results are local educational data.

Do not expose DB through debug/export endpoints in release.

## 8. Android Backup

Before production, decide whether Android backup should include app data.

Record decision.

Do not promise cross-device sync.

## 9. Logs

Release:
- no verbose answer-key logs;
- no sensitive debug dumps;
- no stack traces to users.

## 10. Answer Keys

Offline APK necessarily contains answer keys.

This is acceptable under offline design.

UI must never reveal them before submission.
