abstract final class AppAssets {
  static const evpIcon = 'assets/images/branding/evp-icon.png';

  static const moduleArt = <String, String>{
    'module_1': 'assets/images/modules/module-1-narrative.png',
    'module_2': 'assets/images/modules/module-2-descriptive.png',
    'module_3': 'assets/images/modules/module-3-procedure.png',
  };

  static const readingAudio = <String, String>{
    'm1-1': 'assets/audio/reading/m1-1.wav',
    'm2-1': 'assets/audio/reading/m2-1.wav',
    'm2-2': 'assets/audio/reading/m2-2.wav',
    'm2-3': 'assets/audio/reading/m2-3.wav',
    'm3-1': 'assets/audio/reading/m3-1.wav',
  };

  static const vocabularyAudio = <String, String>{
    'm1-1': 'assets/audio/vocabulary/m1-1.wav',
    'm1-2': 'assets/audio/vocabulary/m1-2.wav',
    'm1-3': 'assets/audio/vocabulary/m1-3.wav',
    'm1-4': 'assets/audio/vocabulary/m1-4.wav',
    'm1-5': 'assets/audio/vocabulary/m1-5.wav',
    'm2-1': 'assets/audio/vocabulary/m2-1.wav',
    'm2-2': 'assets/audio/vocabulary/m2-2.wav',
    'm2-3': 'assets/audio/vocabulary/m2-3.wav',
    'm2-4': 'assets/audio/vocabulary/m2-4.wav',
    'm2-5': 'assets/audio/vocabulary/m2-5.wav',
    'm3-1': 'assets/audio/vocabulary/m3-1.wav',
    'm3-2': 'assets/audio/vocabulary/m3-2.wav',
    'm3-3': 'assets/audio/vocabulary/m3-3.wav',
    'm3-4': 'assets/audio/vocabulary/m3-4.wav',
    'm3-5': 'assets/audio/vocabulary/m3-5.wav',
  };

  static const glossaryAudio = <String, String>{
    'adjustable': 'assets/audio/glossary/adjustable.wav',
    'assemble': 'assets/audio/glossary/assemble.wav',
    'asymmetrical': 'assets/audio/glossary/asymmetrical.wav',
    'attach': 'assets/audio/glossary/attach.wav',
    'boycott': 'assets/audio/glossary/boycott.wav',
    'casing': 'assets/audio/glossary/casing.wav',
    'centerpiece': 'assets/audio/glossary/centerpiece.wav',
    'delivery': 'assets/audio/glossary/delivery.wav',
    'dual-screen-display': 'assets/audio/glossary/dual-screen-display.wav',
    'durable': 'assets/audio/glossary/durable.wav',
    'eye-catching': 'assets/audio/glossary/eye-catching.wav',
    'finish': 'assets/audio/glossary/finish.wav',
    'flat-packing': 'assets/audio/glossary/flat-packing.wav',
    'gondola-shelving': 'assets/audio/glossary/gondola-shelving.wav',
    'greet': 'assets/audio/glossary/greet.wav',
    'insert': 'assets/audio/glossary/insert.wav',
    'integrated': 'assets/audio/glossary/integrated.wav',
    'open-front': 'assets/audio/glossary/open-front.wav',
    'payment-method': 'assets/audio/glossary/payment-method.wav',
    'premium': 'assets/audio/glossary/premium.wav',
    'retailer': 'assets/audio/glossary/retailer.wav',
    'revolutionary': 'assets/audio/glossary/revolutionary.wav',
    'scan': 'assets/audio/glossary/scan.wav',
    'sturdy': 'assets/audio/glossary/sturdy.wav',
    'verify': 'assets/audio/glossary/verify.wav',
    'visibility': 'assets/audio/glossary/visibility.wav',
  };

  static Iterable<String> get requiredAudioPaths => [
    ...readingAudio.values,
    ...vocabularyAudio.values,
    ...glossaryAudio.values,
  ];

  static Iterable<String> get requiredImagePaths => [
    evpIcon,
    ...moduleArt.values,
  ];
}
