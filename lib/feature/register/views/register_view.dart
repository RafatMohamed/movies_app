import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:svg_flutter/svg.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/core/utilities/app_border_radius.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';
import 'package:movies_app/core/widgets/custom_button_app.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/core/widgets/language_toggle.dart';
import 'package:movies_app/feature/login/views/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: const TextStyle(color: AppColors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.r16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.r16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.r16),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.r16),
                borderSide: const BorderSide(color: AppColors.red),
              ),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Gap(16),
                  _buildAppBar(context, textTheme),
                  const Gap(24),
                  const _AvatarCarousel(),
                  const Gap(AppPadding.p8),
                  Center(
                    child: Text(
                      "Avatar",
                      style: textTheme.labelSmall?.copyWith(fontSize: 16),
                    ),
                  ),
                  const Gap(AppPadding.p24),
                  CustomTextFormField(
                    hintText: "Name",
                    controller: nameController,
                    isName: true,
                    withValidator: true,
                    prefixIconPath: AppAssets.name,
                  ),
                  const Gap(AppPadding.p16),
                  CustomTextFormField(
                    hintText: "Email",
                    controller: emailController,
                    isEmail: true,
                    withValidator: true,
                    keyboardType: TextInputType.emailAddress,
                    prefixIconPath: AppAssets.emailIcon,
                  ),
                  const Gap(AppPadding.p16),
                  CustomTextFormField(
                    hintText: "Password",
                    controller: passwordController,
                    isPassword: true,
                    withValidator: true,
                    prefixIconPath: AppAssets.passwordIcon,
                  ),
                  const Gap(AppPadding.p16),
                  CustomTextFormField(
                    hintText: "Confirm Password",
                    controller: confirmPasswordController,
                    isPassword: true,
                    withValidator: true,
                    prefixIconPath: AppAssets.passwordIcon,
                  ),
                  const Gap(AppPadding.p16),
                  CustomTextFormField(
                    hintText: "Phone Number",
                    controller: phoneController,
                    withValidator: true,
                    keyboardType: TextInputType.phone,
                    prefixIconPath: AppAssets.phone,
                  ),
                  const Gap(AppPadding.p24),
                  CustomButtonApp(
                    text: "Create Account",
                    textStyle: textTheme.labelSmall?.copyWith(
                      color: AppColors.deepBlack,
                    ),
                    onTap: () {
                      // TODO: handle create account
                    },
                  ),
                  const Gap(AppPadding.p20),
                  _buildLoginRow(context, textTheme),
                  const Gap(AppPadding.p24),
                  const Center(child: LanguageToggle()),
                  const Gap(48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, TextTheme textTheme) {
    return SizedBox(
      height: 32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                AppAssets.arrowBackDetails,
                colorFilter: const ColorFilter.mode(AppColors.gold, BlendMode.srcIn),
                width: 24,
                height: 24,
              ),
            ),
          ),
          Text(
            "Register",
            style: textTheme.titleMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.gold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginRow(BuildContext context, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already Have Account ? ",
          style: textTheme.titleMedium?.copyWith(color: AppColors.white),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          },
          child: Text(
            "Login",
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}


class _AvatarCarousel extends StatefulWidget {
  const _AvatarCarousel();

  @override
  State<_AvatarCarousel> createState() => _AvatarCarouselState();
}

class _AvatarCarouselState extends State<_AvatarCarousel> {
  static const List<String> _avatars = [
    AppAssets.person1,
    AppAssets.person2,
    AppAssets.person3,
  ];
  static const double _selectedSize = 150;
  static const double _viewportFraction = 0.5;

  late final PageController _controller;
  double _page = 1;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: _viewportFraction,
      initialPage: 1,
    );
    _controller.addListener(() {
      setState(() => _page = _controller.page ?? 1);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _selectedSize,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final peekWidth = constraints.maxWidth * (1 - _viewportFraction) / 2;
          final unselectedSize = (peekWidth - 6).clamp(50.0, 90.0);

          return PageView.builder(
            controller: _controller,
            itemCount: _avatars.length,
            itemBuilder: (context, index) {
              final distance = (index - _page).abs().clamp(0.0, 1.0);
              final size =
                  unselectedSize + (_selectedSize - unselectedSize) * (1 - distance);
              final side = index > _page ? -1.0 : (index < _page ? 1.0 : 0.0);
              final alignment = Alignment(side * distance, 0);

              return Align(
                alignment: alignment,
                child: Container(
                  width: size,
                  height: size,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightBlack,
                  ),
                  child: Image.asset(_avatars[index], fit: BoxFit.cover),
                ),
              );
            },
          );
        },
      ),
    );
  }
}