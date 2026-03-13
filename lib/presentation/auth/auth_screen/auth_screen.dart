import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/di/injection.dart';
import 'package:gegabyteauto/core/router/app_router.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';
import 'package:gegabyteauto/presentation/auth/auth_screen/widgets/auth_animated_background.dart';
import 'package:gegabyteauto/presentation/auth/auth_screen/widgets/auth_register_link_section.dart';
import 'package:gegabyteauto/presentation/auth/auth_screen/widgets/auth_sign_in_form_card.dart';
import 'package:gegabyteauto/presentation/auth/auth_screen/widgets/auth_welcome_back_section.dart';
import 'package:gegabyteauto/presentation/auth/bloc/auth_bloc.dart';
import 'package:gegabyteauto/presentation/auth/bloc/auth_event.dart';
import 'package:gegabyteauto/presentation/auth/bloc/auth_state.dart';
import 'package:gegabyteauto/presentation/commons/widgets/app_logo.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: const _AuthView(),
    );
  }
}

class _AuthView extends StatefulWidget {
  const _AuthView();

  @override
  State<_AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<_AuthView>
    with SingleTickerProviderStateMixin {
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();
  final FocusNode _emailTextFieldFocus = FocusNode();
  final FocusNode _passwordTextFieldFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            AuthSignInRequested(
              email: _emailTextFieldController.text.trim(),
              password: _passwordTextFieldController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.router.replace(const ShellRoute());
        } else if (state is AuthFailureState) {
          _showErrorSnackBar(context, state.message);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            const AuthAnimatedBackground(),
            SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top -
                            MediaQuery.of(context).padding.bottom,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            AppLogo(),
                            const SizedBox(height: 40),
                            AuthWelcomeBackSection(),
                            const SizedBox(height: 40),
                            AuthSignInFormCard(
                              passwordTextFieldFocus: _passwordTextFieldFocus,
                              emailTextFieldFocus: _emailTextFieldFocus,
                              emailTextFieldController:
                                  _emailTextFieldController,
                              passwordTextFieldController:
                                  _passwordTextFieldController,
                              formKey: _formKey,
                              onSignIn: _onSignIn,
                            ),
                            const SizedBox(height: 24),
                            AuthRegisterLinkSection(),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 20),
              const SizedBox(width: 12),
              Expanded(child: Text(message, style: AppTextStyles.bodySmall)),
            ],
          ),
          backgroundColor: AppColors.cardBackground,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.error, width: 0.5),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
  }
}
