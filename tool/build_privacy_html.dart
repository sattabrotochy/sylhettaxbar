// Builds docs/privacy-policy.html from the app's privacy policy text, so the
// public page (used for the Play Store / App Store "Privacy policy URL") always
// matches what the app shows.
//
//   dart run tool/build_privacy_html.dart
//
// Then upload docs/privacy-policy.html to the website, e.g.
// https://sylhettaxbar.com/privacy-policy.html
import 'dart:convert';
import 'dart:io';

import 'package:sylhettaxesbar/core/localization/app_language.dart';
import 'package:sylhettaxesbar/features/info/domain/privacy_policy.dart';

String esc(String s) => const HtmlEscape().convert(s).replaceAll('\n', '<br>');

String block(AppLanguage l) {
  final b = StringBuffer();
  final id = l.code;
  b.writeln('<article id="$id" lang="$id" class="policy">');
  b.writeln('<h1>${esc(PrivacyPolicy.title.of(l))}</h1>');
  b.writeln('<p class="app">${esc(PrivacyPolicy.appName.of(l))}</p>');
  b.writeln('<p class="date">${esc(PrivacyPolicy.effectiveLabel.of(l))}: '
      '${esc(PrivacyPolicy.effectiveDate.of(l))}</p>');
  b.writeln('<p class="summary">${esc(PrivacyPolicy.summary.of(l))}</p>');
  for (final (i, s) in PrivacyPolicy.sections.indexed) {
    b.writeln('<section>');
    b.writeln('<h2><span>${i + 1}</span>${esc(s.title.of(l))}</h2>');
    for (final p in s.paragraphs) {
      b.writeln('<p>${esc(p.of(l))}</p>');
    }
    b.writeln('</section>');
  }
  b.writeln('</article>');
  return b.toString();
}

void main() {
  final logo = File('tool/privacy_logo.png');
  final logoTag = logo.existsSync()
      ? '<img src="data:image/png;base64,${base64Encode(logo.readAsBytesSync())}" alt="" width="56" height="56">'
      : '';

  final html = '''<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Privacy Policy – Sylhet Taxes Bar</title>
<meta name="description" content="Privacy policy of the Sylhet Taxes Bar mobile app, published by the Sylhet District Taxes Bar Association.">
<style>
:root{--navy:#001B4D;--primary:#00369F;--gold:#C9A961;--goldText:#7D6227;--goldSoft:#FBF6EA;--bg:#F4F7FC;--line:#E1E9F4;--text:#212529;--muted:#46536B}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--text);font:16px/1.65 system-ui,-apple-system,"Segoe UI",Roboto,"Noto Sans Bengali","Noto Sans",sans-serif}
header{background:var(--navy);color:#fff;padding:20px 16px}
.bar{max-width:760px;margin:0 auto;display:flex;align-items:center;gap:14px}
.bar img{border-radius:50%;background:#fff;border:2px solid var(--gold)}
.bar strong{display:block;font-size:18px}
.bar small{color:#9FB6E6}
nav{margin-left:auto;display:flex;gap:6px}
nav a{color:#fff;text-decoration:none;border:1px solid rgba(255,255,255,.35);border-radius:999px;padding:4px 12px;font-size:14px}
nav a:hover{background:rgba(255,255,255,.12)}
main{max-width:760px;margin:0 auto;padding:16px}
.policy{background:#fff;border-radius:20px;padding:24px 20px;margin:16px 0}
h1{color:var(--navy);margin:0;font-size:28px}
.app{margin:2px 0 0;color:var(--muted);font-weight:600}
.date{margin:4px 0 16px;color:var(--muted);font-size:14px}
.summary{background:var(--goldSoft);color:var(--goldText);font-weight:600;border-radius:14px;padding:12px 14px}
section{border-top:1px solid var(--line);padding-top:8px;margin-top:16px}
h2{color:var(--navy);font-size:18px;display:flex;gap:10px;align-items:center;margin:8px 0}
h2 span{flex:none;width:26px;height:26px;border-radius:8px;background:var(--line);color:var(--primary);font-size:13px;display:grid;place-items:center}
section p{margin:8px 0 0 36px;color:var(--muted)}
footer{text-align:center;color:var(--muted);font-size:13px;padding:8px 16px 32px}
@media (max-width:480px){section p{margin-left:0}.bar small{display:none}}
</style>
</head>
<body>
<header><div class="bar">$logoTag<div><strong>Sylhet Taxes Bar</strong><small>Sylhet District Taxes Bar Association</small></div>
<nav><a href="#en">English</a><a href="#bn">বাংলা</a></nav></div></header>
<main>
${block(AppLanguage.en)}
${block(AppLanguage.bn)}
</main>
<footer>© Sylhet District Taxes Bar Association</footer>
</body>
</html>
''';

  final out = File('docs/privacy-policy.html')..createSync(recursive: true);
  out.writeAsStringSync(html);
  stdout.writeln('Wrote ${out.path} (${(html.length / 1024).toStringAsFixed(1)} KB)');
}
