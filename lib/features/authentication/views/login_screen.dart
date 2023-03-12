import 'package:carrotmarket/config/view_models/config_view_model.dart';
import 'package:carrotmarket/constants/gaps.dart';
import 'package:carrotmarket/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = "login";
  static const String routeURL = "/login";

  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  bool isDisabled = true;
  final TextEditingController _controller = TextEditingController();

  void _onChangedPhoneField(String value) {
    if (value.length > 7) {
      isDisabled = false;
    } else {
      isDisabled = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size24,
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                overflow: TextOverflow.clip,
                text: TextSpan(
                  text: "안녕하세요!\n",
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w600,
                    color: ref.watch(configProvider).darkMode
                        ? Colors.grey.shade700
                        : Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: "휴대폰 번호로 로그인해주세요.\r\n",
                    ),
                    TextSpan(
                      text: "휴대폰 번호는 안전하게 보관되며 이웃들에게 공개되지 않아요.",
                      style: TextStyle(
                        fontSize: Sizes.size12 + Sizes.size1,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.v12,
              TextField(
                controller: _controller,
                onChanged: (value) => _onChangedPhoneField(value),
                style: const TextStyle(
                  fontSize: Sizes.size14,
                  height: Sizes.size2,
                ),
                autocorrect: false,
                autofocus: true,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "휴대폰 번호(- 없이 숫자만 입력)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.size10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade700,
                    ),
                    borderRadius: BorderRadius.circular(Sizes.size10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size12,
                  ),
                ),
              ),
              Gaps.v12,
              FractionallySizedBox(
                widthFactor: 1,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.symmetric(vertical: Sizes.size12),
                  decoration: BoxDecoration(
                    color: ref.watch(configProvider).darkMode
                        ? Colors.black
                        : Colors.white,
                    borderRadius: BorderRadius.circular(Sizes.size5),
                    border: Border.all(
                      color: isDisabled
                          ? Colors.grey.shade300
                          : Colors.grey.shade800,
                    ),
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 500),
                    style: TextStyle(
                      color: isDisabled
                          ? Colors.grey.shade300
                          : Colors.grey.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                    child: const Text(
                      "인증문자 받기",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Gaps.v10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "휴대폰 번호가 변경되었나요?",
                    style: TextStyle(
                      fontSize: Sizes.size14,
                    ),
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "이메일로 계정 찾기",
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
