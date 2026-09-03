import '../../domain/models/root_module.dart';

/// Root-screen metadata copied from the approved prototype.
/// It deliberately excludes lessons, questions, audio, and academic passages.
const rootModules = <RootModule>[
  RootModule(
    id: 1,
    title: 'Narrative Text',
    subtitle: 'IKEA · Inspirational Business Stories',
    assetPath: 'assets/images/modules/module-1-narrative.png',
  ),
  RootModule(
    id: 2,
    title: 'Descriptive Text',
    subtitle: 'POS · Gondola · Jacket',
    assetPath: 'assets/images/modules/module-2-descriptive.png',
  ),
  RootModule(
    id: 3,
    title: 'Procedure Text',
    subtitle: 'POS Checkout',
    assetPath: 'assets/images/modules/module-3-procedure.png',
  ),
];
