import 'app_language.dart';

/// UI copy in English and Bangla.
class AppStrings {
  const AppStrings(this.lang);
  final AppLanguage lang;

  String _t(String en, String bn) => lang.isBangla ? bn : en;

  // Brand
  String get sylhetDistrict => _t('Sylhet District', 'সিলেট জেলা');
  String get associationName =>
      _t('Taxes Bar Association', 'ট্যাক্সেস বার অ্যাসোসিয়েশন');
  String get tagline => _t('Advocates · Notices · Forms', 'আইনজীবী · নোটিশ · ফর্ম');
  String get location => _t('Mendibagh, Sylhet', 'মেন্দিবাগ, সিলেট');

  // Onboarding
  String get skip => _t('Skip', 'বাদ দিন');
  String get next => _t('Next', 'পরবর্তী');
  String get getStarted => _t('Get started', 'শুরু করুন');
  String get onb1Title => _t('Find a tax advocate', 'ট্যাক্স আইনজীবী খুঁজুন');
  String get onb1Body => _t(
      "Search the members' directory and open any advocate's profile and contact details.",
      'সদস্য তালিকা থেকে যেকোনো আইনজীবীর প্রোফাইল ও যোগাযোগের তথ্য দেখুন।');
  String get onb2Title =>
      _t("Notices and news, as they're posted", 'নোটিশ ও সংবাদ, প্রকাশের সাথে সাথে');
  String get onb2Body => _t(
      "Get the association's notices, news and election updates in one place.",
      'সমিতির নোটিশ, সংবাদ ও নির্বাচনের হালনাগাদ এক জায়গায়।');
  String get onb3Title => _t('Forms and contacts at hand', 'ফর্ম ও যোগাযোগ হাতের কাছে');
  String get onb3Body => _t(
      'Download forms, reach the committee and staff, or contact the bar office directly.',
      'ফর্ম ডাউনলোড করুন, কমিটি ও কর্মচারীদের সাথে যোগাযোগ করুন, বা সরাসরি বার অফিসে যোগাযোগ করুন।');
  String get searchAdvocates => _t('Search advocates', 'আইনজীবী খুঁজুন');
  String get barOffice => _t('Bar office', 'বার অফিস');
  String get download => _t('Download', 'ডাউনলোড');

  // Navigation
  String get home => _t('Home', 'হোম');
  String get members => _t('Members', 'সদস্য');
  String get notices => _t('Notices', 'নোটিশ');
  String get more => _t('More', 'আরও');

  // Home
  String get searchByName => _t('Search advocates by name', 'নাম দিয়ে আইনজীবী খুঁজুন');
  String get quickAccess => _t('Quick access', 'দ্রুত প্রবেশ');
  String get committee => _t('Committee', 'কমিটি');
  String get news => _t('News', 'সংবাদ');
  String get election => _t('Election', 'নির্বাচন');
  String get staff => _t('Staff', 'কর্মচারী');
  String get gallery => _t('Gallery', 'গ্যালারি');
  String get contact => _t('Contact', 'যোগাযোগ');
  String get electionBannerLabel => _t('ELECTION', 'নির্বাচন');
  String get readCecMessage => _t('Read the CEC message', 'প্রধান নির্বাচন কমিশনারের বার্তা');
  String get latestNotices => _t('Latest notices', 'সাম্প্রতিক নোটিশ');
  String get seeAll => _t('See all', 'সব দেখুন');

  // Members
  String advocatesCount(int n) => _t('$n advocates', '$n জন আইনজীবী');
  String get searchByNameOrNo =>
      _t('Search by name or member no.', 'নাম বা সদস্য নং দিয়ে খুঁজুন');
  String get all => _t('All', 'সকল');
  String get golden => _t('Golden', 'গোল্ডেন');
  String get goldenMember => _t('Golden Member', 'গোল্ডেন সদস্য');
  String get freedomFighter => _t('Freedom Fighter', 'মুক্তিযোদ্ধা');
  String get retired => _t('Retired', 'অবসরপ্রাপ্ত');
  String memberNo(String no) => _t('Member no. $no', 'সদস্য নং $no');
  String get noMembers => _t('No advocates found', 'কোনো আইনজীবী পাওয়া যায়নি');

  // Profile
  String get advocateProfile => _t('Advocate profile', 'আইনজীবীর প্রোফাইল');
  String get advocate => _t('Advocate', 'আইনজীবী');
  String get call => _t('Call', 'কল');
  String get email => _t('Email', 'ইমেইল');
  String get details => _t('Details', 'বিস্তারিত');
  String get memberSince => _t('Member since', 'সদস্য হয়েছেন');
  String get phone => _t('Phone', 'ফোন');
  String get chamber => _t('Chamber', 'চেম্বার');
  String get sanadNo => _t('Sanad no.', 'সনদ নং');
  String get bloodGroup => _t('Blood group', 'রক্তের গ্রুপ');
  String get fatherName => _t("Father's name", 'পিতার নাম');
  String get address => _t('Address', 'ঠিকানা');
  String get notAvailable => _t('Not available', 'তথ্য নেই');
  String get share => _t('Share', 'শেয়ার');

  // Notices
  String get noticesAndNews => _t('Notices & News', 'নোটিশ ও সংবাদ');
  String get notice => _t('Notice', 'নোটিশ');
  String get pdfAttached => _t('Attachment', 'সংযুক্তি');
  String get openAttachment => _t('Open attachment', 'সংযুক্তি খুলুন');
  String get noNotices => _t('No notices yet', 'এখনো কোনো নোটিশ নেই');
  String get noNews => _t('No news yet', 'এখনো কোনো সংবাদ নেই');
  String get noticeDetails => _t('Notice', 'নোটিশ');
  String get validUntil => _t('Valid until', 'মেয়াদ');

  // Committee
  String get presentEc => _t('Present EC', 'বর্তমান কমিটি');
  String get previousEc => _t('Previous EC', 'পূর্ববর্তী কমিটি');
  String get executiveCommittee => _t('EXECUTIVE COMMITTEE', 'কার্যনির্বাহী কমিটি');
  String get noCommittee => _t('No committee published yet', 'এখনো কোনো কমিটি প্রকাশিত হয়নি');
  String get noCommitteeMembers => _t('No members listed', 'কোনো সদস্য তালিকাভুক্ত নেই');

  // Staff
  String get noStaff => _t('No staff listed yet', 'এখনো কোনো কর্মচারী তালিকাভুক্ত নেই');
  String get education => _t('Education', 'শিক্ষাগত যোগ্যতা');
  String get joined => _t('Joined', 'যোগদান');
  String get mobile => _t('Mobile', 'মোবাইল');

  // Election
  String get cecMessage => _t('CEC MESSAGE', 'প্রধান নির্বাচন কমিশনারের বার্তা');
  String get chiefElectionCommissioner =>
      _t('Chief Election Commissioner', 'প্রধান নির্বাচন কমিশনার');
  String get runningCommission =>
      _t('Running Election Commission', 'বর্তমান নির্বাচন কমিশন');
  String get previousCommissions =>
      _t('Previous Election Commissions', 'পূর্ববর্তী নির্বাচন কমিশন');
  String get pastCommissionsByTerm => _t('Past commissions by term', 'মেয়াদ অনুযায়ী');
  String get electionEmpty => _t(
      'Election information will appear here once the bar publishes it.',
      'বার প্রকাশ করলে নির্বাচনের তথ্য এখানে দেখা যাবে।');

  // Gallery
  String get galleryEmpty =>
      _t('Photo albums will appear here soon.', 'ফটো অ্যালবাম শীঘ্রই এখানে দেখা যাবে।');

  // More
  String get groupAbout => _t('ABOUT', 'সম্পর্কে');
  String get groupPeople => _t('PEOPLE', 'ব্যক্তিবর্গ');
  String get groupMore => _t('MORE', 'আরও');
  String get aboutUs => _t('About us', 'আমাদের সম্পর্কে');
  String get history => _t('History', 'ইতিহাস');
  String get constitution => _t('Constitution', 'গঠনতন্ত্র');
  String get contactUs => _t('Contact us', 'যোগাযোগ করুন');
  String get privacyPolicy => _t('Privacy policy', 'গোপনীয়তা নীতি');
  String get sylhetDistrictBar => _t('Sylhet District Bar', 'সিলেট জেলা বার');
  String appVersion(String v) => _t('App version $v', 'অ্যাপ সংস্করণ $v');
  String get comingSoon => _t('Coming soon', 'শীঘ্রই আসছে');

  // Exit confirmation
  String get pressBackAgainToExit =>
      _t('Press back again to exit', 'বের হতে আবার ব্যাক চাপুন');
  String get exitTitle => _t('Exit app', 'অ্যাপ থেকে বের হবেন');
  String get exitMessage => _t('Are you sure you want to exit the app?',
      'আপনি কি নিশ্চিত যে অ্যাপ থেকে বের হতে চান?');
  String get yes => _t('Yes', 'হ্যাঁ');
  String get no => _t('No', 'না');

  // About
  String get whoWeAre => _t('Who we are', 'আমরা কারা');
  String get whoWeAreBody => _t(
      'A professional body for tax practitioners in Sylhet, working for their welfare, unity and professional growth, with a focus on ethics, accountability and the responsible use of tax law.',
      'সিলেটের কর আইনজীবীদের একটি পেশাজীবী সংগঠন, যা তাদের কল্যাণ, ঐক্য ও পেশাগত উন্নয়নে কাজ করে; নৈতিকতা, জবাবদিহিতা ও কর আইনের দায়িত্বশীল প্রয়োগে গুরুত্ব দেয়।');
  String get ourMission => _t('Our mission', 'আমাদের লক্ষ্য');
  String get ourMissionBody => _t(
      'To be a dependable platform for tax practitioners: encouraging collaboration and professional development, and supporting the lawful interests of taxpayers.',
      'কর আইনজীবীদের জন্য একটি নির্ভরযোগ্য প্ল্যাটফর্ম হওয়া: সহযোগিতা ও পেশাগত উন্নয়নকে উৎসাহিত করা এবং করদাতাদের আইনসঙ্গত স্বার্থ রক্ষা করা।');
  String get whatWeWorkOn => _t('What we work on', 'আমাদের কার্যক্রম');
  String get goalDevelopment => _t('Professional development', 'পেশাগত উন্নয়ন');
  String get goalKnowledge => _t('Knowledge sharing', 'জ্ঞান বিনিময়');
  String get goalEthics => _t('Ethical tax practice', 'নৈতিক কর চর্চা');
  String get goalAwareness => _t('Tax law awareness', 'কর আইন সচেতনতা');

  // Contact
  String get callOffice => _t('Call office', 'অফিসে কল করুন');
  String get directions => _t('Directions', 'দিকনির্দেশনা');

  // Privacy
  String get privacyHeader =>
      _t('How this app handles your information', 'এই অ্যাপ আপনার তথ্য কীভাবে ব্যবহার করে');
  String get privacyQuestions =>
      _t('Questions about this policy? Write to ', 'এই নীতি নিয়ে প্রশ্ন? লিখুন ');
  List<(String, String)> get privacySections => [
        (
          _t('Information we collect', 'আমরা যে তথ্য সংগ্রহ করি'),
          _t(
              'The app stores only your language choice and whether you have seen the introduction, on your device. It does not ask you to sign in or collect personal data from you.',
              'অ্যাপটি শুধু আপনার ভাষা নির্বাচন এবং পরিচিতি দেখেছেন কি না তা আপনার ডিভাইসে সংরক্ষণ করে। এটি সাইন ইন করতে বলে না বা আপনার ব্যক্তিগত তথ্য সংগ্রহ করে না।'),
        ),
        (
          _t('How we use it', 'আমরা কীভাবে তা ব্যবহার করি'),
          _t('Your language choice is used only to show the app in English or Bangla.',
              'আপনার ভাষা নির্বাচন শুধু অ্যাপটি ইংরেজি বা বাংলায় দেখানোর জন্য ব্যবহৃত হয়।'),
        ),
        (
          _t('Members directory data', 'সদস্য তালিকার তথ্য'),
          _t(
              'Advocate details shown in the directory are published by the association. Members can ask the bar office to update or hide their details.',
              'তালিকায় প্রদর্শিত আইনজীবীদের তথ্য সমিতি প্রকাশ করে। সদস্যরা তাদের তথ্য হালনাগাদ বা গোপন করতে বার অফিসে অনুরোধ করতে পারেন।'),
        ),
        (
          _t('Sharing and disclosure', 'তথ্য শেয়ার'),
          _t('The app does not share your data with third parties.',
              'অ্যাপটি আপনার তথ্য তৃতীয় পক্ষের সাথে শেয়ার করে না।'),
        ),
        (
          _t('Storage and security', 'সংরক্ষণ ও নিরাপত্তা'),
          _t('Directory and notice data are loaded from the association\'s server over HTTPS.',
              'সদস্য ও নোটিশের তথ্য HTTPS এর মাধ্যমে সমিতির সার্ভার থেকে লোড হয়।'),
        ),
        (
          _t('Your choices', 'আপনার পছন্দ'),
          _t('You can change the language at any time from the More tab.',
              'আপনি যেকোনো সময় "আরও" ট্যাব থেকে ভাষা পরিবর্তন করতে পারেন।'),
        ),
      ];

  // Generic states
  String get retry => _t('Try again', 'আবার চেষ্টা করুন');
  String get somethingWentWrong => _t('Something went wrong', 'কিছু একটা সমস্যা হয়েছে');
  String get noInternet => _t('Check your internet connection and try again.',
      'ইন্টারনেট সংযোগ পরীক্ষা করে আবার চেষ্টা করুন।');
  String get couldNotOpen => _t('Could not open link', 'লিংক খোলা যায়নি');
}
