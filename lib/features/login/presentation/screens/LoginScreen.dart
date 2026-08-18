import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stockholding/core/constants/globalVariables.dart';
import 'package:stockholding/features/login/domain/entities/authenticate_params.dart';
import 'package:stockholding/features/login/presentation/controllers/authenticate_controller.dart';
import 'package:stockholding/features/watchlist/presentation/controllers/wlDetails_controller.dart';

import '../../../../core/router/route_names.dart';
 import '../../../orderbook/presentation/controllers/orderBook_controller.dart';
 import '../../domain/entities/passauth_params.dart';
import '../controllers/passauth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _clientIdController = TextEditingController(text: "EKS560743");
  final _passwordController = TextEditingController(text: "Bse@1234");
  final _dobController = TextEditingController(text: "20/08/1980"); // stored as DD-MM-YYYY

  bool _obscurePassword = true;

  @override
  void dispose() {
    _clientIdController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value, String fieldLabel) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldLabel is required';
    }
    return null;
  }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      final dd = picked.day.toString().padLeft(2, '0');
      final mm = picked.month.toString().padLeft(2, '0');
      final yyyy = picked.year.toString();
      _dobController.text = '20/08/1980';
    }
  }

  /// DOB as stored is DD-MM-YYYY (matches the `dob` field format already
  /// used elsewhere: '20-08-1980'). secondFactorValue in PassAuthParams
  /// expects DDMMYYYY with no separators ('20081980') — derive it here
  /// instead of asking the user to type it twice.
  String get _dobDigitsOnly => _dobController.text.replaceAll('-', '');

  /// Kicks off the full login chain: Authenticate -> (on success) PassAuth
  /// -> (on success) GetWatchlist -> (on success) navigate. Each step below
  /// only fires once its prerequisite actually completed, via the
  /// ref.listen blocks in build().
  void _handleLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final clientId = _clientIdController.text.trim();
    final dob = _dobController.text.trim();

    final params = AuthenticateParams(
      inputType: 2,
      inputValue: clientId,
      dob: dob,
      tokenId: 'abc',
      iv: 'abc',
      passFlag: 'X',
    );

    ref.read(authenticateControllerProvider.notifier).authenticate(params);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authenticateControllerProvider);
    final passAuthState = ref.watch(passAuthControllerProvider);


    final isLoading = state.isLoading ||
        passAuthState.isLoading;

    // Step 2: Authenticate succeeded -> fire PassAuth automatically.
    ref.listen(authenticateControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (result) {
          final isFreshFetch = previous?.isLoading ?? false;
          if (result != null && result.isSuccess && isFreshFetch) {
            final clientId = _clientIdController.text.trim();
            final dob = _dobController.text.trim();
            final password = _passwordController.text;

            final params = PassAuthParams(
              entityId: clientId,
              inputType: 2,
              inputValue: clientId,
              dob: dob,
              source: 'M',
              authenticationType: 1,
              authenticationValue: password,
              entityIdType: 1,
              loginTerminal: 'NITS',
              secondFactorType: 1,
              secondFactorValue: _dobDigitsOnly,
              aesKey: result.decryptedAesKey,
              tokenId: result.decryptedTokenId,
              imeiNo: '',
              iv: '',
            );

            ref.read(passAuthControllerProvider.notifier).passAuth(params);
          }
        },
        error: (e, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        },
      );
    });

    // Step 3: PassAuth succeeded -> fire GetWatchlist automatically.
    ref.listen(passAuthControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (result) {
          final isFreshFetch = previous?.isLoading ?? false;
          if (result != null && result.isSuccess && isFreshFetch) {
            final authResult = ref.read(authenticateControllerProvider).value;
            if (authResult == null || !authResult.isSuccess) return;


            clientId=_clientIdController.text.trim();
            dob=_dobController.text.trim();
            tokenID=authResult.decryptedTokenId;
            iV=authResult.decryptedAesKey;
            context.push(RouteNames.homescreen);

          }
        },
        error: (e, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Welcome back',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Enter your details to continue',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 32),

                    // Client ID
                    TextFormField(
                      controller: _clientIdController,
                      textInputAction: TextInputAction.next,
                      enabled: !isLoading,
                      decoration: const InputDecoration(
                        labelText: 'Client ID',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => _requiredValidator(v, 'Client ID'),
                    ),
                    const SizedBox(height: 16),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.next,
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                        ),
                      ),
                      validator: (v) => _requiredValidator(v, 'Password'),
                    ),
                    const SizedBox(height: 16),

                    // Date of Birth — read-only, opens a date picker.
                    TextFormField(
                      controller: _dobController,
                      readOnly: true,
                      enabled: !isLoading,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: 'Date of Birth',
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                        border: OutlineInputBorder(),
                        hintText: 'DD-MM-YYYY',
                      ),
                      onTap: isLoading ? null : _pickDob,
                      validator: (v) => _requiredValidator(v, 'Date of Birth'),
                    ),
                    const SizedBox(height: 32),

                    // Login button — drives the whole chain via
                    // _handleLogin() + the ref.listen blocks above.
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _handleLogin,
                        child: isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}