import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stockholding/core/widgets/CommanWidgets.dart';
import '../../../../core/theam/app_fonts.dart';
import '../provider/otp_providers.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _enteredOtp => _controllers.map((c) => c.text).join();

  void _onDigitChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    if (index == 5) {
      FocusScope.of(context).unfocus();
      ref.read(otpControllerProvider.notifier).submitOtp(_enteredOtp);
    }
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    ref.read(otpControllerProvider.notifier).submitOtp(_enteredOtp);
  }

  @override
  Widget build(BuildContext context) {
    final otpState = ref.watch(otpControllerProvider);

    // React to state changes: navigate on success, show snackbar on error
    ref.listen<AsyncValue<bool?>>(otpControllerProvider, (previous, next) {
      next.when(
        data: (isVerified) {
          if (isVerified == true) {
            context.go(
              '/homescreen',
            ); // no back navigation, per your earlier setup
          }
        },
        loading: () {},
        error: (err, _) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: CommonText(
                  err.toString(),
                  fontFamily: AppFonts.fontName,
                  fontWeight: FontWeight.w200,
                  // 👈 bold — maps to RethinkSans-Bold.ttf
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            );
          for (final c in _controllers) {
            c.clear();
          }
          _focusNodes[0].requestFocus();
        },
      );
    });

    final isLoading = otpState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const CommonText(
          'Verify OTP',
          fontFamily: AppFonts.fontName,
          fontWeight: FontWeight.w200,
          // 👈 bold — maps to RethinkSans-Bold.ttf
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              const CommonText(
                'Enter the 6-digit code which is 111111 sent to your phone',
                fontFamily: AppFonts.fontName,
                fontWeight: FontWeight.w200,
                // 👈 bold — maps to RethinkSans-Bold.ttf
                fontSize: 15,
                color: Colors.black,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 45,
                    child: CommonTextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      focus: index == 0,
                      textAlign: TextAlign.center,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        hintText: 'Search by symbol, exchange...',
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) => _onDigitChanged(value, index),
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      color: Colors.black,
                      fontFamily: AppFonts.fontName,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submit,
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const CommonText(
                          'Submit',
                          fontFamily: AppFonts.fontName,
                          fontWeight: FontWeight.w200,
                          // 👈 bold — maps to RethinkSans-Bold.ttf
                          fontSize: 15,
                          color: Colors.black,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
