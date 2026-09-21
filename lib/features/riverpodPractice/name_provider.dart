// name_provider.dart
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<String> names = [
  'Aarav Sharma', 'Ishaan Verma', 'Rohan Malhotra', 'Kabir Singh',
  'Vivaan Gupta', 'Ananya Iyer', 'Diya Kapoor', 'Saanvi Reddy',
  'Myra Nair', 'Kiara Joshi', 'Arjun Mehta', 'Neha Kulkarni',
  'Rahul Chopra', 'Priya Desai', 'Vikram Rao',
];

final currentNameProvider = StateProvider.autoDispose<String>((ref) {
  return "Change My Name";
});

final nameListProvider = StateProvider.autoDispose<List<String>>((ref) {
  return [];
});

void pickRandomName(WidgetRef ref) {
  final random = Random();
  final newName = names[random.nextInt(names.length)];

  ref.read(currentNameProvider.notifier).state = newName;
  ref.read(nameListProvider.notifier).state = [
    ...ref.read(nameListProvider),
    newName,
  ];
}
// Flutter + Go Lang
// Technical Lead Interview Guide
// 10+ Years Experience — Flutter (Android/iOS) & Go Development
// 350 Questions with Model Answers (50 per Section)
// Includes: Flutter Core • Android Platform • iOS Platform • Go Core • System Design • Leadership • Scenarios
//  
// Table of Contents
// 1. Flutter — Core & Advanced (50 Questions)
// 2. Flutter — Android Platform Specifics (50 Questions)
// 3. Flutter — iOS Platform Specifics (50 Questions)
// 4. Go — Core & Advanced (50 Questions)
// 5. System Design / Architecture — TL Level (50 Questions)
// 6. Leadership & TL-Specific (50 Questions)
// 7. Scenario-Based / Whiteboard Questions (50 Questions)
//
// 1. Flutter — Core & Advanced (50 Questions)
// Q. 1. Explain the Flutter rendering pipeline: Widget → Element → RenderObject.
// A. Widgets are immutable config, Elements are persistent and mutable linking widgets to the tree, RenderObjects handle layout/paint. Splitting into three trees lets Flutter diff cheap widgets and reuse expensive RenderObjects, making rebuilds fast.
// Q. 2. How does 'const' affect widget rebuilds?
// A. A const widget is canonicalized at compile time; if the same instance is passed on rebuild, Flutter skips reconstructing that Element/subtree entirely, reducing allocations and diffing work.
// Q. 3. Compare Provider, Riverpod, Bloc, and GetX for a large team.
// A. Provider is simple but context-dependent; Riverpod fixes that and is compile-safe; Bloc enforces strict unidirectional flow good for large teams; GetX is fast but couples concerns, hurting testability at scale.
// Q. 4. How do you implement deep linking with nested navigators?
// A. Use go_router/auto_route with Navigator 2.0 to declaratively map URLs to nested stacks, parsing links centrally and dispatching to the correct nested Navigator inside shell routes.
// Q. 5. What are isolates and when do you use them?
// A. Isolates are separate memory spaces with their own event loop for true parallelism, communicating via message passing. Use them for CPU-heavy work like large JSON parsing or image processing to avoid UI jank.
// Q. 6. How do you architect a codebase for mobile, web, and desktop?
// A. Use a layered mono-repo (Melos): shared core package for business logic, an abstraction layer for platform-differing services, and thin platform implementations behind DI, with adaptive UI rather than forked screens.
// Q. 7. How do you profile performance and detect memory leaks?
// A. Use DevTools Performance view for frame build/raster time, Memory view for heap snapshots to spot retained objects (undisposed controllers/streams), and Timeline for rebuild tracing.
// Q. 8. How do you structure platform channels for native integration?
// A. Use Pigeon to generate type-safe channel code per feature domain instead of hand-rolled MethodChannels, map native errors to typed Dart exceptions, and keep platform code behind an interface for testability.
// Q. 9. How do you manage app size and modularize a large app?
// A. Split into feature packages via Melos mono-repo, use deferred/lazy loading for rarely used features, enable tree-shaking and --split-debug-info, and use Android App Bundles for device-specific delivery.
// Q. 10. What's your testing strategy across unit, widget, and integration tests?
// A. Unit tests for business logic with mocks run on every commit, widget tests for critical screens, golden tests for visual regression, and integration tests for key user journeys gated on PR/nightly.
// Q. 11. Explain the widget lifecycle for a StatefulWidget.
// A. createState → initState → didChangeDependencies → build → (didUpdateWidget on rebuild with new widget) → ... → deactivate → dispose. initState runs once; didChangeDependencies runs when an InheritedWidget it depends on changes.
// Q. 12. What is BuildContext and why is it tied to a specific widget?
// A. BuildContext is a handle to a widget's location in the Element tree, used to look up InheritedWidgets or Theme data. It's specific to that Element because ancestor lookups depend on tree position.
// Q. 13. Difference between InheritedWidget and Provider/ChangeNotifier?
// A. InheritedWidget is the low-level primitive for efficiently propagating data down the tree with dependency tracking; Provider is a wrapper around InheritedWidget that adds lifecycle management, disposal, and ergonomics.
// Q. 14. How does hot reload work internally?
// A. Hot reload injects updated Dart code into the running Dart VM, then Flutter reruns build() on the existing Element tree while preserving state, without restarting the app or losing navigation/scroll position.
// Q. 15. Explain Skia vs Impeller rendering engines.
// A. Skia is the traditional GPU rendering backend using a JIT-compiled shader pipeline, sometimes causing first-run jank. Impeller precompiles shaders ahead-of-time and is now default on iOS/Android to eliminate shader compilation jank.
// Q. 16. What is a RepaintBoundary and when should you use one?
// A. It isolates a subtree into its own compositing layer so repaints don't cascade to siblings/ancestors. Use it around frequently-animating widgets (e.g., a spinner) inside an otherwise static screen.
// Q. 17. How do you optimize a long ListView with dynamic-height items?
// A. Use ListView.builder for laziness, provide itemExtent or prototypeItem when heights are uniform for layout shortcuts, and consider a CustomScrollView with slivers for mixed content types.
// Q. 18. What are Slivers and when do you use CustomScrollView?
// A. Slivers are scrollable area building blocks enabling custom scroll effects (collapsing app bars, mixed grids/lists). Use CustomScrollView when you need multiple scrollable regions with coordinated scroll physics in one viewport.
// Q. 19. How do FutureBuilder and StreamBuilder differ, and their pitfalls?
// A. FutureBuilder handles a one-time async value; StreamBuilder handles a sequence of values. A pitfall is recreating the Future/Stream on every build causing repeated fetches — instantiate them in initState/a state field instead.
// Q. 20. What is a GlobalKey and when should you avoid it?
// A. GlobalKey uniquely identifies an Element across the tree, allowing access to state or moving a widget subtree. Avoid overusing it since it breaks Element tree locality and can hurt performance and is easy to misuse for state access.
// Q. 21. Explain the compute() function and when to use it.
// A. compute() runs a function on a new isolate and returns a Future with the result, ideal for one-off CPU-bound tasks like JSON decoding of large payloads without setting up manual isolate plumbing.
// Q. 22. SharedPreferences vs flutter_secure_storage — when to use which?
// A. SharedPreferences stores simple non-sensitive key-value data in plaintext; flutter_secure_storage encrypts data using Keychain/Keystore, used for tokens, credentials, or any sensitive data.
// Q. 23. How do you handle internationalization (i18n) in a large Flutter app?
// A. Use the intl package with ARB files per locale, generate strongly-typed accessors via flutter gen-l10n, and structure translations by feature module to avoid one giant file becoming unmanageable.
// Q. 24. How do you ensure accessibility (a11y) in Flutter apps?
// A. Use Semantics widgets/labels for custom widgets, ensure sufficient tap target sizes and color contrast, test with TalkBack/VoiceOver, and use the Accessibility Scanner/DevTools accessibility inspector during development.
// Q. 25. How do you implement custom theming supporting dark/light mode?
// A. Define a ThemeData/ColorScheme centrally, use Theme.of(context) rather than hardcoded colors throughout, and support ThemeMode.system with MediaQuery.platformBrightness fallback for consistent adaptive theming.
// Q. 26. What is a CustomPainter and when would you use one?
// A. CustomPainter lets you draw directly onto a Canvas for custom graphics (charts, signatures) not achievable with standard widgets, implementing paint() and shouldRepaint() for efficient redraw control.
// Q. 27. How do you handle gesture conflicts (e.g., nested scrollables)?
// A. Use GestureDetector with explicit gesture arenas, or NotificationListener/ScrollController coordination for nested scrollables, and Listener/RawGestureDetector when you need fine-grained control over gesture disambiguation.
// Q. 28. Explain null safety and migrating a legacy codebase to it.
// A. Sound null safety makes nullability part of the type system, catching null-dereference bugs at compile time. Migration involves running the dart migrate tool, then manually resolving ambiguous cases, working outward from leaf packages.
// Q. 29. How do you write and structure a Flutter plugin package?
// A. Split into an app-facing Dart API, a platform interface package (federated plugin pattern) defining the contract, and separate platform implementation packages, so platforms can evolve independently and be swapped/mocked.
// Q. 30. What are build modes (debug/profile/release) and their differences?
// A. Debug enables assertions, hot reload, and JIT compilation (slower). Profile is AOT-compiled with some debugging service support, used for performance profiling. Release is fully AOT-compiled and optimized for production.
// Q. 31. How do you handle background tasks in Flutter (both platforms)?
// A. Use workmanager for periodic/deferred background tasks respecting platform constraints (Doze on Android, BGTaskScheduler on iOS), and platform-specific foreground services/background modes for time-critical continuous work.
// Q. 32. What is code generation (build_runner) used for in Flutter?
// A. Generates boilerplate for JSON serialization (json_serializable), immutable data classes (freezed), dependency injection (injectable), and routing (auto_route), reducing manual boilerplate and runtime reflection cost.
// Q. 33. How do you manage dependency injection in a large app?
// A. Use get_it as a service locator combined with injectable for compile-time code generation of registrations, or Riverpod's provider graph itself as the DI mechanism, keeping constructors explicit for testability.
// Q. 34. What's the difference between Keys — ValueKey, ObjectKey, UniqueKey?
// A. ValueKey compares by value equality, ObjectKey by identity/object equality, UniqueKey is always different from any other key. Choose based on what uniquely identifies list items to preserve state correctly during reordering.
// Q. 35. How do you handle form validation at scale across many screens?
// A. Centralize a Form/FormField-based validation layer with reusable validator functions, use a state management pattern (Bloc/Riverpod) to separate validation logic from UI, and reuse a shared error-display widget.
// Q. 36. Explain AnimationController and TickerProvider.
// A. AnimationController drives animation values over time using a Ticker synced to the display's vsync signal (via SingleTickerProviderStateMixin); TickerProvider supplies that vsync so animations pause when the widget isn't visible.
// Q. 37. How do you implement a shimmer/skeleton loading effect efficiently?
// A. Use a lightweight gradient-animated overlay (shimmer package or custom ShaderMask with AnimationController) rather than rebuilding entire skeleton widgets repeatedly, keeping it in its own RepaintBoundary.
// Q. 38. How do you write golden tests and maintain them across CI environments?
// A. Use matchesGoldenFile with a consistent font/rendering environment (often a Docker image matching CI) since font rendering differs across OSes; regenerate goldens deliberately via a flagged command, and review diffs in PR.
// Q. 39. What is the difference between mocking with Mockito vs Mocktail?
// A. Mockito traditionally required code generation for null-safe mocks; Mocktail avoids code generation using Dart's null safety features directly, offering a simpler setup for most unit test mocking needs.
// Q. 40. How do you handle versioning and breaking changes for internal packages?
// A. Follow semantic versioning strictly, maintain a CHANGELOG per package, and use melos version to coordinate releases across a mono-repo, running dependent package tests before publishing breaking changes.
// Q. 41. How do you implement a custom splash screen consistently across platforms?
// A. Use flutter_native_splash to generate native splash configs for both Android (12+ SplashScreen API) and iOS launch storyboard, keeping the transition to the first Flutter frame seamless.
// Q. 42. What is the difference between StatefulWidget and StatelessWidget internally?
// A. StatelessWidget creates a single Element with no mutable state; StatefulWidget creates a StatefulElement holding a State object that persists across rebuilds and can call setState to trigger a rebuild.
// Q. 43. How do you avoid unnecessary rebuilds when using Provider/Riverpod?
// A. Use context.select or Consumer scoped narrowly to only the fields needed, split large models into smaller providers, and avoid watching entire objects when only one field changes.
// Q. 44. Explain how error boundaries work in Flutter (FlutterError.onError, runZonedGuarded).
// A. FlutterError.onError catches framework-level errors during build/layout/paint; runZonedGuarded catches uncaught async errors outside the framework's error zone. Both are typically wired to Crashlytics/Sentry for centralized error reporting.
// Q. 45. How do you handle large image loading and caching efficiently?
// A. Use cached_network_image for disk+memory caching with placeholder/error widgets, specify cacheWidth/cacheHeight to decode at display resolution rather than full resolution, and use appropriate image formats (WebP) to reduce payload.
// Q. 46. What's your approach to state restoration (app killed by OS, resumed)?
// A. Use the RestorationMixin/RestorationScope APIs for critical navigation/form state, and persist essential session data (current screen, draft input) to local storage so users don't lose context on process death.
// Q. 47. How do you structure a feature-first vs layer-first folder architecture?
// A. Feature-first groups by domain (each feature has its own UI/logic/data), improving modularity and enabling package extraction; layer-first groups by technical role (all UI, all logic) which scales poorly for large teams.
// Q. 48. How do you handle multiple environments (dev/staging/prod) configuration?
// A. Use --dart-define or --dart-define-from-file for build-time config injection combined with platform flavors, avoiding hardcoded environment values and keeping secrets out of source control.
// Q. 49. What tools do you use for static analysis and enforcing code standards?
// A. flutter analyze with a strict analysis_options.yaml (very_good_analysis or custom lint rules), pre-commit hooks, and CI-gated formatting (dart format) to keep a large team's code consistent.
// Q. 50. How would you evaluate whether to rewrite a native app in Flutter?
// A. Assess team skill overlap, app complexity (heavy native-only APIs vs standard CRUD/UI), business case for cross-platform velocity, and plan an incremental migration (add-to-app) rather than a risky big-bang rewrite.
//
// 2. Flutter — Android Platform Specifics (50 Questions)
// Q. 1. How do you configure product flavors for multiple environments?
// A. Define flavors in build.gradle (dev/staging/prod) mapped to Flutter's --flavor flag, each with its own applicationIdSuffix, resValues, and google-services.json, keeping environment Dart config injected via --dart-define.
// Q. 2. How do you troubleshoot ANRs in a Flutter Android app?
// A. Check adb logcat and Play Console ANR reports for the blocking stack trace, usually heavy synchronous native code invoked via a MethodChannel; move that work off the main thread or into a coroutine.
// Q. 3. Explain Gradle's build process for a Flutter Android app.
// A. Gradle resolves dependencies, compiles Kotlin/Java, merges manifests/resources, embeds the Flutter engine via the Flutter Gradle plugin, and packages the APK/AAB — common issues are multidex limits and plugin version conflicts.
// Q. 4. How do you handle Android runtime permissions properly?
// A. Use permission_handler, show a rationale before prompting (especially on re-request), handle permanently-denied states by directing users to app settings, and never assume a permission granted once stays granted.
// Q. 5. How do you optimize cold-start time on Android?
// A. Minimize main() work before runApp(), defer non-critical init post-first-frame, use Baseline Profiles for AOT-compiled hot paths, and enable R8 full mode for smaller/faster bytecode.
// Q. 6. How do you debug native (NDK/JNI) crashes below the Flutter engine?
// A. Ensure Crashlytics NDK symbol upload is configured, reproduce with symbols in a debug/profile build, and use addr2line or Android Studio's native crash inspector to map to source.
// Q. 7. What is R8/ProGuard and how does it affect Flutter plugins?
// A. R8 shrinks, obfuscates, and optimizes bytecode; reflection-based libraries (Gson, Firebase) can break unless you add keep rules in proguard-rules.pro, since R8 may strip 'unused' reflected classes/methods.
// Q. 8. How do you resolve the 64K method limit (multidex) issue?
// A. Enable multiDexEnabled true in build.gradle and ensure androidx.multidex is included for minSdk below 21; for newer minSdk, D8/R8 handles this automatically in most modern setups.
// Q. 9. How does WorkManager differ from a raw background Service?
// A. WorkManager schedules deferrable, guaranteed background work respecting Doze/App Standby and battery optimizations, using JobScheduler/AlarmManager under the hood; raw Services don't get these OS-level constraint guarantees automatically.
// Q. 10. How do you implement a foreground service for continuous background work?
// A. Show a persistent notification via startForeground(), request FOREGROUND_SERVICE permission (and specific type permission on Android 14+), and keep the work bounded since the OS can still kill it under memory pressure.
// Q. 11. How do you handle Android App Links (verified deep links)?
// A. Add an assetlinks.json file to your domain's .well-known folder, configure intent-filter with autoVerify=true in AndroidManifest, and test verification status via adb shell pm get-app-links.
// Q. 12. What's the difference between minSdkVersion, targetSdkVersion, and compileSdkVersion?
// A. minSdk is the lowest OS version supported; targetSdk signals which behaviors/APIs the app is designed against (Play Store enforces recent targets); compileSdk is the API level used to compile, which should generally match the latest available.
// Q. 13. How do you handle scoped storage changes (Android 10+)?
// A. Use the Storage Access Framework or MediaStore APIs instead of direct file paths for user files, and request MANAGE_EXTERNAL_STORAGE only when absolutely necessary since it's heavily restricted by Play policy.
// Q. 14. How do you set up Firebase Cloud Messaging (FCM) in Flutter/Android?
// A. Add firebase_messaging, configure google-services.json, handle foreground messages via onMessage, background/terminated via a top-level background handler, and create notification channels explicitly for Android 8+.
// Q. 15. What are notification channels and why are they required?
// A. Since Android 8 (Oreo), all notifications must belong to a channel that users can individually configure (importance, sound); you define channels at first app launch/app start before posting any notification.
// Q. 16. How do you implement biometric authentication on Android via Flutter?
// A. Use local_auth which wraps BiometricPrompt, checking canCheckBiometrics first, handling fallback to device credential, and gracefully degrading on devices without biometric hardware.
// Q. 17. How do you handle Android 13+ runtime notification permission?
// A. POST_NOTIFICATIONS is now a runtime permission on Android 13+; request it explicitly (not just declare in manifest) before scheduling/showing any notification, with proper rationale UX.
// Q. 18. Explain Android App Bundles vs APKs and why they matter.
// A. App Bundles (AAB) let Google Play generate optimized, device-specific APKs (only needed resources/ABIs/languages), reducing download size significantly compared to a universal APK; Play Store now requires AAB for new apps.
// Q. 19. How do you debug a memory leak specific to Android native views (PlatformView)?
// A. Use Android Studio's Memory Profiler to check for retained Activity/View references after a PlatformView is disposed, ensuring the plugin's dispose() properly releases native view/controller references.
// Q. 20. How do you implement predictive back gesture support (Android 14)?
// A. Enable android:enableOnBackInvokedCallback in the manifest and use Flutter's PopScope/BackButtonListener with onPopInvoked to support the predictive back animation instead of the legacy WillPopScope.
// Q. 21. How do you handle edge-to-edge display and system bars on Android?
// A. Use SystemUiOverlayStyle and SafeArea/MediaQuery.padding to account for status/navigation bar insets, and enableEdgeToEdge configurations for a modern immersive UI on Android 15+ where edge-to-edge becomes mandatory.
// Q. 22. How do you set up in-app purchases via Google Play Billing?
// A. Use the in_app_purchase plugin, configure products in Play Console, verify purchases server-side via the Play Developer API (never trust client-only verification) to prevent purchase spoofing.
// Q. 23. How do you configure app signing for Play Store releases?
// A. Use Play App Signing where Google holds the final signing key and you sign uploads with an upload key; configure key.properties and signingConfigs in build.gradle, never committing keystores to source control.
// Q. 24. How do you implement dynamic feature modules (on-demand delivery) with Flutter?
// A. This is primarily a native Android Dynamic Feature Module concept; in Flutter it's more common to use deferred components (deferred imports) for Dart-level lazy loading of feature code within a single APK/AAB.
// Q. 25. How do you handle configuration changes (rotation) without losing state?
// A. Flutter handles this well by default since the Dart VM/engine persists across Activity recreation when configured correctly (android:configChanges or the engine's own state retention); ensure StatefulWidgets don't rely on ephemeral local-only state for critical data.
// Q. 26. How do you use Android Studio Profiler alongside Flutter DevTools?
// A. Use Android Studio's CPU/Memory/Network profiler for native-layer issues (JNI calls, native memory, network sockets under the hood) while Flutter DevTools handles Dart-level widget rebuilds and Dart heap.
// Q. 27. How do you handle content provider integration for sharing data with other apps?
// A. Implement a native ContentProvider on the Android side (outside typical Flutter plugin scope) exposed via a platform channel bridge, or use plugins like share_plus/receive_sharing_intent for common sharing use cases.
// Q. 28. What's your approach to reducing APK/AAB size for a Flutter Android app?
// A. Enable R8 full mode, strip debug symbols with --split-debug-info, use AAB for device-specific delivery, avoid bundling unused ABIs, and audit large asset/font inclusion.
// Q. 29. How do you handle Android Auto or Wear OS integration with Flutter?
// A. These typically require native Android modules (Flutter doesn't natively target them) — you'd build a native companion app/module and optionally bridge shared business logic via a platform channel or shared Dart package compiled to a native library.
// Q. 30. How do you test on multiple Android API levels efficiently?
// A. Maintain a matrix of emulators/physical devices spanning min to target SDK, use Firebase Test Lab for broader device/OS coverage in CI, and prioritize testing OS versions with known behavioral breaking changes.
// Q. 31. How do you handle back stack management with Flutter's Navigator on Android?
// A. Map Flutter's Navigator stack thoughtfully to the Android back button behavior via PopScope, ensuring nested navigators (bottom nav tabs) pop their own stack before exiting the app, matching native UX expectations.
// Q. 32. How do you implement app shortcuts (long-press launcher icon) on Android?
// A. Use a plugin like quick_actions to register static/dynamic shortcuts that deep-link into specific app flows, handling the shortcut intent on cold start via platform channel.
// Q. 33. How do you handle Android keystore management across a team/CI?
// A. Store keystores encrypted in a secrets manager (not in source control), inject via CI environment variables/secure files at build time, and rotate access carefully since losing the upload key blocks future updates.
// Q. 34. What is Baseline Profiles and how does it improve performance?
// A. Baseline Profiles pre-compile critical code paths (startup, common navigation) ahead-of-time instead of relying on JIT warm-up, reducing jank and startup time; Flutter apps benefit indirectly via the engine's own AOT snapshot.
// Q. 35. How do you handle Android's Doze mode affecting network/background sync?
// A. Design background sync to be deferrable and tolerant of delay, use WorkManager with network constraints, and avoid relying on exact-time alarms for non-critical periodic sync.
// Q. 36. How do you debug a 'black screen on launch' issue specific to Android?
// A. Check for a mismatched/missing launch theme causing a blank window before the first Flutter frame, verify MainActivity's theme transitions correctly to the Flutter theme, and check for a crash in native plugin initialization.
// Q. 37. How do you handle exported components security (Android 12+ requirement)?
// A. Android 12+ requires explicitly declaring android:exported for any component with an intent-filter; audit manifest entries to ensure only intentionally public activities/services/receivers are exported, reducing attack surface.
// Q. 38. How do you implement camera functionality efficiently on Android via Flutter?
// A. Use the camera plugin backed by CameraX for lifecycle-aware camera session management, dispose the controller properly on screen exit to avoid leaks, and handle orientation/permission edge cases explicitly.
// Q. 39. How do you set up crash reporting with proper obfuscation mapping on Android?
// A. Upload ProGuard/R8 mapping files to Crashlytics/Sentry automatically via Gradle plugin integration during release builds so obfuscated stack traces are de-obfuscated in the dashboard.
// Q. 40. How do you handle large file downloads/uploads reliably on Android background?
// A. Use WorkManager with a long-running worker respecting Doze constraints, or platform-native DownloadManager for large downloads that should survive app termination, bridging progress back via a platform channel.
// Q. 41. How do you manage differing screen densities and layouts on Android?
// A. Use Flutter's logical pixel/density-independent layout system by default (MediaQuery-based responsive design) rather than Android's dp-based resource qualifiers, since Flutter abstracts density automatically.
// Q. 42. How do you handle Play Integrity API for anti-tampering/anti-fraud checks?
// A. Integrate via a platform channel to the native Play Integrity API to verify app/device integrity server-side before sensitive operations (payments, auth), rejecting requests from tampered or emulated environments.
// Q. 43. What's your strategy for supporting foldables/large screens on Android?
// A. Use adaptive layouts (LayoutBuilder/responsive breakpoints) rather than fixed phone-only UI, test with the Android Studio foldable emulator profiles, and handle hinge/posture changes gracefully where relevant.
// Q. 44. How do you handle native SplashScreen API (Android 12+) correctly?
// A. Configure flutter_native_splash to generate the windowSplashScreenBackground/icon theme attributes required by Android 12's SplashScreen API, ensuring a smooth branded transition instead of a jarring default white screen.
// Q. 45. How do you troubleshoot Play Console pre-launch report failures?
// A. Review the crash logs and screenshots from Play Console's automated device testing, reproduce locally on the flagged device/OS combination, and check for permission or ANR issues specific to that config.
// Q. 46. How do you implement app widgets (home screen widgets) with a Flutter app?
// A. Home screen widgets are native (RemoteViews on Android); build them natively and optionally share data with the Flutter app via shared local storage (e.g., shared_preferences' underlying SharedPreferences file) or a platform channel.
// Q. 47. How do you handle target SDK upgrade cycles and Play Store deadlines?
// A. Track Play Store's annual target SDK requirement, test early against new OS behavior changes in a staging track, and budget time each cycle rather than scrambling near the compliance deadline.
// Q. 48. How do you optimize network usage on Android for data-conscious users?
// A. Implement adaptive image/video quality based on connection type (connectivity_plus), cache aggressively, batch API calls, and respect Android's data saver mode signals where relevant.
// Q. 49. How do you handle StrictMode violations that surface only on Android?
// A. Enable StrictMode in debug native code to catch disk/network-on-main-thread violations often introduced by a plugin's synchronous native call, then fix by moving that work off the main thread.
// Q. 50. How do you handle Android's mandatory edge-to-edge enforcement on newer targets?
// A. Audit every screen for content hidden behind system bars, apply WindowInsets-aware padding via SafeArea/MediaQuery consistently, and test on the latest emulator early since opting out is no longer possible once targeting the new SDK.
//
// 3. Flutter — iOS Platform Specifics (50 Questions)
// Q. 1. How do you manage multiple environments (schemes/configurations) on iOS?
// A. Create separate Xcode Schemes/Build Configurations per flavor (dev/staging/prod), each with its own bundle ID, entitlements, and provisioning profile, mapped to Flutter's --flavor flag.
// Q. 2. How do you troubleshoot App Store rejections for a Flutter app?
// A. Common causes are missing privacy manifest entries, missing usage description strings, or disallowed API usage from a plugin; validate via 'flutter build ipa' and Xcode Organizer before resubmission.
// Q. 3. CocoaPods vs Swift Package Manager for Flutter plugin dependencies?
// A. Flutter has historically used CocoaPods for iOS plugin dependency management; SPM support has been added more recently, and migrating requires ensuring all third-party plugins have compatible SPM support first.
// Q. 4. How do you manage provisioning profiles and certificates across a team?
// A. Use Fastlane match to store and sync signing certificates/profiles via an encrypted git repo or cloud storage, avoiding manual certificate handling and 'works on my machine' signing issues.
// Q. 5. How does Flutter render on iOS — Metal vs OpenGL, Impeller?
// A. Flutter renders via Skia or Impeller on a Metal-backed surface, drawing its own pixels rather than composing native UIKit views; Impeller precompiles shaders ahead-of-time to avoid first-run jank.
// Q. 6. How do you handle App Tracking Transparency (ATT) requirements?
// A. Use app_tracking_transparency to show the ATT prompt before initializing any tracking SDK, and only proceed with ad/analytics tracking based on the granted authorization status.
// Q. 7. What is a Privacy Manifest (PrivacyInfo.xcprivacy) and why is it required?
// A. Apple requires declaring usage of 'required reason' APIs (file timestamps, UserDefaults, etc.) used by the app or its dependencies; missing manifests now cause App Store Connect validation rejections.
// Q. 8. How do you debug memory issues specific to iOS in a Flutter app?
// A. Use Xcode Instruments (Allocations, Leaks) alongside Flutter DevTools since native-layer leaks (e.g., AVCaptureSession not released) won't show in the Dart heap.
// Q. 9. How do you implement biometric auth (Face ID/Touch ID) on iOS?
// A. Use local_auth backed by LocalAuthentication framework, add NSFaceIDUsageDescription to Info.plist (required for Face ID), and handle fallback to passcode gracefully.
// Q. 10. How do you configure push notifications (APNs) for a Flutter iOS app?
// A. Enable Push Notifications capability and Background Modes > Remote notifications, upload the APNs auth key to Firebase (if using FCM), and request notification permission explicitly via UNUserNotificationCenter.
// Q. 11. What is App Transport Security (ATS) and how do you handle exceptions?
// A. ATS enforces HTTPS with modern TLS by default; exceptions for specific non-HTTPS domains require explicit NSAppTransportSecurity entries in Info.plist, which Apple scrutinizes during review — avoid broad exceptions.
// Q. 12. How do you handle Universal Links on iOS?
// A. Host an apple-app-site-association file on your domain (served without redirect, correct content-type), enable Associated Domains capability with applinks:, and handle the incoming NSUserActivity/link in Flutter via app_links or uni_links.
// Q. 13. What are common causes of TestFlight build processing failures?
// A. Missing export compliance info (encryption declaration), invalid entitlements not matching the provisioning profile, or missing required Info.plist keys for permissions actually used by the app or a plugin.
// Q. 14. How do you handle Keychain storage for sensitive data on iOS?
// A. Use flutter_secure_storage which wraps Keychain Services on iOS, optionally configuring accessibility level (e.g., whenUnlockedThisDeviceOnly) appropriate to the sensitivity of the stored data.
// Q. 15. How does ARC (Automatic Reference Counting) interact with Flutter plugin native code?
// A. Native iOS plugin code (Swift/Obj-C) is memory-managed via ARC; retain cycles can still occur (e.g., closures capturing self strongly in a delegate callback), requiring weak/unowned references to avoid leaks.
// Q. 16. How do you symbolicate crashes for a Flutter iOS release build?
// A. Ensure dSYM files are generated and uploaded (Crashlytics/Sentry) at archive time, since release builds strip debug symbols from the binary itself; without matching dSYMs, native crash traces are unreadable.
// Q. 17. What is app thinning and how does it reduce iOS app size?
// A. App thinning (slicing, bitcode historically, on-demand resources) delivers only the device-specific resources (e.g., correct image resolution, architecture) needed for a given device instead of a universal bundle.
// Q. 18. How do you handle Sign in with Apple requirements?
// A. Apple mandates offering Sign in with Apple if any third-party login (Google/Facebook) is offered; implement via sign_in_with_apple plugin, enabling the capability in Xcode and configuring the Services ID in Apple Developer portal.
// Q. 19. How do you test on multiple iOS versions and devices efficiently?
// A. Maintain a simulator matrix spanning supported iOS versions, use physical devices for camera/biometric/performance testing since simulators can't fully replicate hardware behavior, and leverage Xcode Cloud/Firebase Test Lab for broader coverage.
// Q. 20. How do you handle Dynamic Type and accessibility (VoiceOver) on iOS?
// A. Respect MediaQuery.textScaleFactor to honor system font size settings, add Semantics labels for custom widgets so VoiceOver announces them correctly, and test navigation order with VoiceOver enabled.
// Q. 21. What causes 'Missing Compliance' warnings in App Store Connect?
// A. Apple requires declaring export compliance (encryption usage) for every build; set ITSAppUsesNonExemptEncryption in Info.plist appropriately or answer the compliance questionnaire during submission to avoid review delays.
// Q. 22. How do you handle background fetch/background app refresh on iOS?
// A. Enable Background Modes > Background fetch/Processing capability, use BGTaskScheduler (native) bridged to Dart, keeping in mind iOS decides execution timing/frequency based on usage patterns, not a guaranteed schedule.
// Q. 23. How do you handle silent push notifications for background data sync?
// A. Send an APNs payload with content-available:1 and no alert, enable Remote notifications background mode, and keep the handler's work minimal since iOS imposes a strict execution time budget.
// Q. 24. What's the process for setting up in-app purchases (StoreKit) on iOS?
// A. Configure products in App Store Connect, use in_app_purchase plugin's StoreKit wrapper, and always verify receipts server-side (App Store Server API) to prevent client-side purchase spoofing.
// Q. 25. How do you handle iPad multitasking (Split View/Slide Over) layout?
// A. Design with adaptive/responsive layouts using LayoutBuilder rather than fixed dimensions, since the app's window size can change dynamically as the user resizes Split View panes.
// Q. 26. How do you configure Associated Domains for both Universal Links and other features?
// A. Add multiple applinks:/webcredentials: entries as needed in the Associated Domains capability, and ensure the apple-app-site-association file lists all relevant paths/components correctly.
// Q. 27. How do you handle screen recording/screenshot protection for sensitive screens on iOS?
// A. Detect UIScreen.capturedDidChangeNotification (screen recording) and use techniques like overlaying a blank view during app backgrounding to prevent sensitive content appearing in the app switcher snapshot.
// Q. 28. How do you debug a build that works in simulator but crashes on device?
// A. Check for architecture-specific issues (arm64 vs simulator arch), missing entitlements only enforced on real devices (Keychain access groups, push), or native library incompatibilities not caught by the simulator.
// Q. 29. How do you handle App Store review guideline rejections around 'sign in required'?
// A. Apple often requires a way to browse core functionality without forced account creation, or requires offering account deletion within the app if account creation is offered — plan these flows proactively.
// Q. 30. How do you implement Handoff or universal clipboard features on iOS with Flutter?
// A. These require native NSUserActivity integration bridged via a platform channel since Flutter has no built-in Handoff API; typically a lower-priority native-only feature unless specifically required.
// Q. 31. How do you manage Info.plist keys for a Flutter app with many plugins?
// A. Audit each plugin's required Info.plist entries during integration (camera, location, contacts usage descriptions), keep them accurate and specific (vague descriptions risk App Review rejection), and review on every plugin upgrade.
// Q. 32. What's your approach to reducing iOS app size (on-demand resources, asset catalogs)?
// A. Use asset catalogs for proper image set management, leverage on-demand resources for rarely-needed large assets, and audit font/image bundling similarly to the Android size optimization approach.
// Q. 33. How do you handle Xcode Cloud vs Fastlane for CI/CD on iOS?
// A. Xcode Cloud is Apple's native CI tightly integrated with App Store Connect and simpler to set up; Fastlane offers more cross-platform flexibility and scriptability, often preferred when the same pipeline also handles Android.
// Q. 34. How do you handle orientation lock requirements that differ per screen?
// A. Use SystemChrome.setPreferredOrientations dynamically per route/screen rather than a single global manifest-level lock, resetting appropriately when navigating away.
// Q. 35. How do you troubleshoot a plugin causing 'Undefined symbol' linker errors on iOS?
// A. Usually a missing framework dependency or CocoaPods version mismatch; run pod install with an updated Podfile.lock, check the plugin's minimum iOS deployment target compatibility, and verify architecture settings (excluded arm64 simulator slices).
// Q. 36. How do you handle camera/photo library permission changes across iOS versions?
// A. Add precise NSCameraUsageDescription/NSPhotoLibraryUsageDescription (and NSPhotoLibraryAddUsageDescription for write-only access on newer iOS), and handle the newer limited-photo-library-access picker UX introduced in iOS 14+.
// Q. 37. How do you handle App Clips for a Flutter-based app?
// A. App Clips require a separate lightweight native target with a strict size limit; a full Flutter engine is generally too heavy, so App Clips are typically built natively or with a highly stripped-down Flutter configuration.
// Q. 38. How do you verify entitlements match between provisioning profile and Xcode project?
// A. Cross-check the .entitlements file capabilities against what's enabled in the Apple Developer portal for that App ID/profile; mismatches cause silent failures (e.g., push not working) rather than build errors.
// Q. 39. How do you handle iOS Simulator limitations for testing camera/push/biometrics?
// A. Simulators can't test real camera hardware, push notifications (until recent Xcode versions added limited simulated push), or real biometric hardware — these require physical device testing before release.
// Q. 40. How do you set minimum deployment target and handle API availability checks?
// A. Set the Podfile/Xcode deployment target to the oldest iOS version supported by the business, and for any native plugin code using newer APIs, wrap with @available/if #available checks to avoid crashes on older devices.
// Q. 41. How do you handle App Store Connect API automation for releases?
// A. Use Fastlane's App Store Connect API key-based authentication (avoiding 2FA-blocked session logins) to automate build upload, TestFlight distribution, and metadata updates in CI.
// Q. 42. How do you debug 'This app is no longer verified' developer trust issues on ad-hoc/enterprise builds?
// A. This occurs when a user hasn't trusted the enterprise/ad-hoc signing certificate in Settings > General > VPN & Device Management; guide testers through the trust step post-install.
// Q. 43. How do you handle dark mode transitions and dynamic colors on iOS?
// A. Use Flutter's ThemeMode.system with a well-defined ColorScheme, and test both native iOS system UI elements (status bar style) and Flutter-rendered UI together for consistency during OS-level appearance switches.
// Q. 44. How do you implement Live Activities or Dynamic Island support?
// A. This requires a native iOS 16+ WidgetKit extension target outside Flutter's rendering, with data passed from the Flutter app via shared app group storage or a platform channel trigger.
// Q. 45. How do you handle iOS 17+ interactive widgets or new privacy report requirements?
// A. Stay current via Apple's yearly WWDC platform changes; interactive home screen widgets remain native-only, and privacy nutrition label / manifest requirements must be re-audited whenever adding new third-party SDKs.
// Q. 46. How do you set up notarization considerations if targeting macOS via Flutter?
// A. macOS builds require notarization through Apple's notary service (via Xcode or notarytool) and hardened runtime entitlements, distinct from iOS's App Store review process, before distributing outside the Mac App Store.
// Q. 47. How do you handle differing safe area insets across iPhone models (notch, Dynamic Island)?
// A. Rely on Flutter's SafeArea widget and MediaQuery.padding rather than hardcoding insets, since these values are automatically supplied per-device by the engine reading native safe area guides.
// Q. 48. How do you manage Fastlane lanes for a multi-flavor Flutter iOS app?
// A. Define separate lanes per flavor/environment handling scheme selection, version bumping, signing, and upload, often parameterized so CI can invoke 'fastlane ios release flavor:prod' style commands consistently.
// Q. 49. How do you handle a rejected build due to 'uses non-public API' from a plugin?
// A. Identify the offending plugin via the rejection's binary analysis detail, check for a maintained alternative or newer plugin version, and as a last resort patch/fork the plugin to remove the private API call.
// Q. 50. How do you plan for yearly iOS SDK/Xcode upgrade cycles as a TL?
// A. Track Apple's fall OS release and spring Xcode/App Store deadlines, budget dedicated time each cycle to test against new privacy/API changes in a staging track well before the compliance deadline forces a rush.
//
// 4. Go — Core & Advanced (50 Questions)
// Q. 1. Explain goroutines and the Go scheduler (GMP model).
// A. G (goroutine), M (OS thread), P (processor context) — the scheduler multiplexes goroutines onto few OS threads with per-P run queues and work-stealing, letting Go handle huge concurrency cheaply via small growable stacks.
// Q. 2. Channels vs Mutex — when do you use each?
// A. Channels suit ownership transfer and coordination between goroutines ('share memory by communicating'); Mutex suits protecting simple shared state like a counter or map where channel overhead is unnecessary.
// Q. 3. How does Go's garbage collector work and how do you tune it?
// A. Go uses a concurrent tri-color mark-and-sweep GC minimizing stop-the-world pauses; tune via GOGC (heap growth trigger) or GOMEMLIMIT, and reduce allocation pressure with sync.Pool for hot paths.
// Q. 4. Explain context.Context and its anti-patterns.
// A. Context propagates cancellation, deadlines, and request-scoped values across call chains and goroutines. Anti-patterns: storing business data in it, passing nil, or forgetting to call cancel(), which leaks resources.
// Q. 5. How do you structure a large Go microservice's codebase?
// A. cmd/ for entrypoints, internal/ organized by domain (not technical layer) with interfaces at boundaries for testability, pkg/ for externally-importable code, and explicit constructor-based dependency injection.
// Q. 6. What's your error handling philosophy in Go?
// A. Errors are explicit values, wrapped with fmt.Errorf("...: %w", err) to preserve the chain, compared with errors.Is/errors.As, and never silently swallowed — always handled or propagated with context.
// Q. 7. How do you avoid goroutine leaks in long-running services?
// A. Every goroutine has a clear termination path tied to a context or channel close; configure DB pool limits explicitly, use query timeouts, and monitor goroutine counts via pprof in production.
// Q. 8. How do you design a Go API for backward compatibility (REST/gRPC)?
// A. For protobuf, never reuse/renumber field tags and add fields as optional; for REST, version the URL/header and keep DTOs separate from internal domain models so refactors don't break contracts.
// Q. 9. How do you profile a Go service in production?
// A. Expose net/http/pprof on an internal-only route for CPU/heap/goroutine profiles, and use continuous profiling tools (Pyroscope, Cloud Profiler) to catch issues without needing to reproduce manually.
// Q. 10. Explain worker pool and fan-in/fan-out patterns.
// A. A worker pool bounds concurrency by having N goroutines consume from a shared job channel; fan-out distributes work across goroutines, fan-in merges result channels using a WaitGroup to know when to close the merged channel.
// Q. 11. What is the difference between a buffered and unbuffered channel?
// A. An unbuffered channel blocks the sender until a receiver is ready (synchronous handoff); a buffered channel allows sending up to its capacity without blocking, decoupling sender and receiver timing.
// Q. 12. How does the select statement work with channels?
// A. select waits on multiple channel operations simultaneously, proceeding with whichever is ready first (randomly if multiple are ready); a default case makes it non-blocking, useful for polling or timeouts.
// Q. 13. Explain sync.Once and a real use case.
// A. sync.Once guarantees a function runs exactly once even under concurrent calls, commonly used for lazy singleton initialization (e.g., a shared DB connection pool or config loader) safely across goroutines.
// Q. 14. What are atomic operations and when do you prefer them over Mutex?
// A. sync/atomic provides lock-free operations (Add, CompareAndSwap) on simple values like counters, offering lower overhead than a Mutex for single-variable updates under high contention.
// Q. 15. How do Go interfaces enable polymorphism without inheritance?
// A. Interfaces are satisfied implicitly — any type implementing the required methods satisfies the interface without explicit declaration, enabling structural typing and easy mocking for tests via small, focused interfaces.
// Q. 16. Explain struct embedding and how it differs from inheritance.
// A. Embedding composes a struct by including another type anonymously, promoting its fields/methods to the outer struct — it's composition, not inheritance; there's no polymorphic dispatch back to the embedding type.
// Q. 17. How do panics and recover work, and when should you use them?
// A. panic unwinds the stack running deferred calls until recovered or the program crashes; recover (inside a deferred func) stops that unwind. Reserve panics for truly unrecoverable programmer errors, not expected error conditions.
// Q. 18. Explain defer's execution order and common pitfalls.
// A. Deferred calls execute in LIFO order when the surrounding function returns. A common pitfall is deferring inside a loop (accumulating deferred calls until function end) or capturing a loop variable incorrectly before Go 1.22's per-iteration scoping.
// Q. 19. Slices vs arrays in Go — key differences?
// A. Arrays have fixed size and are value types (copied on assignment); slices are dynamically-sized views over an underlying array, passed by reference-like semantics (header copied, backing array shared).
// Q. 20. How do Go maps work internally and are they safe for concurrent use?
// A. Maps are hash tables with dynamic resizing; they are NOT safe for concurrent read/write — concurrent map access without synchronization panics at runtime ('concurrent map writes'), requiring a Mutex or sync.Map.
// Q. 21. Explain Go generics and when you'd use them.
// A. Generics (since Go 1.18) allow type-parameterized functions/types via constraints, useful for reusable data structures (generic Set/Stack) or utility functions (Map/Filter/Reduce) without resorting to interface{} and type assertions.
// Q. 22. How does reflection work in Go and what's the performance cost?
// A. The reflect package inspects types/values at runtime (used by encoding/json, ORMs); it bypasses compile-time type safety and is significantly slower than direct code, so it's avoided in hot paths.
// Q. 23. How do you write table-driven tests in Go?
// A. Define a slice of struct cases (input, expected output, name) and iterate with t.Run(tc.name, func(t *testing.T) {...}) for isolated, clearly-named subtests that are easy to extend.
// Q. 24. How do you write and interpret Go benchmarks?
// A. Use func BenchmarkX(b *testing.B) with b.N-driven loops, run via 'go test -bench=. -benchmem', and interpret ns/op and allocs/op to compare implementations objectively rather than guessing performance.
// Q. 25. What is escape analysis and how does it affect performance?
// A. The compiler determines whether a variable can stay on the stack or must 'escape' to the heap (e.g., if a pointer to it is returned); heap allocations add GC pressure, so minimizing unnecessary escapes improves performance.
// Q. 26. How do you design HTTP middleware in Go (net/http or a framework)?
// A. Middleware wraps an http.Handler, returning a new handler that runs logic (logging, auth, recovery) before/after calling the next handler in the chain, composed via a chain/router library or manual wrapping.
// Q. 27. gRPC vs REST — when do you choose gRPC for a Go service?
// A. gRPC suits internal service-to-service communication needing strong typing, streaming, and performance (HTTP/2, protobuf binary encoding); REST/JSON remains more accessible for public APIs and browser clients without gRPC-Web tooling.
// Q. 28. How do you manage database connections and pooling in Go?
// A. Configure database/sql's MaxOpenConns, MaxIdleConns, and ConnMaxLifetime explicitly based on downstream DB limits, and always pass a context with timeout to queries to prevent held connections during slow queries.
// Q. 29. ORM (gorm) vs raw SQL — tradeoffs in a Go service?
// A. ORMs speed up development and reduce boilerplate but can obscure generated queries and hurt performance on complex joins; raw SQL (or sqlc for type-safe generated code) gives full control, preferred for performance-critical paths.
// Q. 30. How do you handle database migrations in a Go service?
// A. Use a migration tool (golang-migrate, goose) with versioned up/down SQL files, run migrations as a separate CI/CD step before deploying new code, and never rely on ORM auto-migration in production.
// Q. 31. How do you integrate a message queue (Kafka/NATS) into a Go service?
// A. Use the official/community client library, design consumers with proper offset/ack handling for at-least-once semantics, and ensure idempotent message processing since redelivery is possible after crashes.
// Q. 32. How do you implement rate limiting in Go?
// A. Use golang.org/x/time/rate's token bucket limiter for in-process limiting, or a distributed limiter (Redis-backed) for multi-instance services, applied as middleware on sensitive or expensive endpoints.
// Q. 33. How do you implement a circuit breaker pattern in Go?
// A. Use a library like sony/gobreaker or hand-roll one tracking failure rate over a rolling window, tripping to an 'open' state that fails fast and periodically allows a trial request to test recovery ('half-open').
// Q. 34. How do you implement retries with exponential backoff?
// A. Wrap the call in a retry loop with increasing delay (base * 2^attempt) plus jitter to avoid thundering herd, capping max attempts and respecting context cancellation/deadline throughout.
// Q. 35. How do you implement structured logging in Go?
// A. Use log/slog (standard library since Go 1.21) or zerolog/zap for structured key-value logging with levels, ensuring request-scoped fields (trace ID, user ID) are consistently attached via context-derived loggers.
// Q. 36. How do you manage configuration across environments in a Go service?
// A. Use environment variables (12-factor) loaded via a typed config struct (viper or envconfig), validated at startup so misconfiguration fails fast rather than causing subtle runtime bugs.
// Q. 37. Explain Go modules and semantic import versioning.
// A. go.mod declares module dependencies with semantic versions; major version upgrades (v2+) require a path suffix change (e.g., /v2) since Go treats different major versions as distinct import paths for compatibility.
// Q. 38. How do you cross-compile a Go binary for different platforms?
// A. Set GOOS and GOARCH environment variables (e.g., GOOS=linux GOARCH=amd64 go build) — Go's toolchain natively supports cross-compilation without needing platform-specific build machines for pure Go code.
// Q. 39. How do you write an efficient multi-stage Dockerfile for a Go service?
// A. Build in a golang base image producing a static binary (CGO_ENABLED=0), then copy just the binary into a minimal final image (distroless or alpine) to drastically reduce image size and attack surface.
// Q. 40. How do you implement graceful shutdown for a Go HTTP server?
// A. Listen for SIGTERM/SIGINT, stop accepting new connections via server.Shutdown(ctx) with a timeout, let in-flight requests complete, and close resources (DB pools, queue consumers) in a defined order before exiting.
// Q. 41. How do you implement health checks and readiness probes for Kubernetes?
// A. Expose separate /healthz (liveness — is the process alive) and /readyz (readiness — can it serve traffic, e.g., DB reachable) endpoints, since conflating them can cause Kubernetes to kill healthy-but-warming-up pods.
// Q. 42. How do you integrate distributed tracing (OpenTelemetry) in Go?
// A. Instrument HTTP/gRPC handlers and DB calls with OTel SDK spans, propagate trace context across service boundaries via headers, and export to a backend (Jaeger/Tempo) for end-to-end request visibility.
// Q. 43. How do you expose Prometheus metrics from a Go service?
// A. Use the prometheus/client_golang library to register counters/histograms/gauges, expose a /metrics endpoint, and instrument key paths (request duration, error counts, queue depth) for dashboards and alerting.
// Q. 44. How do you prevent SQL injection in Go database code?
// A. Always use parameterized queries (? placeholders via database/sql or prepared statements) rather than string concatenation, and validate/sanitize any dynamic identifiers (table/column names) that can't be parameterized.
// Q. 45. How do you implement JWT-based authentication middleware in Go?
// A. Parse and validate the token signature/expiry in middleware before the handler runs, attach claims to the request context, and reject early with 401 on invalid/expired tokens rather than deep in business logic.
// Q. 46. How do you mock interfaces for unit testing in Go?
// A. Define small interfaces at consumer boundaries, generate mocks via mockgen/mockery, and inject the mock through the constructor in tests to isolate the unit under test from real dependencies (DB, HTTP).
// Q. 47. What does Go's race detector do and how do you use it?
// A. go test -race / go run -race instruments the binary to detect concurrent unsynchronized access to shared memory at runtime, catching data races that are otherwise hard to reproduce deterministically.
// Q. 48. How do you handle struct memory alignment/padding for performance-sensitive code?
// A. Order struct fields from largest to smallest alignment requirement to minimize padding, use go vet's fieldalignment or unsafe.Sizeof checks when memory footprint matters (e.g., large slices of structs).
// Q. 49. How do you decide between microservices communicating via gRPC vs an async message queue?
// A. gRPC suits synchronous request/response needing an immediate answer; a message queue suits decoupled, eventually-consistent workflows where the producer shouldn't block on the consumer's availability or processing time.
// Q. 50. How do you use go vet and golangci-lint effectively in a large Go codebase?
// A. Run them as a required CI gate (not just a local suggestion), enable a curated set of linters (unused, errcheck, govet, staticcheck) rather than every possible rule, and fix flagged issues incrementally rather than disabling checks wholesale.
//
// 5. System Design / Architecture — TL Level (50 Questions)
// Q. 1. Design a real-time chat app (Flutter + Go).
// A. Go backend with gRPC-bidi/WebSocket streams per user, Kafka/NATS for cross-instance fan-out, Redis for presence, Postgres for message history. Flutter caches messages locally (offline-first) and reconciles via server-assigned IDs on reconnect.
// Q. 2. Design shared authentication (OAuth2/JWT) between Flutter and Go.
// A. Short-lived JWT access tokens plus refresh tokens validated via middleware; Flutter stores tokens in secure storage, attaches them via an interceptor, and performs a single in-flight silent refresh on 401 to avoid stampedes.
// Q. 3. How do you manage API contracts between mobile and backend teams?
// A. Standardize on protobuf/gRPC or OpenAPI as the source of truth, codegen into both Dart and Go, and run breaking-change detection in CI before merge so contract drift is caught early.
// Q. 4. Design a CI/CD pipeline for a multi-flavor Flutter app and Go microservices.
// A. Flutter: PR tests → flavor builds → staged store rollout. Go: PR tests/lint → container build → GitOps staging deploy → smoke tests → canary production rollout with automated rollback on SLO breach.
// Q. 5. Design a caching strategy spanning client and server.
// A. Server: Redis cache-aside plus HTTP caching headers/CDN for cacheable GETs. Client: local cache (Hive/Drift) with stale-while-revalidate, using ETags to avoid re-downloading unchanged data.
// Q. 6. Monolith vs microservices for a mid-sized team — how does it affect mobile?
// A. Start with a modular monolith to avoid premature distributed-systems overhead; microservices would require a BFF/API gateway layer so the mobile client isn't orchestrating many service calls directly.
// Q. 7. Design an offline-first sync system for a mobile app.
// A. Local-first writes to an on-device DB with a sync queue, background sync via WorkManager/BGTask pushing changes with a server-assigned version/vector clock, and conflict resolution (last-write-wins or field-level merge) defined explicitly per entity.
// Q. 8. Design a ride-sharing matching system backend.
// A. Geospatial indexing (geohash/H3) for nearby driver lookup, a matching service scoring candidates by distance/ETA/rating, real-time location updates via streaming, and a state machine (requested→matched→enroute→completed) with idempotent transitions.
// Q. 9. Design a notification delivery system at scale (push, email, SMS).
// A. A central notification service abstracts channels behind a common interface, queues requests (Kafka) for async fan-out, uses per-channel providers (FCM/APNs, SendGrid, Twilio) with retry/backoff, and tracks delivery status for analytics.
// Q. 10. Design a file upload/download system for large files.
// A. Use presigned S3/GCS URLs so clients upload directly to object storage (not through the app server), support resumable/chunked uploads for large files on mobile, and trigger async processing (thumbnailing, virus scan) via event notifications.
// Q. 11. Design an API rate limiting system for a public API.
// A. Token bucket per API key at the gateway layer, backed by Redis for distributed counting across instances, with tiered limits per plan and clear 429 responses including Retry-After headers.
// Q. 12. Design an API gateway / BFF layer for a mobile client.
// A. The BFF aggregates calls to multiple backend microservices into mobile-optimized responses, handles auth termination, and shields the client from internal service topology changes, reducing mobile round-trips.
// Q. 13. How would you design a feature flag system for gradual rollouts?
// A. A central flag service with SDKs for both Flutter and Go, supporting percentage rollout, user/segment targeting, and a kill-switch; flags are cached locally with periodic refresh so evaluation doesn't add request latency.
// Q. 14. Design an event-driven architecture for an e-commerce order pipeline.
// A. Order service emits events (OrderPlaced, PaymentConfirmed, Shipped) to a broker; downstream services (inventory, notifications, analytics) consume independently, decoupling them and allowing new consumers without touching the order service.
// Q. 15. What is CQRS and when would you apply it?
// A. Command Query Responsibility Segregation splits write and read models, useful when read and write scaling/shape needs diverge significantly (e.g., complex reporting reads vs simple transactional writes) — adds complexity, so only apply when justified.
// Q. 16. Design a database sharding strategy for a rapidly growing service.
// A. Choose a shard key with even distribution and query locality (e.g., user_id), use consistent hashing or range-based sharding, and plan a resharding/migration strategy before you're forced into it under load.
// Q. 17. How do you design for idempotency in payment/order APIs?
// A. Require an idempotency key from the client per request, store processed key results server-side, and return the cached result on retry rather than reprocessing, preventing duplicate charges/orders from network retries.
// Q. 18. Design a distributed locking mechanism for a Go service cluster.
// A. Use Redis (Redlock) or a consensus store (etcd/ZooKeeper) for lock acquisition with a TTL and fencing token to prevent stale-lock-holder issues after a process pause or crash.
// Q. 19. How would you design blue-green vs canary deployments for the Go backend?
// A. Blue-green runs two full environments and switches traffic atomically for instant rollback; canary gradually shifts a small traffic percentage to the new version, monitoring SLOs before full rollout — canary catches issues earlier with less blast radius.
// Q. 20. Design a disaster recovery / backup strategy for a production system.
// A. Automated regular backups with tested restore procedures (not just backup creation), multi-region replication for critical data, defined RPO/RTO targets, and periodic DR drills to validate the plan actually works.
// Q. 21. How do you design monitoring/alerting to avoid alert fatigue?
// A. Alert on symptoms (error rate, latency, saturation) tied to user impact/SLOs rather than every possible metric, use tiered severity with clear runbooks, and regularly prune noisy/non-actionable alerts.
// Q. 22. Explain SLA, SLO, and error budgets, and how they guide engineering decisions.
// A. SLA is the external commitment, SLO the internal target (e.g., 99.9% availability), and the error budget is the allowed failure margin — when it's being burned too fast, the team prioritizes stability over new features.
// Q. 23. How do you design API versioning strategy long-term?
// A. Prefer additive, backward-compatible changes by default; introduce a new version only for breaking changes, support N-1 versions for a defined deprecation window, and communicate deprecations well in advance to client teams.
// Q. 24. GraphQL vs REST vs gRPC — how do you choose for a given use case?
// A. GraphQL suits flexible client-driven data needs (mobile avoiding over/under-fetching); REST is simple and cacheable for public APIs; gRPC suits performant internal service-to-service or strongly-typed streaming needs.
// Q. 25. How do you design conflict resolution for offline-first mobile sync?
// A. Define per-field or per-entity merge rules (last-write-wins with server timestamp, or CRDTs for collaborative data), and surface unresolvable conflicts to the user when automatic merging isn't safe (e.g., conflicting edits to the same field).
// Q. 26. Design a push notification infrastructure handling millions of devices.
// A. Batch and queue notification jobs, shard by provider (FCM/APNs) with dedicated worker pools respecting each provider's rate limits, and use token invalidation handling to prune dead device tokens automatically.
// Q. 27. Design an image/video processing pipeline (resize, transcode, thumbnail).
// A. Upload triggers an async event (S3 event → queue), worker services (potentially separate scaling group) process via ffmpeg/image libraries, results stored back to object storage, with a callback/webhook or status polling for the client.
// Q. 28. How do you design a geolocation-based 'nearby' feature efficiently?
// A. Use a geospatial index (PostGIS, geohash, or a dedicated service like Elasticsearch geo queries) rather than naive distance calculation over all rows, with periodic index updates for moving entities.
// Q. 29. Design a multi-region deployment for global low-latency access.
// A. Deploy read replicas/edge caches close to users, route via GeoDNS or a global load balancer, and carefully choose data consistency model (eventual vs strong) per data type since cross-region strong consistency adds significant latency.
// Q. 30. How do you decide between eventual and strong consistency for a given feature?
// A. Financial/inventory-critical operations typically need strong consistency; social feeds, view counts, or presence indicators tolerate eventual consistency for better availability/performance — the decision should map to actual business impact of staleness.
// Q. 31. Design a webhook delivery system for third-party integrations.
// A. Queue outbound webhook events, deliver with retry/exponential backoff and signature verification (HMAC), track delivery status/failures, and provide a dashboard/logs for integrators to debug failed deliveries.
// Q. 32. How do you design secure presigned URL file access (S3) with expiry?
// A. Generate short-lived presigned URLs scoped to a specific object and action (GET/PUT), avoid overly long expiry windows, and pair with server-side access control checks before generating the URL in the first place.
// Q. 33. Design an audit logging system for compliance requirements.
// A. Emit structured, immutable audit events (who/what/when/before-after state) to an append-only store, separate from application logs, with retention policies matching compliance requirements (SOC2/GDPR) and restricted write access.
// Q. 34. How would you design a job scheduler service in Go?
// A. A scheduler service persists job definitions with cron/interval config, a leader-elected or distributed-lock-protected dispatcher triggers due jobs into a queue, and workers process with idempotency and retry handling for failures.
// Q. 35. Design a basic recommendation system architecture.
// A. Collect interaction events into a data pipeline, compute offline features/embeddings (batch), serve via a low-latency lookup (precomputed recommendations or an approximate nearest-neighbor index), with an online feedback loop to refine over time.
// Q. 36. How do you design authentication for a B2B multi-tenant application?
// A. Support org-level SSO (SAML/OIDC) alongside standard auth, scope every data access query by tenant ID at the data layer (not just the API layer) to prevent cross-tenant data leakage, and isolate tenant data logically or physically based on compliance needs.
// Q. 37. How do you approach capacity planning for an upcoming high-traffic launch?
// A. Load test against realistic traffic patterns (not just peak RPS but request mix), identify bottleneck tiers (DB connections, third-party API rate limits), and plan auto-scaling policies plus a manual override/runbook for the launch window.
// Q. 38. How do you design a system to be GDPR/privacy compliant from the start?
// A. Data minimization (collect only what's needed), clear data retention/deletion policies enforced by automated jobs, a documented data map of where PII lives, and a defined process for handling data subject access/deletion requests.
// Q. 39. Design a real-time analytics dashboard architecture.
// A. Stream events into a time-series/analytics store (ClickHouse, BigQuery) via a queue, precompute common aggregations, and serve the dashboard via cached queries with a short TTL rather than hitting raw event data live for every view.
// Q. 40. Design a social media feed (fan-out on write vs read).
// A. Fan-out on write (push to follower feeds at post time) suits normal users with moderate follower counts for fast reads; fan-out on read (compute feed at request time) suits celebrities with huge follower counts to avoid a write amplification storm — often a hybrid.
// Q. 41. How do you design a retry-safe integration with a flaky third-party API?
// A. Wrap calls with a circuit breaker and exponential backoff, cache successful responses where staleness is tolerable, and design your own API to degrade gracefully (partial data, cached fallback) rather than fully failing when the third party is down.
// Q. 42. How do you design database read replicas for scaling read-heavy workloads?
// A. Route read-heavy, tolerant-of-slight-staleness queries to replicas while writes and consistency-critical reads go to the primary, being mindful of replication lag causing 'read your own write' issues right after a write.
// Q. 43. How do you design a search feature (e.g., product search) at scale?
// A. Use a dedicated search engine (Elasticsearch/OpenSearch/Algolia) with indexed, denormalized documents kept in sync via change-data-capture or explicit reindex events, rather than querying the primary relational DB directly for full-text search.
// Q. 44. How would you design a leader election mechanism for a Go service cluster?
// A. Use a coordination service (etcd, Consul, ZooKeeper) with lease-based leader election, ensuring the elected leader periodically renews its lease and other nodes can take over quickly on failure detection.
// Q. 45. Design a payment integration architecture that's PCI-compliant friendly.
// A. Never store raw card data — use a PCI-compliant processor (Stripe/Braintree) with tokenization, keep sensitive fields out of your own logs/DB entirely, and isolate the payment flow behind a dedicated service with tight access controls.
// Q. 46. How do you design service-to-service communication security in a microservices setup?
// A. Use mutual TLS (mTLS) between services, short-lived service identity tokens (SPIFFE/SPIRE or similar), and network-level segmentation so a compromised service can't freely call every other internal service.
// Q. 47. How do you approach designing for horizontal scalability from day one?
// A. Keep services stateless (session/state externalized to Redis/DB), design idempotent operations so retries/duplicate delivery are safe, and avoid sticky-session dependencies that prevent adding/removing instances freely.
// Q. 48. How do you design a system to handle a sudden 10x traffic spike gracefully?
// A. Auto-scaling with pre-warmed capacity where cold-start is slow, load shedding/priority queuing for non-critical requests under extreme load, and circuit breakers to protect downstream dependencies from cascading failure.
// Q. 49. How do you decide what belongs in the mobile client vs the backend for business logic?
// A. Keep authoritative business logic (pricing, validation, entitlements) server-side to prevent client tampering and ensure consistency across platforms; client-side logic should be limited to UX responsiveness (optimistic updates, local validation for immediate feedback).
// Q. 50. How do you design a system for zero-downtime schema migrations in production?
// A. Use expand-contract migration: add new columns/tables as nullable/additive first, deploy code that writes to both old and new, backfill data, switch reads to new, then remove the old schema only after full cutover is verified.
//
// 6. Leadership & TL-Specific (50 Questions)
// Q. 1. How do you balance hands-on coding with leadership responsibilities?
// A. Protect focused blocks for high-leverage/architecture-critical coding, while keeping review, mentoring, and unblocking as ongoing responsibilities; picking up complex tasks myself keeps me close to the codebase and sets standards by example.
// Q. 2. Describe a time you made an unpopular technical decision.
// A. Frame with context → decision → pushback → resolution: typically a written RFC laying out tradeoffs, a time-boxed spike to validate concerns empirically, and involving skeptics directly in evaluation for buy-in.
// Q. 3. How do you mentor engineers across both Flutter and Go stacks?
// A. Encourage cross-stack rotation with a buddy system for first cross-stack tasks, run design/code review sessions explaining reasoning not just verdicts, and maintain ADRs so patterns are discoverable, not tribal knowledge.
// Q. 4. How do you resolve architecture disagreements (e.g., state management debates)?
// A. Frame it around explicit criteria (team familiarity, testability, maintenance cost) via a lightweight RFC rather than a preference debate; favor consistency with existing patterns unless the new option is clearly superior.
// Q. 5. What's your code review philosophy?
// A. Prioritize correctness, architectural fit, and testability over style (automated via linters); review within hours to avoid blocking; distinguish blocking vs nice-to-have comments; use reviews as teaching moments explaining the 'why'.
// Q. 6. How do you manage technical debt vs feature delivery pressure?
// A. Keep a visible, impact-framed debt backlog (velocity, incidents, onboarding friction), negotiate a fixed sprint percentage for paydown, and tie high-impact debt items to upcoming feature work as natural prerequisites.
// Q. 7. How do you evaluate and onboard new technologies into the stack?
// A. Assess maintenance activity, community size, license, and architectural fit; run a time-boxed pilot in a non-critical feature before wide adoption; document the decision and alternatives considered in an ADR.
// Q. 8. Tell me about leading cross-functional coordination between mobile, backend, and QA.
// A. Set up a shared API contract early so teams work in parallel against mocks, established a shared Definition of Done including QA sign-off, and ran regular sync checkpoints to catch integration risk early.
// Q. 9. How do you handle a senior engineer who consistently pushes back on your direction?
// A. First ensure I understand their concern genuinely; have a direct 1:1 separating technical disagreement from relationship friction; invite a rigorous counter-proposal; if still unresolved, decide, document reasoning, and expect commitment to execution.
// Q. 10. How do you manage underperforming team members?
// A. Identify root cause (skill gap, unclear expectations, external factors) through direct conversation, set specific measurable improvement goals with a defined timeline, provide support/mentoring, and escalate to HR/PIP only after genuine good-faith effort fails.
// Q. 11. How do you structure effective 1:1s with your engineers?
// A. Make it primarily their agenda, not a status update — career growth, blockers, feedback both ways; I keep light notes to track commitments and follow up consistently so 1:1s build trust over time.
// Q. 12. How do you set and communicate technical roadmaps to stakeholders?
// A. Translate technical initiatives into business impact/outcomes, sequence by risk and dependency, communicate tradeoffs explicitly (what we're not doing and why), and revisit the roadmap regularly as priorities shift.
// Q. 13. How do you handle scope creep from product mid-sprint?
// A. Distinguish genuinely urgent changes from scope creep; if it's not urgent, capture it for the next planning cycle; if it is, make the tradeoff explicit (what gets deprioritized) rather than silently absorbing the extra work.
// Q. 14. How do you run a blameless incident postmortem?
// A. Focus on systemic/process causes rather than individual blame, build a clear timeline, identify actionable follow-ups with owners and deadlines, and share learnings broadly so the same class of issue is less likely to recur.
// Q. 15. How do you handle disagreements with product management on priorities?
// A. Present the technical tradeoffs and risks clearly in business terms, seek to understand their constraints too, and aim for a joint decision — escalating to a shared leader only when we genuinely can't align after good-faith discussion.
// Q. 16. How do you build a strong engineering hiring process for your team?
// A. Define a clear rubric upfront (not just 'gut feel'), calibrate interviewers regularly to reduce bias/inconsistency, include both technical depth and collaboration signal, and gather structured feedback before group discussion to avoid anchoring.
// Q. 17. How do you evaluate a candidate's system design skills in an interview?
// A. Present an open-ended, ambiguous problem and watch how they clarify requirements, reason about tradeoffs out loud, and adapt when I introduce new constraints — the process matters more than arriving at one 'correct' design.
// Q. 18. How do you approach delegation as a TL without micromanaging?
// A. Delegate outcomes and context, not step-by-step instructions; check in at meaningful milestones rather than daily; give people room to make different-but-valid choices, and use mistakes as coaching opportunities, not reasons to take work back.
// Q. 19. How do you give difficult feedback without damaging trust?
// A. Address it privately and promptly rather than letting it fester, focus on specific observed behavior and impact rather than character, and frame it as wanting them to succeed rather than as criticism for its own sake.
// Q. 20. How do you handle a production incident you personally caused?
// A. Own it immediately and transparently, focus energy on mitigation first and root-cause analysis second, communicate status clearly to stakeholders, and treat the postmortem the same way I would for anyone else's mistake.
// Q. 21. How do you drive adoption of a new engineering practice (e.g., testing standards)?
// A. Start with a pilot on a willing team/project to demonstrate value concretely, get influential engineers as early advocates, provide tooling/templates that make the right way the easy way, then roll out more broadly with support.
// Q. 22. How do you manage cross-timezone team coordination effectively?
// A. Maximize async communication (written design docs, recorded updates) over live meetings, establish a small deliberate overlap window for critical syncs, and ensure decisions/context are documented so no timezone is left out of the loop.
// Q. 23. How do you communicate technical debt impact to non-technical stakeholders?
// A. Translate into business terms — slower feature delivery, increased incident rate, harder onboarding — with concrete examples/metrics rather than abstract code-quality language, so it competes fairly with feature asks for prioritization.
// Q. 24. How do you approach on-call rotation design for a small team?
// A. Balance fairness (rotating burden evenly) with sustainability (reasonable shift length, compensation/time-off for pages), invest in good alerting/runbooks to reduce false alarms, and review on-call load regularly to catch burnout early.
// Q. 25. How do you handle a disagreement with your own manager on technical direction?
// A. Present my reasoning and data clearly, genuinely listen to their broader context I might be missing, seek a decision framework we both agree on, and commit fully to the final decision once made, even if not my first choice.
// Q. 26. How do you build psychological safety on an engineering team?
// A. Model vulnerability by admitting my own mistakes openly, respond to bad news/bug reports with curiosity rather than blame, and explicitly encourage dissenting opinions in design discussions rather than just seeking agreement.
// Q. 27. How do you approach promoting engineers on your team?
// A. Set clear, documented leveling expectations in advance so promotion isn't a surprise, gather evidence of sustained impact (not a single project), and advocate concretely in calibration with specific examples rather than vague praise.
// Q. 28. How do you manage vendor/tool selection decisions (e.g., choosing a monitoring tool)?
// A. Define evaluation criteria upfront (cost, integration effort, team familiarity, vendor lock-in risk), run a short trial with real usage rather than just a sales demo, and involve the engineers who'll use it daily in the decision.
// Q. 29. How do you handle scope negotiation when a deadline is fixed but requirements grow?
// A. Make the tradeoff triangle explicit (scope/time/quality) to stakeholders, propose a phased delivery (MVP now, enhancements later) rather than silently cutting corners on quality, and get agreement on what's deferred in writing.
// Q. 30. How do you approach documentation culture on a fast-moving team?
// A. Make documentation a lightweight habit tied to the work itself (ADRs alongside PRs, READMEs updated as part of the change) rather than a separate after-the-fact task, since separate documentation efforts tend to go stale.
// Q. 31. How do you decide between Scrum, Kanban, or a hybrid for your team?
// A. Base it on the nature of the work — Scrum's cadence suits predictable feature work with clear sprint goals; Kanban suits continuous-flow work like support/maintenance/on-call; many teams benefit from a pragmatic hybrid rather than dogmatic adherence to either.
// Q. 32. How do you run effective sprint retrospectives that lead to real change?
// A. Focus on a small number of actionable improvements rather than a long unaddressed list, assign clear owners, and follow up on previous retro action items at the start of the next one to maintain accountability.
// Q. 33. How do you manage engineering budget/cloud cost awareness on your team?
// A. Make cost visible (dashboards tied to team/service ownership), include cost as a factor in architecture reviews, and periodically audit for waste (idle resources, oversized instances) rather than treating cost as purely a finance concern.
// Q. 34. How do you handle knowledge silos where only one person understands a critical system?
// A. Proactively pair that person with others on related work, require documentation as part of any critical-system change, and treat bus-factor risk as a real engineering risk to be tracked and mitigated, not just an inconvenience.
// Q. 35. How do you approach a major refactor/migration while shipping features in parallel?
// A. Break the migration into incremental, independently-shippable steps (strangler fig pattern) rather than a long-lived branch, run old and new in parallel behind a flag where possible, and communicate the ongoing cost/timeline transparently to stakeholders.
// Q. 36. How do you handle team morale during a stressful period (e.g., major outage, layoffs)?
// A. Communicate honestly and frequently even when there's uncertainty, protect focus time from unnecessary additional pressure, acknowledge the difficulty directly rather than pretending it's business as usual, and follow through on any commitments made.
// Q. 37. How do you approach succession planning for your own TL role?
// A. Deliberately delegate decision-making opportunities (not just tasks) to senior engineers, involve them in stakeholder conversations, and give honest feedback on what growth areas would prepare them for a lead role.
// Q. 38. How do you handle a situation where a team member takes credit for someone else's work?
// A. Address it directly and privately with the individual first, ensure the original contributor is properly recognized going forward (in team updates, performance reviews), and if it's a repeated pattern, treat it as a serious conduct conversation.
// Q. 39. How do you evaluate whether to build in-house vs buy a third-party solution?
// A. Weigh core-vs-context (is this our competitive differentiator or a commodity problem), total cost of ownership including long-term maintenance, and time-to-value — defaulting to buy for undifferentiated infrastructure unless there's a strong reason not to.
// Q. 40. How do you handle a request from leadership that conflicts with engineering best practices?
// A. Clearly explain the risk/tradeoff in business terms, propose a safer alternative that still meets their underlying goal if possible, and if leadership still decides to proceed after understanding the risk, document the decision and execute professionally.
// Q. 41. How do you approach interviewing for cultural/collaboration fit without introducing bias?
// A. Use structured behavioral questions tied to specific competencies (not vague 'culture fit'), have multiple interviewers score independently before discussing, and focus on how someone handles disagreement/feedback rather than surface-level personality match.
// Q. 42. How do you handle a cross-team dependency that's blocking your team's delivery?
// A. Escalate early rather than waiting until the deadline is at risk, quantify the impact clearly, and work directly with the other team's lead to find either a workaround or a jointly agreed re-prioritization.
// Q. 43. How do you balance innovation (new tech/patterns) against system stability?
// A. Contain experimentation to lower-risk areas or a clearly scoped pilot rather than betting the core system on something unproven, and require a track record of stability before wider adoption of any new pattern or technology.
// Q. 44. How do you handle a situation where your estimate to leadership turns out to be significantly wrong?
// A. Communicate the revised estimate and reasoning as soon as I know, rather than hoping to catch up silently, and use it as a learning opportunity to improve future estimation (e.g., accounting for unknown unknowns better).
// Q. 45. How do you approach performance review calibration for your reports?
// A. Ground ratings in specific documented examples of impact against expectations for their level, actively seek peer feedback beyond my own observation, and check my own biases by comparing similar-level engineers across the broader team, not just within mine.
// Q. 46. How do you handle security or compliance concerns raised late in a project?
// A. Treat them as blocking until assessed, not as a footnote — pull in security/compliance stakeholders immediately, and if the timeline must slip to address a real risk, communicate that clearly rather than shipping a known vulnerability.
// Q. 47. How do you foster a culture of code ownership without creating silos?
// A. Use clear primary ownership for accountability while requiring cross-team code review and documentation so knowledge isn't locked to one person, and rotate ownership periodically for critical shared systems.
// Q. 48. How do you approach negotiating a tight deadline you believe is unrealistic?
// A. Present a data-backed alternative (reduced scope, additional resources, or a revised date) rather than just saying no, making the tradeoffs concrete so stakeholders can make an informed decision rather than an uninformed one.
// Q. 49. What's your approach to continuous learning and staying current as a TL?
// A. Dedicate regular time to reading RFCs/design docs from strong engineering orgs, experimenting hands-on with new tools in low-stakes side projects, and learning from my own team's retrospectives and postmortems as much as external sources.
// Q. 50. How do you define and communicate 'success' for your team beyond just shipping features?
// A. Track a balanced set of indicators — delivery velocity, system reliability, code health, and team engagement/retention — and communicate all of them to stakeholders so 'success' isn't reduced to feature output alone.
//
// 7. Scenario-Based / Whiteboard Questions (50 Questions)
// Q. 1. Flutter list of 10,000 items is janky — debug it.
// A. Confirm ListView.builder is used (not eager build), profile build/raster time in DevTools, check for missing const and expensive work in build(), and
// consider itemExtent plus pagination so all 10,000 aren't in memory.
// Q. 2. A Go service's p99 latency spiked 5x after deploy — triage sequence?
// A. Correlate with deploy timeline on dashboards and roll back if confirmed; pull pprof CPU/heap profiles for new blocking calls or lock contention;
// check downstream dependency latency; validate fix under load in staging before re-deploy.
// Q. 3. Migrate a legacy REST API to gRPC in 2 weeks without breaking the client.
// A. Run both APIs in parallel behind a feature flag, generate the Dart gRPC client via protobuf, migrate low-risk read-only endpoints first while monitoring against the REST baseline, keep REST as fallback until gRPC proves stable.
// Q. 4. Users report the app freezes for 2-3 seconds when opening a specific screen.
// A. Check if a synchronous heavy computation or blocking I/O is happening in build()/initState() on the main isolate; move it to compute()/an isolate or
//make it async with a loading state.
// Q. 5. A Go goroutine leak is slowly growing memory in production — find and fix it.
// A. Pull a goroutine profile via pprof to see which function's goroutines are accumulating, trace back to a missing context cancellation, an unbuffered channel
// with no reader, or a forgotten WaitGroup.Done() call.
// Q. 6. Flutter app crashes only on certain Android devices, not on emulator.
// A. Likely a native/ABI-specific issue (missing .so for an architecture) or a low-memory device OOM; check crash reports (Crashlytics) filtered by device model,
// and test on Firebase Test Lab across a broader device matrix.
// Q. 7. Design (whiteboard) a rate limiter middleware for a Go API gateway.
// A. Token bucket per client key stored in Redis with an atomic Lua script for check-and-decrement to avoid race conditions across gateway instances,
// returning 429 with Retry-After when exhausted.
// Q. 8. A Flutter app's images take too long to load on slow networks — fix it.
// A. Use cached_network_image with appropriately sized cacheWidth/cacheHeight, serve responsive image variants from the backend/CDN based on device pixel ratio, and show low-res placeholders while the full image loads.
// Q. 9. Two Go goroutines deadlock — walk through diagnosing it.
// A. Use the goroutine dump (SIGQUIT or pprof) to see where each is blocked; a classic cause is two goroutines each holding a mutex the other needs, or an unbuffered channel send with no matching receive — resolve with consistent lock ordering or buffered/timeout channels.
// Q. 10. A Bloc/Cubit's state isn't updating the UI even though emit() is called.
// A. Likely a state class not implementing proper equality (Equatable/freezed) so BlocBuilder thinks the state is unchanged, or emitting a mutated same-reference object; ensure new immutable state instances are emitted.
// Q. 11. Design a whiteboard solution for exactly-once message processing in Go with Kafka.
// A. True exactly-once is hard; achieve effectively-once via idempotent consumers (dedupe by message key/ID in a processed-set with TTL) combined with Kafka's at-least-once delivery and manual offset commit after successful processing.
// Q. 12. App size grew significantly after adding a new feature — investigate.
// A. Use flutter build apk --analyze-size or --tree-shake-icons reporting to find the largest contributors (fonts, unused assets, a heavy new dependency),
// and check if a plugin pulled in unnecessary native libraries for unused platforms.
// Q. 13. A Go HTTP handler occasionally returns a 500 with 'too many open files'.
// A. Likely file descriptor/connection leak — check for unclosed response bodies (resp.Body.Close()), unbounded goroutine/connection creation, or an OS ulimit too low for the actual concurrent connection load.
// Q. 14. Whiteboard: design a Dart/Flutter solution for debouncing a search input.
// A. Use a Timer that's cancelled and restarted on each keystroke, only firing the actual search API call after a pause (e.g., 300ms) of no further input,
// cancelling any in-flight previous request to avoid race conditions on results.
// Q. 15. A production Go service's CPU usage is pinned at 100% — diagnose it.
// A. Pull a CPU profile via pprof to find the hot function; common causes are an infinite/tight loop from a bug, excessive JSON marshaling/unmarshaling,
// or regex compiled repeatedly inside a hot loop instead of once at package init.
// Q. 16. Flutter app's animation is janky only on lower-end Android devices.
// A. Check for excessive Opacity/ClipPath widgets forcing expensive compositing layers, reduce shader/blur usage, wrap the animating subtree in a
// RepaintBoundary, and profile raster time specifically on a representative low-end device.
// Q. 17. Whiteboard: design a Go worker pool that processes jobs with a max concurrency of 10.
// A. Create a buffered semaphore channel of size 10; each job goroutine acquires a slot before processing and releases via defer, bounding concurrent work regardless of how many jobs are submitted.
// Q. 18. A user reports data loss after force-closing the app mid-form-fill.
// A. Implement periodic local draft persistence (debounced auto-save to local storage) rather than only saving on explicit submit, so a killed process doesn't lose unsaved input.
// Q. 19. Design a solution for handling duplicate push notification tokens across devices.
// A. Store tokens keyed by user with device metadata, deduplicate on token value itself (a token can only belong to one active device registration), and prune stale tokens on delivery failure (unregistered token error from FCM/APNs).
// Q. 20. A Go service's database connection pool is exhausted under load — fix it.
// A. Check for queries missing a context timeout holding connections too long, verify MaxOpenConns is tuned appropriately for both app and DB-side limits, and check for a code path not calling rows.Close() after a query.
// Q. 21. Whiteboard: implement pagination for an infinite-scroll Flutter list backed by a Go API.
// A. Use cursor-based pagination (not offset, which degrades with large offsets) with the Go API returning a next_cursor, Flutter's ListView.builder loading the next page when scroll position nears the end, and a loading indicator with error/retry handling per page.
// Q. 22. A Flutter app shows stale data after backend updates — investigate caching.
// A. Check if HTTP responses are being cached without honoring Cache-Control/ETag headers, or if a local cache layer isn't being invalidated on mutation; ensure writes invalidate or update the relevant cache entries.
// Q. 23. Design a Go solution to safely update a shared in-memory cache from multiple goroutines.
// A. Use sync.RWMutex for read-heavy access patterns (allowing concurrent reads, exclusive writes) or sync.Map for simpler concurrent key-value needs, choosing based on read/write ratio and access pattern complexity.
// Q. 24. A specific screen causes a memory spike that isn't released after navigating away.
// A. Check for undisposed AnimationControllers, StreamSubscriptions, or listeners in dispose(), and use DevTools' memory snapshot diff before/after navigating away to confirm what's being retained.
// Q. 25. Whiteboard: design retry logic for a flaky third-party payment API call in Go.
// A. Wrap the call with exponential backoff plus jitter, a max retry count, and only retry on clearly transient errors (timeouts, 5xx) — never blindly retry a payment charge without an idempotency key to avoid double-charging.
// Q. 26. A large form screen in Flutter rebuilds entirely on every keystroke — optimize it.
// A. Split the form into smaller widgets each listening to only their relevant field's state (via Provider/Bloc selectors), so a keystroke in one field doesn't rebuild unrelated sibling widgets.
// Q. 27. Design a Go solution for a webhook receiver that must not lose events under load.
// A. Accept and immediately acknowledge the webhook (200 OK) after durably queuing the raw payload (DB or message queue), then process asynchronously with retry — decoupling ingestion from processing so a slow downstream doesn't cause dropped/timed-out webhooks.
// Q. 28. App works fine in debug but crashes in release mode only — debug it.
// A. Common causes: reliance on reflection stripped by tree-shaking/R8 in release, uninitialized late variables only exercised on a code path skipped in debug, or a native library present in debug but excluded in release build config.
// Q. 29. Whiteboard: implement a simple LRU cache in Go.
// A. Combine a doubly linked list (tracking recency order) with a map (O(1) key lookup to list node); on access, move the node to the front; on capacity overflow, evict from the back — both get and put run in O(1).
// Q. 30. A Flutter app's Bloc test is flaky, passing/failing inconsistently.
// A. Likely an unawaited async operation inside the Bloc causing test assertions to run before state emission completes; use bloc_test's proper 'act'/'wait' handling and ensure all Futures/Streams are properly awaited in test setup.
// Q. 31. Design a Go rate limiter that must work correctly across multiple service instances.
// A. Use a centralized store (Redis) with an atomic script (Lua) for the token bucket check-and-decrement, since per-instance in-memory limiters would allow N times the intended limit across N instances.
// Q. 32. A user reports the app double-submits a form occasionally.
// A. Disable the submit button immediately on tap (before the async call completes) and use an idempotency key on the backend as defense-in-depth against network-retry-induced duplicate submissions.
// Q. 33. Whiteboard: design a Go function to process a large CSV file without loading it all into memory.
// A. Stream the file using bufio.Scanner or csv.Reader row-by-row rather than reading the whole file into a []byte/string first, processing and optionally batching writes incrementally to bound memory usage regardless of file size.
// Q. 34. A Flutter app's Provider-based state update causes the entire app to rebuild.
// A. Likely a single large ChangeNotifier at the app root being watched broadly; split into smaller, scoped providers or use Selector/context.select to subscribe only to the specific fields each widget actually needs.
// Q. 35. Design a solution for handling clock skew in a distributed Go system needing event ordering.
// A. Avoid relying on wall-clock timestamps alone for ordering across nodes; use logical clocks (Lamport timestamps) or a centralized sequence generator, or tolerate skew with a bounded uncertainty window (like Spanner's TrueTime approach) if precision matters.
// Q. 36. An Android build succeeds locally but fails in CI with a Gradle error.
// A. Check for CI using a different Gradle/JDK version than local, missing environment secrets (keystore, API keys) available locally but not in CI, or a stale Gradle cache in CI causing a dependency resolution mismatch.
// Q. 37. Whiteboard: design a Go function to deduplicate events within a sliding time window.
// A. Maintain a map of event key to last-seen timestamp with a background cleanup goroutine (or lazy cleanup on access) removing entries older than the window; reject/ignore an event if its key was seen within the window.
// Q. 38. A Flutter app's navigation stack gets corrupted after a deep link while already inside the app.
// A. Ensure deep link handling checks current navigation state before pushing (avoid pushing on top of an already-matching route), and use a router (go_router) with proper redirect/guard logic rather than ad-hoc Navigator.push calls scattered across the app.
// Q. 39. Design a Go solution for a leaderboard that must handle millions of score updates.
// A. Use Redis Sorted Sets (ZADD/ZRANGE) for O(log N) score updates and rank queries rather than a relational DB doing ORDER BY over millions of rows on every request.
// Q. 40. A specific Flutter widget test fails only in CI, not locally.
// A. Likely a font-rendering or golden-image environment mismatch, a timing-dependent pumpAndSettle timeout under CI's slower/shared resources, or a locale/timezone difference between local and CI environments affecting date-dependent assertions.
// Q. 41. Whiteboard: implement a Go function for graceful degradation when a cache is down.
// A. Wrap cache reads with a short timeout and fall back to the source of truth (DB) on cache error/timeout rather than failing the whole request, while logging/alerting on the cache outage separately.
// Q. 42. An app's crash rate spiked after a third-party SDK update — how do you respond?
// A. Check crash reports for a clear correlation with the SDK version, consider an emergency rollback/pin to the previous SDK version via a hotfix release, and report the issue upstream while validating a fix in staging before re-adopting the update.
// Q. 43. Design a Go solution to safely rotate an API key/secret with zero downtime.
// A. Support validating against both old and new keys simultaneously during a transition window, update all consumers to the new key, then remove the old key's validity only after confirming no traffic still uses it.
// Q. 44. A Flutter ListView with images causes scroll jank only after scrolling for a while.
// A. Likely unbounded image cache growth; configure PaintingBinding.instance.imageCache size limits, ensure cached_network_image is evicting appropriately, and check for retained large decoded images not being garbage collected due to lingering references.
// Q. 45. Whiteboard: design a Go health check that reflects true service readiness, not just process liveness.
// A. The /readyz check should verify actual dependencies (DB ping, cache reachability, downstream service health) with a short timeout, returning not-ready if a critical dependency is down, distinct from /healthz which just confirms the process is running.
// Q. 46. A background sync feature drains battery excessively on iOS.
// A. Reduce sync frequency and batch operations, respect BGTaskScheduler's system-determined timing rather than forcing frequent wakes, and avoid keeping network connections open longer than necessary during background execution.
// Q. 47. Design a Go solution for safely processing messages that may arrive out of order.
// A. Include a sequence number or timestamp in each message, buffer/reorder within a bounded window if strict ordering matters, or design the consumer to be order-independent (idempotent upserts keyed by entity ID with a version check) when possible.
// Q. 48. A Flutter app's state is lost when switching between tabs in a bottom navigation bar.
// A. Use IndexedStack (keeping all tab widget trees alive, just hidden) instead of conditionally rebuilding the active tab's widget from scratch, or persist tab-specific state in a state management solution that outlives the widget rebuild.
// Q. 49. Whiteboard: how would you design chaos testing for a Go microservices system?
// A. Deliberately inject failures (kill a pod, add network latency, saturate CPU) in a controlled staging/prod-like environment using a tool like Chaos Mesh, verifying the system degrades gracefully and alerts fire as expected rather than cascading into a full outage.
// Q. 50. A Flutter app intermittently fails to receive push notifications on iOS only.
// A. Check APNs certificate/key expiry, verify the app isn't force-quit (which suppresses silent pushes on iOS), confirm the notification payload is
// well-formed for the aps dictionary, and check for device token refresh not being re-synced to the backend.

//
// # Flutter Scenario-Based / Whiteboard Interview Questions (50 Q&A)
//
// A curated set of experience-level, scenario-driven Flutter questions with detailed answers — covering state management, performance, architecture, async, navigation, testing, native integration, memory, and layout.
//
// ---
//
// ## 1. State Management
//
// ### Q1. You have a counter that needs to update a `Text` widget when a button is pressed, but the button is in a different widget subtree, 5 levels deep.
// How do you architect this without passing callbacks through every level?
// **Answer:**
// Use a state-management approach that avoids "prop drilling":
// - **Provider / Riverpod**: Wrap the shared state in a `ChangeNotifierProvider` (or a Riverpod `StateNotifierProvider`) at a common ancestor.
// Deep child widgets call `context.watch<CounterModel>()` (Provider) or `ref.watch(counterProvider)` (Riverpod) to read/rebuild, and `
// context.read<CounterModel>().increment()` to mutate without rebuilding.
// - **InheritedWidget** (the primitive underneath Provider): create a custom `InheritedWidget` exposing the counter and `updateShouldNotify`,
// then use `dependOnInheritedWidgetOfExactType` in descendants.
// - **Bloc/Cubit**: Emit a new state from a `CounterCubit`; wrap the tree in `BlocProvider` and consume via `BlocBuilder`.
//
// Key point: avoid passing the increment function as a constructor parameter through every intermediate widget — that couples unrelated widgets and makes refactoring painful.
//
// ---
//
// ### Q2. In a large e-commerce app, you notice that adding one item to the cart rebuilds the entire product listing screen, causing jank. How do you fix it?
// **Answer:**
// The root cause is usually a state object that's too coarse-grained, causing every listener to rebuild.
// - Split state: separate `CartState` from `ProductListState` so cart changes don't invalidate the product list's `Consumer`/`BlocBuilder`.
// - Use `Selector` (Provider) or `context.select((CartModel c) => c.itemCount)` to only rebuild widgets depending on the specific field that changed,
// rather than the whole model.
// - With Bloc, use `BlocBuilder`'s `buildWhen` to filter unnecessary rebuilds.
// - Push the "add to cart" icon/badge into its own small widget so only that widget rebuilds, not the parent `ListView`.
// - Verify with Flutter DevTools' "Track widget rebuilds" to confirm the fix.
//
// ---
//
// ### Q3. Your app needs to share a single piece of state (user authentication) across multiple independent feature modules that don't know about each other.
// How would you design this?
// **Answer:**
// Treat auth state as a **global, singleton-scoped service** rather than screen-local state:
// - Define an `AuthRepository`/`AuthBloc` at the app root (above `MaterialApp`), injected via `MultiProvider` or a service locator (e.g., `get_it`).
// - Each feature module depends only on an abstract interface (`AuthState` stream or `ValueListenable<User?>`), not on the concrete implementation —
// this keeps modules decoupled and testable.
// - Use a `StreamProvider` or `ValueListenableBuilder` wherever a module needs to react to login/logout, e.g., redirecting via `GoRouter`'s `redirect`
// callback based on auth state.
// - Avoid `InheritedWidget` alone for this because it requires deep tree access to the same context; a service locator or global provider avoids
// re-implementing plumbing per module.
//
// ---
//
// ### Q4. You're asked whether to use `setState`, Provider, or Bloc for a new small-to-medium app. How do you decide, and what trade-offs would you explain to your team?
// **Answer:**
// - **`setState`**: best for local, ephemeral UI state (checkbox toggled, animation controller, text field focus) confined to a single widget. Zero boilerplate but doesn't scale across widgets.
// - **Provider/Riverpod**: good middle ground — simple DI + reactive rebuilds, less ceremony than Bloc, good for small-to-medium apps or teams new to reactive patterns. Riverpod additionally gives compile-time safety (no `BuildContext` needed) and easy testing.
// - **Bloc/Cubit**: enforces a strict unidirectional data flow (event → state), which pays off in larger teams/apps needing strong separation of business logic from UI, better testability of complex flows, and clear audit trails (useful for regulated domains). Cost: more boilerplate, steeper learning curve.
//
// Decision framework: state locality (widget vs. app-wide), team size/experience, testability requirements, and how complex the business logic is. For a small app with low complexity, `setState` + Provider is often enough; for large apps with complex workflows, Bloc scales better.
//
// ---
//
// ### Q5. A form has 10 fields, and validating one field's dependent logic (e.g., "confirm password" must match "password") causes the whole form to
// rebuild on every keystroke. How do you optimize this?
// **Answer:**
// - Use individual `TextEditingController`s per field instead of one big state object holding all field values — this way each field's `TextField` only
// rebuilds itself.
// - For cross-field validation (confirm password), don't trigger a full-form `setState`; instead use a `ValueNotifier<bool>` for "passwords match"
// and wrap only the error-text widget in a `ValueListenableBuilder`.
// - Consider `flutter_form_builder` or `reactive_forms`, which manage field-level rebuilds automatically.
// - Debounce expensive validation (e.g., async username-availability checks) using a `Timer` or `rxdart`'s `debounceTime` to avoid firing a network call per keystroke.
//
// ---
//
// ## 2. Widget Lifecycle & Rebuild
//
// ### Q6. You override `initState` to start a network call and set the result via `setState`, but users report a red-screen error when navigating away quickly. Why, and how do you fix it?
// **Answer:**
// The error is `setState() called after dispose()` — the widget was removed from the tree before the async call completed, but the callback still tries to call `setState`.
// **Fix:**
// ```dart
// bool _disposed = false;
//
// @override
// void dispose() {
// _disposed = true;
// super.dispose();
// }
//
// Future<void> _fetchData() async {
// final result = await api.getData();
// if (!mounted) return; // check mounted flag
// setState(() => _data = result);
// }
// ```
// Always guard with `if (mounted)` before calling `setState` after an `await`. For more robust cancellation, use a `CancelToken` (Dio) or cancel the
// underlying `Future`/`StreamSubscription` in `dispose()`.
//
// ---
//
// ### Q7. Explain what happens, step by step, when a `StatefulWidget`'s parent rebuilds and passes a new value to it. Walk through the lifecycle
// methods invoked.
// **Answer:**
// 1. Parent rebuilds and creates a new widget instance (immutable) with new constructor parameters.
// 2. Flutter's element tree diffs by `runtimeType` and `key`; if they match the existing element, it **reuses** the same `State` object instead of recreating it.
// 3. `didUpdateWidget(oldWidget)` is called on the existing `State`, giving you access to both old and new widget configuration — this is where you'd cancel/restart listeners tied to a changed parameter.
// 4. `build()` is called again to produce the new widget subtree.
// 5. If the `runtimeType` or `key` doesn't match (e.g., widget type changed), Flutter instead calls `dispose()` on the old State and `initState()` on a brand-new State object.
//
// Interview tip: mention that `initState` runs only once per State object's lifetime, while `build` can run many times — a common source of bugs is doing one-time setup in `build` instead of `initState`.
//
// ---
//
// ### Q8. A `ListView` of 1,000 items each containing a network image causes scroll jank and excessive image re-fetching when scrolling up and down.
// Diagnose and fix.
// **Answer:**
// Likely causes:
// - Not using `ListView.builder` (building all 1,000 widgets eagerly instead of lazily) — switch to `.builder` so only visible + cache-extent items are built.
// - Missing `key`s on list items causing Flutter to lose track of element identity when items are inserted/reordered, leading to state loss and re-fetching.
// - Images not cached: use `cached_network_image` package (`CachedNetworkImage`) instead of raw `Image.network`, which re-downloads on every rebuild if not cached in memory/disk.
// - Set `cacheExtent` appropriately and consider `const` constructors for static parts of each tile to prevent unnecessary rebuilds.
// - Use `RepaintBoundary` around each list tile if items contain complex custom painting, isolating repaints.
//
// ---
//
// ### Q9. Your team debates whether to use `const` constructors aggressively. Explain the performance impact with a concrete example.
// **Answer:**
// A `const` widget is created once at compile time and reused — Flutter's `Element` diffing sees the identical widget instance (`==` by identity)
// and **skips rebuilding that subtree entirely**, even if the parent rebuilds.
//
// Example:
// ```dart
// class MyScreen extends StatefulWidget {
// @override
// State<MyScreen> createState() => _MyScreenState();
// }
//
// class _MyScreenState extends State<MyScreen> {
// int counter = 0;
// @override
// Widget build(BuildContext context) {
// return Column(
// children: [
// Text('$counter'),              // rebuilds every setState
// const ExpensiveStaticWidget(), // never rebuilds — same instance
// ElevatedButton(
// onPressed: () => setState(() => counter++),
// child: const Text('Increment'),
// ),
// ],
// );
// }
// }
// ```
// Here, `ExpensiveStaticWidget` (marked `const`) is skipped entirely on every `setState`, saving a full `build`/layout/paint pass for that subtree. Use the `prefer_const_constructors` lint to enforce this team-wide.
//
// ---
//
// ### Q10. You have a `TabBarView` with 5 tabs, each showing a heavy widget tree (e.g., a chart). Users complain that switching tabs is slow the first time but fast afterward, and also that state (like scroll position) resets each time. How do you address both?
// **Answer:**
// - By default `TabBarView` lazily builds tabs (only builds when first visible), which explains the first-visit slowness; that's `AutomaticKeepAliveClientMixin` territory.
// - To preserve each tab's state (scroll position, form input) across switches, mix `AutomaticKeepAliveClientMixin` into each tab's State and override `wantKeepAlive => true`, then call `super.build(context)` in `build()`.
// - To reduce the *first-load* jank, avoid doing heavy synchronous chart computation in `build()`; precompute chart data in a background isolate or cache it, and show a lightweight placeholder/skeleton while loading.
// - Alternatively, use `PageStorageKey` on scrollable widgets to persist scroll offsets even without full keep-alive.
//
// ---
//
// ## 3. Performance Optimization
//
// ### Q11. Your app's animations stutter (dropped frames) only on lower-end Android devices. Walk through your debugging process.
// **Answer:**
// 1. Run in **profile mode** (`flutter run --profile`) — debug mode has extra overhead and gives misleading performance numbers.
// 2. Open **DevTools Performance/Timeline view** to see frame times; identify whether the bottleneck is in the **UI thread** (build/layout/paint — "Frames" chart shows raw widget work) or the **Raster thread** (GPU/shader compilation — shown as separate raster frame times).
// 3. If raster-bound: check for expensive `Opacity`/`ClipRRect`/`BackdropFilter` widgets, or **shader compilation jank** on first use of certain effects — mitigate using `flutter build`'s SkSL warm-up (`--bundle-sksl-path`) to precompile shaders.
// 4. If UI-thread-bound: check for expensive `build()` methods, missing `const`, unnecessary rebuilds (use "Track Widget Rebuilds"), or heavy work (JSON parsing, image decoding) done synchronously on the main isolate.
// 5. For low-end devices specifically, also check image resolution — decode/display images at their actual display size using `cacheWidth`/`cacheHeight` rather than full resolution.
//
// ---
//
// ### Q12. A screen loads a 5MB JSON response and parses it to populate a list. The UI freezes for ~1 second during this. How do you fix it?
// **Answer:**
// JSON decoding is synchronous CPU work blocking the single UI isolate. Move it off the main isolate:
// ```dart
// Future<List<Item>> parseInBackground(String jsonStr) {
// return compute(_parseItems, jsonStr);
// }
//
// List<Item> _parseItems(String jsonStr) {
// final data = jsonDecode(jsonStr) as List;
// return data.map((e) => Item.fromJson(e)).toList();
// }
// ```
// `compute()` spins up (or reuses) a separate isolate, so the UI isolate stays responsive. For repeated/streaming heavy work, consider a long-lived `Isolate`
// with `Isolate.spawn` and a `ReceivePort`/`SendPort` pair instead of paying isolate-spawn cost each time. Also consider server-side pagination to avoid
// needing to parse 5MB at once.
//
// ---
//
// ### Q13. You suspect a memory leak because the app's memory usage climbs steadily as the user navigates between screens. How do you confirm and locate it?
// **Answer:**
// 1. Use **DevTools Memory tab**: take a heap snapshot, navigate back and forth a few times, take another snapshot, and diff — look for object counts that keep growing (e.g., instances of a disposed screen's State class still alive).
// 2. Common causes: forgetting to cancel `StreamSubscription`s, not disposing `AnimationController`/`TextEditingController`/`ScrollController`, or a singleton/global list holding references to disposed widgets/callbacks.
// 3. Check for **listeners not removed**: e.g., registering `WidgetsBinding.instance.addObserver(this)` in `initState` without `removeObserver` in `dispose`.
// 4. Use the "Leak Tracker" in `leak_tracker` package (integrated into Flutter test framework) to automatically detect undisposed disposables in tests.
// 5. Fix by ensuring every controller/subscription/observer registered in `initState` has a matching cleanup in `dispose()`.
//
// ---
//
// ### Q14. Your app displays a grid of 200 high-resolution photos. Scrolling causes the app to briefly freeze and memory spikes. What's your optimization strategy?
// **Answer:**
// - Use `GridView.builder` (lazy building) rather than eagerly building all 200 tiles.
// - Downscale images to the actual rendered size using `Image.network(url, cacheWidth: 300)` (device-pixel-aware) so Flutter's image cache doesn't hold full-resolution decoded bitmaps in memory.
// - Use `cached_network_image` with disk caching to avoid re-downloading, and configure `PaintingBinding.instance.imageCache.maximumSize` if the default cache is too large/small for your use case.
// - Consider `flutter_staggered_grid_view` if the grid isn't uniform, and add `RepaintBoundary` per tile so scrolling one doesn't force repainting others.
//
// ---
//
// ### Q15. Product wants a "search-as-you-type" feature hitting a remote API. How do you implement it so it doesn't spam the backend on every keystroke, and old responses don't overwrite newer ones?
// **Answer:**
// - **Debounce** input using a `Timer` (cancel and restart on each keystroke, fire after e.g. 300ms of inactivity) or `rxdart`'s `debounceTime`.
// - **Avoid race conditions** ("out-of-order responses"): tag each request with an incrementing request ID or use `flag`-based cancellation — only apply the response if it matches the latest request ID; discard stale responses.
// ```dart
// int _requestId = 0;
// Future<void> _search(String query) async {
// final currentId = ++_requestId;
// final results = await api.search(query);
// if (currentId != _requestId) return; // stale response, ignore
// setState(() => _results = results);
// }
// ```
// - Alternatively use `rxdart`'s `switchMap`, which automatically cancels the previous inner stream/future when a new value arrives — a natural fit for search-as-you-type.
//
// ---
//
// ## 4. Architecture & Design Patterns
//
// ### Q16. Your team is starting a new large Flutter app expected to scale to 50+ screens and multiple developers. How would you structure the project (folder architecture)?
// **Answer:**
// Use a **feature-first, layered architecture**, e.g., Clean Architecture adapted for Flutter:
// ```
// lib/
// core/                 # shared utilities, theming, constants, network client
// features/
// auth/
// data/             # repositories, data sources, DTOs
// domain/           # entities, use cases, repository interfaces
// presentation/     # widgets, blocs/providers, screens
// cart/
// data/ domain/ presentation/
// main.dart
// ```
// Rationale:
// - **Feature-first** (not layer-first at the top level) keeps related code together, so multiple devs can work on different features with minimal merge conflicts.
// - **Domain layer** (pure Dart, no Flutter imports) keeps business logic testable/independent of UI framework changes.
// - Dependency direction: `presentation → domain ← data` (domain defines interfaces, data implements them) — this is the Dependency Inversion Principle, enabling easy mocking in tests.
// - Use a DI tool (`get_it` + `injectable`, or Riverpod's providers) to wire concrete implementations without hardcoding dependencies.
//
// ---
//
// ### Q17. How would you design the app so that swapping the local database from Hive to SQLite (via drift) requires touching minimal code?
// **Answer:**
// Apply the **Repository Pattern**: define an abstract interface in the domain layer, e.g.
// ```dart
// abstract class TodoRepository {
// Future<List<Todo>> getAll();
// Future<void> add(Todo todo);
// }
// ```
// The rest of the app (blocs/providers/UI) depends only on `TodoRepository`, never on `Hive` or `drift` directly. Two concrete implementations (`HiveTodoRepository`, `DriftTodoRepository`) satisfy the same interface. Swapping databases means writing one new class and changing a single line in your DI setup (e.g., `getIt.registerSingleton<TodoRepository>(DriftTodoRepository())`) — no changes needed in UI or business logic layers. This also makes unit testing trivial via a `FakeTodoRepository` or `mocktail` mock.
//
// ---
//
// ### Q18. Explain how you'd implement dependency injection in Flutter without a framework, and then how a package like `get_it` improves on it.
// **Answer:**
// **Manual DI**: pass dependencies through constructors (constructor injection), possibly using an `InheritedWidget` to expose them app-wide. Works fine for small apps but becomes verbose as the dependency graph grows (constructor parameter lists balloon; every widget needing a repository must be threaded through the tree).
//
// **`get_it`** is a service locator: a global-ish registry where you register singletons/factories once (typically in a `setupLocator()` called from `main()`):
// ```dart
// final getIt = GetIt.instance;
// void setupLocator() {
// getIt.registerLazySingleton<ApiClient>(() => ApiClient());
// getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt<ApiClient>()));
// }
// ```
// Any widget can then do `getIt<AuthBloc>()` without needing `BuildContext` or threading through constructors. Trade-off: it trades some compile-time safety and explicitness for convenience — over-using it can hide dependencies and make testing/tracing harder if not disciplined (e.g., always registering interfaces, not concretes, and resetting the locator between tests).
//
// ---
//
// ### Q19. A junior developer put all API calls directly inside `build()` methods of widgets. What's wrong with this, and how would you refactor?
// **Answer:**
// Problems:
// - `build()` can be called many times (every rebuild, e.g., on `setState`, parent rebuild, or orientation change) — calling an API inside it triggers **duplicate network requests** on every rebuild.
// - Mixes UI concerns with data-fetching/business logic, violating separation of concerns, making the widget hard to test and reuse.
// - No caching/loading/error state management — leads to flicker or crashes on error.
//
// **Refactor**: move the API call into `initState()` (or better, a Bloc/Cubit/Provider's method triggered once), store the `Future` in a State field, and use `FutureBuilder` referencing that stored future (not re-calling the API in `build`):
// ```dart
// late final Future<List<Item>> _future = repository.fetchItems(); // computed once
//
// @override
// Widget build(BuildContext context) {
// return FutureBuilder<List<Item>>(
// future: _future,
// builder: (context, snapshot) { ... },
// );
// }
// ```
// For app-wide reuse, delegate the fetch entirely to a Bloc/Provider so the UI layer only reacts to state changes.
//
// ---
//
// ### Q20. How would you implement a feature-flagging system so that a new checkout flow can be toggled on/off remotely without an app release?
// **Answer:**
// - Integrate a remote config service (Firebase Remote Config, LaunchDarkly, or a custom backend endpoint) fetched at app startup and cached locally (e.g., in `SharedPreferences`) so the app has a flag value available even offline.
// - Wrap flag access behind an abstraction, e.g. `FeatureFlags.isNewCheckoutEnabled`, rather than scattering `remoteConfig.getBool(...)` calls throughout the UI — this centralizes flag logic and eases testing (inject a fake `FeatureFlags` in tests).
// - In the UI, branch at the **navigation/composition level** (e.g., choose which route or widget to build) rather than sprinkling `if` checks deep inside shared widgets, to keep the two flows cleanly separable and easy to remove after full rollout.
// - Consider a minimum refresh interval and a "kill switch" default (fail-safe to old flow) if the remote config fetch fails.
//
// ---
//
// ## 5. Async Programming & Isolates
//
// ### Q21. Explain the difference between `Future`, `Stream`, and `Isolate` in Flutter/Dart, with an example of when you'd use each.
// **Answer:**
// - **`Future`**: represents a single value available at some point in the future (e.g., one HTTP GET request result). Used for one-off async operations.
// - **`Stream`**: represents a sequence of async values over time (e.g., real-time chat messages via WebSocket, or a `Firestore` document snapshot listener). Used with `StreamBuilder` or `.listen()`.
// - **`Isolate`**: a separate memory space + event loop for **true parallelism** (Dart is single-threaded per isolate; `Future`/`Stream` are concurrency, not parallelism — they still run on one thread via the event loop). Used for CPU-intensive work (image processing, large JSON parsing, encryption) that would otherwise block the UI thread. Communication between isolates happens via message-passing (`SendPort`/`ReceivePort`), not shared memory.
//
// Example decision: fetching a user profile → `Future`. Listening to live order status updates → `Stream`. Compressing a 20MB video before upload → `Isolate`.
//
// ---
//
// ### Q22. You need to make three independent API calls and combine their results before rendering a dashboard. How do you do this efficiently, and what if one of them fails?
// **Answer:**
// Use `Future.wait` to run them concurrently rather than sequentially with `await` one-by-one:
// ```dart
// try {
// final results = await Future.wait([
// api.getUser(),
// api.getOrders(),
// api.getRecommendations(),
// ], eagerError: false);
// } catch (e) {
// // handle failure
// }
// ```
// - Running them concurrently (all three fired before awaiting) is much faster than sequential awaits — total time ≈ slowest call, not the sum.
// - `eagerError: false` (default is `true`... actually default is `false`? — clarify) lets you decide whether one failure should immediately reject the whole `Future.wait` or wait for all to complete. For a dashboard, often better to catch each call's errors individually (e.g., wrap each in its own try/catch or use `.catchError` per future) so one failing widget (e.g., "Recommendations unavailable") doesn't block the rest of the dashboard from rendering.
//
// ---
//
// ### Q23. A background isolate is used to decode a large image, but you're getting an error that the image (a native/platform object) can't be passed back to the main isolate. Why, and how do you fix it?
// **Answer:**
// Isolates don't share memory — only messages that are **transferable** (primitives, `Uint8List`, `TypedData`, or explicitly `TransferableTypedData`) can cross the isolate boundary. Platform-specific objects like `ui.Image` (which wraps native GPU texture handles) generally **cannot** be sent across isolates because they're tied to the isolate/engine that created them.
//
// **Fix:** do the heavy decoding (e.g., raw byte manipulation, resizing pixel buffers) in the background isolate using pure data types (`Uint8List`), and only construct the final `ui.Image` (via `instantiateImageCodec` / `decodeImageFromList`) back on the **main isolate** after receiving the processed bytes.
//
// ---
//
// ### Q24. Your app makes a network call, and if the user leaves the screen before it completes, you want to cancel the request rather than let it complete uselessly. How do you implement cancellation in Dart, which doesn't have first-class Future cancellation?
// **Answer:**
// Dart `Future`s can't be cancelled directly once started, so use one of these patterns:
// 1. **CancelToken (Dio)**: Dio's HTTP client supports a `CancelToken`; call `.cancel()` in `dispose()`, and Dio aborts the underlying HTTP request.
// ```dart
// final cancelToken = CancelToken();
// dio.get(url, cancelToken: cancelToken);
// // in dispose():
// cancelToken.cancel();
// ```
// 2. **Guard with `mounted`/a flag**: even if the network call itself keeps running, ignore its result if the screen is gone (`if (!mounted) return;`) — doesn't save bandwidth but avoids crashes/wasted `setState`.
// 3. **StreamSubscription.cancel()**: if using a `Stream`-based API client, cancelling the subscription in `dispose()` stops further events from being delivered.
// 4. For `compute()`/isolate-based work, there's no built-in cancel — instead check a cancellation flag periodically inside the isolate's loop, or kill the isolate via `Isolate.kill()` if you spawned it manually.
//
// ---
//
// ### Q25. Explain what happens under the hood when you call `await` inside a Flutter widget's build-triggered callback (e.g., a button's `onPressed`). Does it block the UI?
// **Answer:**
// No — `await` doesn't block the UI thread. Dart's single-threaded event loop uses **microtasks and event queues**: when you `await` a `Future`, the current function pauses and control returns to the event loop, which continues processing other events (like frame rendering, gesture callbacks) while the awaited operation (I/O, timer) completes elsewhere (e.g., in the OS/engine). Once the future resolves, its continuation is scheduled as a microtask/event and resumes execution.
//
// This is why long synchronous CPU-bound work (a tight loop, JSON parsing) *does* block the UI — there's no `await` point to yield to the event loop — whereas I/O-bound work (network calls, file reads) doesn't block, since it's inherently async at the OS level and the isolate is genuinely idle/yielding while waiting.
//
// ---
//
// ## 6. Navigation & Routing
//
// ### Q26. Your app has a deep-linking requirement: opening `myapp://product/123` should navigate directly to a product detail screen, even from a cold start. How do you implement this?
// **Answer:**
// - Use `go_router` (recommended for declarative deep-link support) configured with a route like `/product/:id`, and set it as `MaterialApp.router`'s `routerConfig`.
// - Configure platform-level intent filters (Android `AndroidManifest.xml` `<intent-filter>` with the custom scheme, or Universal/App Links) and iOS `Info.plist`/Associated Domains so the OS routes the URL into your app.
// - On cold start, `go_router` reads the initial route from the platform and builds directly to `/product/123` without first showing the home screen (avoiding a "flash" of the home screen then push).
// - Handle the "product not found"/invalid ID case gracefully with an error route (`errorBuilder`) rather than crashing.
//
// ---
//
// ### Q27. Explain the difference between `Navigator.push`, `pushReplacement`, and `pushAndRemoveUntil`, and give a real scenario for each.
// **Answer:**
// - **`push`**: adds a new route on top of the stack; back button returns to the previous screen. Scenario: opening a product detail page from a list — user should be able to go back to the list.
// - **`pushReplacement`**: replaces the current route with a new one; the replaced route is disposed and not in the back-stack. Scenario: after a splash screen finishes loading, replace it with the home screen — the user shouldn't be able to navigate "back" to the splash.
// - **`pushAndRemoveUntil`**: pushes a new route and removes all routes below it matching a predicate. Scenario: after a successful login, push the home screen and clear the entire auth stack (login, OTP, forgot-password screens) so pressing back from home exits the app instead of returning to login: `Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Home()), (route) => false)`.
//
// ---
//
// ### Q28. Two tabs in a `BottomNavigationBar` each need their own independent navigation stack (so switching tabs preserves each tab's back-stack), while a shared bottom nav bar stays visible. How do you architect this?
// **Answer:**
// Use **nested Navigators**, one per tab, wrapped in an `IndexedStack` (to preserve state when switching) so each tab keeps its own stack:
// ```dart
// IndexedStack(
// index: _currentTab,
// children: [
// Navigator(key: _tab1NavKey, onGenerateRoute: ...),
// Navigator(key: _tab2NavKey, onGenerateRoute: ...),
// ],
// )
// ```
// With `go_router`, this is built in via `StatefulShellRoute.indexedStack`, which manages per-branch navigation stacks automatically while keeping a persistent `Scaffold`/`BottomNavigationBar` shell. Also handle the Android back button at the root: pressing back should first pop the active tab's stack, and only exit the app (or go to the first tab) once that tab's stack is empty — override `PopScope`/`WillPopScope` to check the current tab Navigator's `canPop()`.
//
// ---
//
// ### Q29. A user reports that after logging out, pressing the device back button on the login screen takes them back into the authenticated part of the app. How do you prevent this?
// **Answer:**
// This happens because the old authenticated routes are still sitting in the navigation stack beneath the login screen — logging out only pushed a new route on top instead of clearing history.
//
// **Fix:** on logout, use `Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false)` to clear the entire back-stack. With `go_router`, use `context.go('/login')` (not `context.push`) — `go` replaces the whole stack based on the route configuration rather than pushing on top, and pair it with a `redirect` in the router config that checks auth state on every navigation attempt, so even a stale deep link or back-navigation gets redirected to `/login` if the user is unauthenticated.
//
// ---
//
// ### Q30. How would you implement and test a scenario where navigating to Screen B from Screen A should return a result (e.g., a selected item) back to Screen A?
// **Answer:**
// Use `Navigator.push`'s returned `Future` combined with `Navigator.pop(context, result)`:
// ```dart
// // Screen A
// final selected = await Navigator.push<Item>(
// context,
// MaterialPageRoute(builder: (_) => ScreenB()),
// );
// if (selected != null) setState(() => _selectedItem = selected);
//
// // Screen B, on item tap:
// Navigator.pop(context, tappedItem);
// ```
// For testing: use `flutter_test`'s widget testing with a `NavigatorObserver` mock to verify `push`/`pop` calls happen with correct arguments, or use integration tests (`integration_test` package) to simulate the tap on Screen B and assert Screen A's state updates to reflect the returned item. With `go_router`, the equivalent is `await context.push<Item>('/screenB')`.
//
// ---
//
// ## 7. Testing
//
// ### Q31. Your team has zero tests on a 2-year-old Flutter app. How would you prioritize introducing testing?
// **Answer:**
// Prioritize by **risk and ROI**:
// 1. **Unit tests** for critical, pure business logic first (pricing calculations, validation rules, data transformations) — cheapest to write,
// fastest to run, highest bug-catching value per line.
// 2. **Widget tests** for critical, frequently-broken UI flows (checkout form validation, login form) — catches regressions in widget behavior without needing a full app/device.
// 3. **Golden tests** for visually critical, stable components (design-system widgets) to catch unintended visual regressions.
// 4. **Integration tests** (`integration_test` package) sparingly, for the 2-3 most business-critical end-to-end flows (e.g., "user can complete checkout") since they're slow and flaky-prone.
// Also set up CI to run unit/widget tests on every PR immediately, and add a rule that new code must include tests, to stop the untested surface area from growing further while backfilling existing code opportunistically.
//
// ---
//
// ### Q32. Write (describe) a widget test that verifies tapping a "Login" button shows a loading spinner and then navigates to the home screen on success.
// **Answer:**
// ```dart
// testWidgets('shows spinner then navigates on successful login', (tester) async {
// final mockAuth = MockAuthRepository();
// when(() => mockAuth.login(any(), any()))
//     .thenAnswer((_) async => Future.delayed(Duration(milliseconds: 100)));
//
// await tester.pumpWidget(MaterialApp(
// home: LoginScreen(authRepository: mockAuth),
// ));
//
// await tester.enterText(find.byKey(Key('email')), 'a@b.com');
// await tester.enterText(find.byKey(Key('password')), 'secret');
// await tester.tap(find.text('Login'));
// await tester.pump(); // rebuild after tap, before Future completes
//
// expect(find.byType(CircularProgressIndicator), findsOneWidget);
//
// await tester.pumpAndSettle(); // wait for Future + navigation animation
//
// expect(find.byType(HomeScreen), findsOneWidget);
// });
// ```
// Key points: `pump()` (single frame) captures the transient loading state; `pumpAndSettle()` (repeated frames until no more scheduled) captures the final state after async work and animations finish. Mock the repository so the test doesn't hit a real network.
//
// ---
//
// ### Q33. A widget test passes locally but fails intermittently in CI with a timeout. What are common causes and how do you debug?
// **Answer:**
// Common causes:
// - A real `Timer`/`Future.delayed`/animation that never completes within `pumpAndSettle`'s internal retry budget — e.g., an infinite/repeating animation (like a shimmer loader) causes `pumpAndSettle` to time out since frames never "settle."
// - A real network call accidentally made instead of a mocked one (works locally with fast Wi-Fi, flaky/slow on CI runners).
// - Test pollution: a previous test left a global singleton or timer running that leaks into the next test.
//
// **Debug approach:**
// - Replace `pumpAndSettle()` with explicit `pump(Duration(...))` calls for widgets with infinite animations, to avoid relying on "everything eventually stops."
// - Ensure all repositories/network clients are mocked (`mocktail`/`mockito`) in widget tests — never hit real endpoints.
// - Use `tearDown()` to reset singletons/DI containers between tests.
// - Increase logging or run the specific failing test with `--verbose` in CI to capture what's still pending when the timeout occurs.
//
// ---
//
// ### Q34. How do you unit test a `Bloc` that depends on a repository making an async API call, without hitting the network?
// **Answer:**
// Use `mocktail` (or `mockito`) to fake the repository, and the `bloc_test` package to assert emitted states declaratively:
// ```dart
// class MockRepo extends Mock implements WeatherRepository {}
//
// void main() {
// late MockRepo repo;
// setUp(() => repo = MockRepo());
//
// blocTest<WeatherBloc, WeatherState>(
// 'emits [Loading, Loaded] when fetch succeeds',
// build: () {
// when(() => repo.fetchWeather(any()))
//     .thenAnswer((_) async => Weather(temp: 25));
// return WeatherBloc(repo);
// },
// act: (bloc) => bloc.add(FetchWeather('Mumbai')),
// expect: () => [WeatherLoading(), WeatherLoaded(Weather(temp: 25))],
// );
//
// blocTest<WeatherBloc, WeatherState>(
// 'emits [Loading, Error] when fetch fails',
// build: () {
// when(() => repo.fetchWeather(any())).thenThrow(Exception('network'));
// return WeatherBloc(repo);
// },
// act: (bloc) => bloc.add(FetchWeather('Mumbai')),
// expect: () => [WeatherLoading(), isA<WeatherError>()],
// );
// }
// ```
// This tests the Bloc's logic (state transitions) in complete isolation from real network/IO, making tests fast and deterministic.
//
// ---
//
// ### Q35. Your app has a complex custom-painted chart widget. How would you test that it renders correctly and catch future visual regressions?
// **Answer:**
// Use **golden tests** (`matchesGoldenFile`): render the widget in a controlled environment and compare a pixel screenshot against a committed "golden" reference image.
// ```dart
// testWidgets('chart renders correctly', (tester) async {
// await tester.pumpWidget(MaterialApp(home: ChartWidget(data: sampleData)));
// await expectLater(
// find.byType(ChartWidget),
// matchesGoldenFile('goldens/chart_widget.png'),
// );
// });
// ```
// Considerations:
// - Run golden tests on a consistent environment (CI, same OS/fonts) since font rendering differs across platforms — often teams use `golden_toolkit` and Docker-based CI runners to keep results reproducible.
// - For the underlying drawing logic (e.g., a `CustomPainter`'s coordinate calculations), also add plain unit tests on pure functions (e.g., "given these data points, the computed bar heights are X") separate from the golden/pixel test, so logic bugs are caught precisely rather than just "pixels differ somewhere."
//
// ---
//
// ## 8. Platform Channels & Native Integration
//
// ### Q36. You need to call a native Android/iOS API (e.g., get the device's battery level) that has no existing Flutter plugin. How do you implement this from scratch?
// **Answer:**
// Use a **`MethodChannel`** to bridge Dart and native code:
// ```dart
// // Dart side
// static const _channel = MethodChannel('com.example.app/battery');
// Future<int> getBatteryLevel() async {
// final level = await _channel.invokeMethod<int>('getBatteryLevel');
// return level ?? -1;
// }
// ```
// ```kotlin
// // Android (Kotlin), in MainActivity
// MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example.app/battery")
//     .setMethodCallHandler { call, result ->
// if (call.method == "getBatteryLevel") {
// val batteryManager = getSystemService(BATTERY_SERVICE) as BatteryManager
// result.success(batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY))
// } else {
// result.notImplemented()
// }
// }
// ```
// Similarly implement in Swift for iOS using `FlutterMethodChannel`. Key points: channel names must match exactly on both sides; always handle `notImplemented()`/errors; wrap the call in try/catch on the Dart side since `PlatformException` can be thrown.
//
// ---
//
// ### Q37. You need continuous data from a native sensor (e.g., accelerometer) streamed into Flutter in real time, not just a one-off value. How does this differ from `MethodChannel` usage?
// **Answer:**
// Use an **`EventChannel`** instead, which is designed for continuous streams rather than one-off request/response:
// ```dart
// static const _eventChannel = EventChannel('com.example.app/accelerometer');
// Stream<List<double>> get accelerometerStream =>
// _eventChannel.receiveBroadcastStream().map((event) => List<double>.from(event));
// ```
// Native side implements `StreamHandler` with `onListen` (start sending events, e.g., register a sensor listener and call `events.success(data)` repeatedly) and `onCancel` (stop/unregister the listener when Dart stops listening — important to avoid draining battery when no one's subscribed). The Dart side then just does `accelerometerStream.listen((data) => ...)` like any other stream, and Flutter's stream subscription lifecycle (cancel in `dispose()`) naturally handles cleanup on the Dart side too.
//
// ---
//
// ### Q38. A `MethodChannel` call to native code is causing the UI to freeze briefly. Why might this happen, and how do you fix it?
// **Answer:**
// If the native-side implementation does the work **synchronously on the platform's main/UI thread** (e.g., a blocking file read or heavy computation inside the `MethodCallHandler` on Android's main thread), it blocks not just native UI but also delays Flutter's engine from processing frames, since Flutter's platform channel calls are dispatched through the platform thread by default.
//
// **Fix:**
// - On the native side, move the heavy work to a background thread/coroutine (Kotlin: `CoroutineScope(Dispatchers.IO).launch { ... }`, then call `result.success(...)` back on the main thread since `MethodChannel.Result` must be invoked on the platform thread) or use Android's `WorkManager`/iOS `DispatchQueue.global()`.
// - On the Flutter side, ensure the channel call is `await`ed properly (not blocking anything else), and consider batching or debouncing frequent channel calls.
// - If communicating very frequently (e.g., per-frame data), consider `BackgroundIsolateBinaryMessenger` (Flutter's support for calling platform channels from a background isolate) to avoid contending with the main isolate at all.
//
// ---
//
// ### Q39. You want to reuse an existing native SDK (e.g., a native camera SDK) that renders its own view, not just returns data. How do you embed it inside a Flutter widget?
// **Answer:**
// Use **Platform Views** (`AndroidView`/`UiKitView`, or the newer `PlatformViewLink`/Hybrid Composition):
// ```dart
// AndroidView(
// viewType: 'com.example.app/camera_view',
// onPlatformViewCreated: (id) => _controller = MethodChannel('com.example.app/camera_view_$id'),
// )
// ```
// Native side registers a `PlatformViewFactory` that creates and returns the native `View` (Android) or `UIView` (iOS) to be composited into the Flutter render tree. Trade-offs to mention in an interview:
// - Platform views are more expensive than pure Flutter widgets (extra compositing layer, especially on older Android using Virtual Display mode — Hybrid Composition is better but has its own constraints).
// - Gestures and scrolling can behave oddly across the Flutter/native boundary (e.g., nested scrolling) and often need explicit gesture-recognizer configuration (`gestureRecognizers` parameter).
// - Gate its use to genuinely necessary cases (e.g., no Flutter-native camera preview equivalent) since it sacrifices some of Flutter's "single rendering pipeline" performance benefits.
//
// ---
//
// ### Q40. Your app needs to run a task (e.g., syncing data) even when it's been backgrounded or killed by the OS. How do you approach this on both platforms?
// **Answer:**
// This requires native background execution APIs, wrapped for Flutter access, since Dart code doesn't run once the Flutter engine is fully torn down:
// - **Android**: use `WorkManager` (via a plugin like `workmanager`) to schedule guaranteed background work (periodic sync, retried on failure/constraints like network availability) that survives app kill and even reboots (if configured).
// - **iOS**: use `BGTaskScheduler` (Background App Refresh) via a plugin like `background_fetch`; iOS is much stricter about background execution time and frequency (no guaranteed periodic execution — the OS decides when to wake the app based on usage patterns), so design for "best effort, opportunistic sync" rather than guaranteed timing.
// - In both cases, the actual Dart callback runs in a **separate background isolate/engine entry point** (registered via `pluginRegistrantCallback`/a top-level function), not the main UI isolate — so it can't touch UI state directly; it typically writes results to local storage which the UI reads next time it's foregrounded.
// - Set realistic expectations with the team: iOS background execution guarantees are much weaker than Android's; design the feature (e.g., a "sync" badge) to also gracefully sync on next app-open rather than relying solely on background execution.
//
// ---
//
// ## 9. Memory Management & Common Bugs
//
// ### Q41. A `StreamController` created in a widget's `initState` is never closed. What's the consequence, and how do you fix it?
// **Answer:**
// An un-closed `StreamController` keeps its internal buffer/listeners alive even after the widget is disposed, causing a **memory leak** — the widget's State object (and anything it references) can't be garbage-collected because the still-open stream holds references to it. Over time (e.g., navigating to/from that screen repeatedly), memory usage climbs.
// **Fix:**
// ```dart
// final _controller = StreamController<int>();
//
// @override
// void dispose() {
// _controller.close(); // releases resources, notifies listeners of "done"
// super.dispose();
// }
// ```
// Also ensure any `StreamSubscription`s obtained via `.listen()` elsewhere are `.cancel()`ed in `dispose()`, and note that `close()` on a `StreamController` doesn't automatically cancel subscriptions made on *other* streams (e.g., a subscription to a Firestore snapshot stream) — each resource type needs its own explicit cleanup.
//
// ---
//
// ### Q42. You have a global `List<VoidCallback>` that widgets add themselves to in `initState` (a simple pub-sub pattern) but never remove themselves. What bug does this cause, and how do you fix it?
// **Answer:**
// This is a classic **listener leak**: disposed widgets remain referenced by the global list forever, so (a) they can never be garbage collected (memory leak) and (b) when the global event fires, it tries to invoke callbacks on `State` objects that are already disposed — likely calling `setState` on a disposed widget, throwing an exception (`setState() called after dispose()` or similar), or silently doing wasted work.
//
// **Fix:** always pair registration with de-registration:
// ```dart
// @override
// void initState() {
// super.initState();
// globalListeners.add(_onEvent);
// }
//
// @override
// void dispose() {
// globalListeners.remove(_onEvent);
// super.dispose();
// }
// ```
// Better yet, replace the hand-rolled pub-sub with a `ChangeNotifier`/`ValueNotifier` + `addListener`/`removeListener`, or a proper state-management solution, since these enforce the same pattern more consistently and are easier to audit for correctness.
//
// ---
//
// ### Q43. Why can circular references between a parent widget's controller and a child callback cause subtle memory issues in Dart, even though Dart is garbage-collected?
// **Answer:**
// Dart's garbage collector handles ordinary circular references between objects fine (it uses a tracing/generational GC, not naive reference counting, so cycles with no external roots are collected normally). The real issue in Flutter isn't GC cycles per se, but **external roots that outlive the widget**: e.g., a global singleton, a static list, a long-lived `Timer`, or a native platform callback holding a reference (directly or via a closure capturing `this`/`context`) to a disposed `State` object. As long as *something* reachable from a GC root (like a still-running `Timer` or an un-removed listener list) points to the object, it can't be collected — regardless of whether there's also a "cycle" involved.
// Practical guidance: focus code review on **anything with a lifespan longer than the widget** (timers, streams, singletons, static collections, native channels) as the places explicit cleanup is required — that's where leaks actually originate, not internal object cycles.
//
// ---
//
// ### Q44. You notice `AnimationController`s are not being disposed in several screens across the codebase — how would you catch this systematically rather than manually reviewing every file?
// **Answer:**
// - Enable the **`must_call_super`**-style analysis and the `flutter_lints`/`very_good_analysis` lint sets — some cover the general dispose pattern.
// - Use `leak_tracker` (bundled into `flutter_test` for widget tests since Flutter 3.x) — it automatically detects "leaked" disposables (like un-disposed `AnimationController`, `TextEditingController`, `FocusNode`) during test runs and fails the test with a report of exactly which object leaked and where it was created.
// - Add a **custom lint rule** (via `custom_lint`/`dart_code_metrics`) that flags any class implementing `SingleTickerProviderStateMixin`/creating an `AnimationController` in `initState` without a corresponding `.dispose()` call in the same class's `dispose()` method.
// - As a stop-gap, grep the codebase for `AnimationController(` and cross-check each result has a matching `.dispose()` in the same file — useful for an initial audit before automated tooling is in place.
//
// ---
//
// ### Q45. Explain `RepaintBoundary` and describe a scenario where adding one improves performance, and one where it can hurt performance.
// **Answer:**
// `RepaintBoundary` creates a separate compositing **layer**, isolating the widget subtree below it so that when it repaints, ancestors/siblings don't need to repaint too, and vice versa.
//
// **Helps:** A complex, frequently-updating widget (e.g., an animated loading spinner) sitting next to a large, static widget tree (e.g., a long article of text). Without a boundary, every spinner frame could force Flutter to consider repainting the surrounding static content too. Wrapping the spinner in `RepaintBoundary` isolates its repaints to just that small layer.
//
// **Hurts:** Wrapping *many* small, independently-changing widgets (e.g., every single character/icon in a long list) each in their own `RepaintBoundary` creates excessive numbers of GPU compositing layers, each with memory/compositing overhead — this can *increase* raster time and memory usage rather than help, since the benefit of isolation is outweighed by the cost of maintaining many separate layers. Use `RepaintBoundary` judiciously around specific expensive/animating widgets identified via profiling (DevTools "Highlight Repaints"), not everywhere by default.
//
// ---
//
// ## 10. UI / Layout & Responsive Design
//
// ### Q46. You get a `RenderFlex overflowed by X pixels` error when a `Row` contains a long piece of text next to a fixed-width icon. How do you fix it, and what are the different options with their trade-offs?
// **Answer:**
// The `Row` gives each child its intrinsic width by default, and if the sum exceeds available width, it overflows rather than wrapping.
//
// Options:
// 1. **`Expanded`/`Flexible`** around the `Text`: forces the text to take remaining space and wrap/ellipsize within it.
// ```dart
// Row(children: [
// Icon(Icons.star),
// Expanded(child: Text(longText, overflow: TextOverflow.ellipsis)),
// ])
// ```
// 2. **`Flexible` with `FlexFit.loose`**: similar but allows the text to be smaller than the available space if it doesn't need it (vs. `Expanded`, which always fills).
// 3. **`Wrap` instead of `Row`**: if you want the text to flow to a new line rather than truncate — different UX (multi-line vs. single-line truncation).
// 4. **`FittedBox`**: scales content down to fit, useful for short numeric labels but distorts long text (not ideal here).
//
// Trade-off guidance: use `Expanded` + `TextOverflow.ellipsis` when you want a clean single-line UI (common in list tiles), and `Wrap`/multi-line `Text` when full content visibility matters more than a compact single line.
//
// ---
//
// ### Q47. Your app needs to look good on phones, tablets, and foldables/desktop, with different layouts (single column vs. master-detail). How do you architect responsive layout?
// **Answer:**
// - Use `LayoutBuilder` (or `MediaQuery.sizeOf(context)`) at key layout decision points to branch based on available width, following breakpoints similar to Material guidelines (e.g., compact <600dp, medium 600-840dp, expanded >840dp):
// ```dart
// LayoutBuilder(builder: (context, constraints) {
// if (constraints.maxWidth < 600) return SingleColumnLayout();
// return MasterDetailLayout();
// });
// ```
// - Prefer `LayoutBuilder` (measures the *parent's* constraints) over `MediaQuery` (measures the whole *screen*) when the widget is nested inside something that doesn't take full screen width (e.g., inside a side panel) — `MediaQuery` would give the wrong breakpoint in that case.
// - Use flexible widgets (`Expanded`, `Flexible`, `FractionallySizedBox`) and avoid hardcoded pixel sizes; test on multiple `MediaQuery` overrides in widget tests / DevTools device-preview.
// - Consider the `flutter_adaptive_scaffold` package (from the Flutter team) which implements Material's adaptive layout patterns (nav rail vs. bottom nav vs. drawer) out of the box based on breakpoints.
// - Handle foldables specifically via `MediaQuery.of(context).displayFeatures` to detect hinge position and avoid rendering critical content under the fold.
//
// ---
//
// ### Q48. A designer hands you a Figma design with exact pixel values, but the app looks different-sized across devices with different screen densities. How do you reconcile "pixel-perfect" design with Flutter's logical pixel system?
// **Answer:**
// Flutter measures in **logical pixels** (device-independent pixels, "dp"), automatically scaled by the device pixel ratio for actual rendering — so a `Container(width: 100)` renders physically larger on a high-DPI device but occupies the same *relative* screen space. This is by design and generally what you want (a button shouldn't become tiny on a high-density phone).
//
// Reconciliation steps:
// 1. Confirm the Figma frame's base width (commonly designed at 375dp or 360dp for phones) and note that values are already meant to be logical/dp, not raw pixels — check with the designer if unsure, since some tools export at 1x/2x/3x raw pixel scales.
// 2. For proportional scaling across very different screen sizes (small phone vs. tablet), avoid literal pixel matching everywhere; instead use responsive units (percentages of screen width via `MediaQuery`, or a package like `flutter_screenutil` that scales dp values relative to a design reference size) — but use this sparingly, as overuse can make text/UI inconsistently sized relative to system settings.
// 3. Respect the user's OS-level text scale factor (`MediaQuery.textScalerOf`) rather than fighting it with fixed pixel text sizes, for accessibility — pixel-perfect fidelity should yield to accessibility needs when they conflict.
//
// ---
//
// ### Q49. You built a form screen that looks fine, but when the on-screen keyboard opens, the submit button gets hidden behind it, or the whole layout overflows. How do you fix this properly?
// **Answer:**
// - Ensure the screen is wrapped in a `Scaffold` (which by default resizes to avoid the keyboard via `resizeToAvoidBottomInset: true`) — check this isn't accidentally disabled.
// - Wrap the scrollable content in a `SingleChildScrollView` so that when the keyboard reduces available height, content can scroll rather than overflow (`Column`s alone don't scroll and will throw overflow errors when squeezed).
// - For a submit button that should stay visible/pinned above the keyboard, consider `Scaffold`'s `bottomNavigationBar`/`persistentFooterButtons` (which stay above the keyboard automatically) or wrap it using `Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))` to shift it up as the keyboard appears.
// - Test specifically on smaller devices (e.g., iPhone SE) with a form that has many fields — this combination (small screen + keyboard + many fields) is where these bugs surface most.
//
// ---
//
// ### Q50. Your app must support RTL languages (e.g., Arabic) in addition to LTR. What Flutter-specific mistakes commonly break RTL layouts, and how do you avoid them?
// **Answer:**
// Common mistakes and fixes:
// - **Using `EdgeInsets.only(left: ..., right: ...)`** instead of **`EdgeInsetsDirectional.only(start: ..., end: ...)`** — the former is a fixed physical direction, so in RTL mode "left" padding stays on the visual left even though it should flip to become "end" padding. Use `start`/`end` variants everywhere spacing has semantic (not literal) directionality.
// - **Hardcoded `Alignment.centerLeft`/`.centerRight`** instead of `AlignmentDirectional.centerStart`/`.centerEnd`.
// - **Icons that imply direction** (e.g., a "back" arrow `Icons.arrow_back`) — Flutter's Material icons for back/forward often auto-flip based on `Directionality`, but custom icons/SVGs may not; wrap direction-sensitive custom icons in a check against `Directionality.of(context) == TextDirection.rtl` and mirror them if needed.
// - **Testing only in LTR during development** and only checking RTL right before release — instead, set `Directionality` to RTL early via `MaterialApp`'s `locale`/`supportedLocales` + a debug toggle, so RTL bugs are caught throughout development, not as a last-minute scramble.
// - Ensure `MaterialApp` has proper localization delegates (`GlobalMaterialLocalizations.delegate`, etc.) configured so built-in widgets (date pickers, text fields) also respect the locale's directionality and formatting conventions.
//
// ---
//
// *End of document — 50 scenario-based Flutter questions with answers, covering state management, lifecycle, performance, architecture, async/isolates, navigation, testing, native integration, memory management, and responsive UI.*