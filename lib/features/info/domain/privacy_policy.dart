import '../../../core/config/app_config.dart';
import '../../../core/localization/app_language.dart';

/// One piece of text in English and Bangla.
class PolicyText {
  const PolicyText(this.en, this.bn);
  final String en;
  final String bn;

  String of(AppLanguage lang) => lang.isBangla ? bn : en;
}

class PolicySection {
  const PolicySection(this.title, this.paragraphs);
  final PolicyText title;
  final List<PolicyText> paragraphs;
}

/// The app's privacy policy — the single source for both the in-app
/// Privacy screen and the public web page used for the Play Store
/// (`dart run tool/build_privacy_html.dart` writes docs/privacy-policy.html).
///
/// Pure Dart (no Flutter imports) so the tool script can use it.
/// Keep it accurate: if the app starts collecting anything (login, analytics,
/// crash reports, push notifications…), update this text and the Play Store
/// Data safety form together.
class PrivacyPolicy {
  PrivacyPolicy._();

  static const appName = PolicyText('Sylhet Taxes Bar', 'সিলেট ট্যাক্সেস বার');

  static const title = PolicyText('Privacy Policy', 'গোপনীয়তা নীতি');

  static const effectiveDate = PolicyText(
    '26 November 2026',
    '২৬ নভেম্বর ২০২৬',
  );

  static const effectiveLabel = PolicyText('Effective date', 'কার্যকর তারিখ');

  static const summary = PolicyText(
    'In short: the app does not ask you to sign in and does not collect, sell or share your personal information.',
    'সংক্ষেপে: অ্যাপটি আপনাকে সাইন ইন করতে বলে না এবং আপনার কোনো ব্যক্তিগত তথ্য সংগ্রহ, বিক্রি বা শেয়ার করে না।',
  );

  static const sections = <PolicySection>[
    PolicySection(PolicyText('Who we are', 'আমরা কারা'), [
      PolicyText(
        'The Sylhet Taxes Bar app ("the app") is published by the Sylhet District Taxes Bar Association ("the Association", "we", "us"). This policy explains what information the app handles and how. It applies only to the app.',
        'সিলেট ট্যাক্সেস বার অ্যাপটি ("অ্যাপ") সিলেট জেলা ট্যাক্সেস বার অ্যাসোসিয়েশন ("সমিতি", "আমরা") প্রকাশ করেছে। অ্যাপটি কোন তথ্য কীভাবে ব্যবহার করে, এই নীতিতে তা ব্যাখ্যা করা হয়েছে। এই নীতি শুধু অ্যাপের ক্ষেত্রে প্রযোজ্য।',
      ),
    ]),
    PolicySection(
      PolicyText('Information we collect', 'আমরা যে তথ্য সংগ্রহ করি'),
      [
        PolicyText(
          'The app does not ask you to create an account or sign in. It does not collect your name, phone number, email address, location, contacts, photos, files or any other personal information.',
          'অ্যাপটিতে কোনো অ্যাকাউন্ট খুলতে বা সাইন ইন করতে হয় না। এটি আপনার নাম, ফোন নম্বর, ইমেইল, অবস্থান, কন্টাক্ট, ছবি, ফাইল বা অন্য কোনো ব্যক্তিগত তথ্য সংগ্রহ করে না।',
        ),
        PolicyText(
          'The app does not use analytics, advertising or tracking services, and it does not show ads.',
          'অ্যাপটি কোনো অ্যানালিটিক্স, বিজ্ঞাপন বা ট্র্যাকিং সেবা ব্যবহার করে না এবং কোনো বিজ্ঞাপন দেখায় না।',
        ),
      ],
    ),
    PolicySection(
      PolicyText(
        'Information stored on your device',
        'আপনার ডিভাইসে সংরক্ষিত তথ্য',
      ),
      [
        PolicyText(
          'The app saves two settings on your device: your language choice (English or Bangla) and whether you have finished the introduction screens. It also keeps a temporary copy of images, such as member photos, so they load faster.',
          'অ্যাপটি আপনার ডিভাইসে দুটি সেটিং সংরক্ষণ করে: আপনার ভাষা নির্বাচন (ইংরেজি বা বাংলা) এবং পরিচিতি পর্ব শেষ করেছেন কি না। এছাড়া ছবি (যেমন সদস্যদের ছবি) দ্রুত দেখানোর জন্য অস্থায়ীভাবে সংরক্ষণ করে।',
        ),
        PolicyText(
          'This information stays on your device. It is never sent to us, and it is removed when you clear the app\'s data or uninstall the app.',
          'এই তথ্য আপনার ডিভাইসেই থাকে, আমাদের কাছে কখনো পাঠানো হয় না, এবং অ্যাপের ডেটা মুছে ফেললে বা অ্যাপ আনইনস্টল করলে মুছে যায়।',
        ),
      ],
    ),
    PolicySection(
      PolicyText('Content the app loads', 'অ্যাপ যে কনটেন্ট লোড করে'),
      [
        PolicyText(
          'The members directory, notices, committee, staff and app version information are loaded from the Association\'s server (sylhettaxbar.com) over a secure HTTPS connection. Like any website, the server receives basic technical details of each request, such as your IP address and device type, and uses them only to deliver the content.',
          'সদস্য তালিকা, নোটিশ, কমিটি, কর্মচারী ও অ্যাপ সংস্করণের তথ্য নিরাপদ HTTPS সংযোগের মাধ্যমে সমিতির সার্ভার (sylhettaxbar.com) থেকে লোড হয়। যেকোনো ওয়েবসাইটের মতো সার্ভার প্রতিটি অনুরোধের সাধারণ প্রযুক্তিগত তথ্য (যেমন আইপি ঠিকানা ও ডিভাইসের ধরন) পায় এবং শুধু কনটেন্ট পাঠানোর জন্য তা ব্যবহার করে।',
        ),
        PolicyText(
          'The Gallery opens the Association\'s website inside the app. The website may use cookies; its own practices apply to it.',
          'গ্যালারি অ্যাপের ভেতরে সমিতির ওয়েবসাইট খোলে। ওয়েবসাইটটি কুকি ব্যবহার করতে পারে; সে ক্ষেত্রে ওয়েবসাইটের নিজস্ব নীতি প্রযোজ্য।',
        ),
      ],
    ),
    PolicySection(PolicyText('Members\' information', 'সদস্যদের তথ্য'), [
      PolicyText(
        'The directory shows information about advocates that the Association publishes: name, father\'s name, membership and sanad numbers, chamber and address, blood group, membership date and photo, and the phone number and email address only where the member has allowed them to be shown.',
        'সদস্য তালিকায় সমিতি কর্তৃক প্রকাশিত আইনজীবীদের তথ্য দেখানো হয়: নাম, পিতার নাম, সদস্য ও সনদ নম্বর, চেম্বার ও ঠিকানা, রক্তের গ্রুপ, সদস্যপদের তারিখ ও ছবি, এবং ফোন নম্বর ও ইমেইল — শুধু যেখানে সদস্য তা দেখানোর অনুমতি দিয়েছেন।',
      ),
      PolicyText(
        'Members can ask the Association to correct, update or hide their details at any time by contacting the bar office (see "Contact us").',
        'সদস্যরা যেকোনো সময় বার অফিসে যোগাযোগ করে (দেখুন "যোগাযোগ") তাদের তথ্য সংশোধন, হালনাগাদ বা গোপন করার অনুরোধ করতে পারেন।',
      ),
    ]),
    PolicySection(
      PolicyText('Actions that open other apps', 'অন্য অ্যাপে খোলে এমন কাজ'),
      [
        PolicyText(
          'When you tap call, email, directions, share or an external link, the app passes that action to your phone\'s dialer, email app, maps, share menu or browser. Those apps handle it under their own privacy policies; the app does not see or store what you do there.',
          'কল, ইমেইল, দিকনির্দেশনা, শেয়ার বা বাইরের লিংকে ট্যাপ করলে অ্যাপটি কাজটি আপনার ফোনের ডায়ালার, ইমেইল অ্যাপ, ম্যাপ, শেয়ার মেনু বা ব্রাউজারে পাঠায়। সেসব অ্যাপ নিজস্ব গোপনীয়তা নীতি অনুযায়ী কাজ করে; সেখানে আপনি কী করেন, অ্যাপটি তা দেখে বা সংরক্ষণ করে না।',
        ),
      ],
    ),
    PolicySection(PolicyText('Sharing of information', 'তথ্য শেয়ার'), [
      PolicyText(
        'We do not sell, rent or share personal information with anyone, because the app does not collect any.',
        'আমরা কারও কাছে কোনো ব্যক্তিগত তথ্য বিক্রি, ভাড়া বা শেয়ার করি না, কারণ অ্যাপটি কোনো ব্যক্তিগত তথ্য সংগ্রহই করে না।',
      ),
    ]),
    PolicySection(PolicyText('Permissions', 'অনুমতি'), [
      PolicyText(
        'The app uses only internet access, to load its content. It does not ask for access to your location, camera, microphone, contacts or files.',
        'অ্যাপটি শুধু কনটেন্ট লোড করার জন্য ইন্টারনেট ব্যবহার করে। এটি আপনার অবস্থান, ক্যামেরা, মাইক্রোফোন, কন্টাক্ট বা ফাইলের অনুমতি চায় না।',
      ),
    ]),
    PolicySection(PolicyText('Data security', 'তথ্যের নিরাপত্তা'), [
      PolicyText(
        'All content is transferred over encrypted HTTPS connections. Because the app collects no personal information, none is stored on our servers through the app.',
        'সব কনটেন্ট এনক্রিপ্টেড HTTPS সংযোগের মাধ্যমে আদান-প্রদান হয়। অ্যাপটি কোনো ব্যক্তিগত তথ্য সংগ্রহ করে না, তাই অ্যাপের মাধ্যমে আমাদের সার্ভারে কোনো ব্যক্তিগত তথ্য সংরক্ষিত হয় না।',
      ),
    ]),
    PolicySection(PolicyText('Children\'s privacy', 'শিশুদের গোপনীয়তা'), [
      PolicyText(
        'The app is meant for tax practitioners, members of the Association and the general public. It is not directed at children under 13, and we do not knowingly collect information from children.',
        'অ্যাপটি কর আইনজীবী, সমিতির সদস্য ও সাধারণ মানুষের জন্য তৈরি। এটি ১৩ বছরের কম বয়সী শিশুদের উদ্দেশ্যে নয় এবং আমরা জেনেশুনে শিশুদের কোনো তথ্য সংগ্রহ করি না।',
      ),
    ]),
    PolicySection(PolicyText('Your choices', 'আপনার পছন্দ'), [
      PolicyText(
        'You can change the language at any time from the More tab, clear the app\'s stored data from your phone\'s settings, or uninstall the app. Members can ask for changes to their directory details at any time.',
        'আপনি যেকোনো সময় "আরও" ট্যাব থেকে ভাষা পরিবর্তন করতে, ফোনের সেটিংস থেকে অ্যাপের সংরক্ষিত ডেটা মুছতে বা অ্যাপটি আনইনস্টল করতে পারেন। সদস্যরা যেকোনো সময় তালিকায় তাদের তথ্য পরিবর্তনের অনুরোধ করতে পারেন।',
      ),
    ]),
    PolicySection(PolicyText('Changes to this policy', 'এই নীতির পরিবর্তন'), [
      PolicyText(
        'We may update this policy when the app changes. The new version will appear in the app and on this page with a new effective date.',
        'অ্যাপে পরিবর্তন হলে আমরা এই নীতি হালনাগাদ করতে পারি। নতুন সংস্করণ নতুন কার্যকর তারিখসহ অ্যাপে ও এই পৃষ্ঠায় প্রকাশ করা হবে।',
      ),
    ]),
    PolicySection(PolicyText('Contact us', 'যোগাযোগ'), [
      PolicyText(
        'Sylhet District Taxes Bar Association\n${AppConfig.officeAddress}\nEmail: ${AppConfig.officeEmail}\nPhone: ${AppConfig.officePhoneDisplay}',
        'সিলেট জেলা ট্যাক্সেস বার অ্যাসোসিয়েশন\n${AppConfig.officeAddress}\nইমেইল: ${AppConfig.officeEmail}\nফোন: ${AppConfig.officePhoneDisplay}',
      ),
    ]),
  ];
}
