import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_danish/utils/app_extentions.dart';
import 'package:portfolio_danish/utils/app_strings.dart';
import 'package:portfolio_danish/utils/app_theme.dart';
import 'package:portfolio_danish/widgets/custom_textfield.dart';
import 'package:universal_html/html.dart' as html;

class ContactMe extends StatefulWidget {
  const ContactMe({super.key});

  @override
  State<ContactMe> createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {
  final _formKey = GlobalKey();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact with me",
                style: textTheme.displaySmall!.copyWith(
                  color: PortfolioAppTheme.nameColor,
                ),
              ),
              SizedBox(height: context.height * 0.05),
              Container(
                width: context.width * 0.8,
                height: context.height * 0.7,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff36454F),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Let's make something awesome together!",
                            style: textTheme.titleMedium!.copyWith(
                              color: PortfolioAppTheme.nameColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: context.height * 0.01),
                          Text(
                            "I'm just a click away.",
                            style: textTheme.titleSmall
                                ?.copyWith(color: PortfolioAppTheme.white),
                          ),
                          SizedBox(height: context.height * 0.01),
                          Wrap(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.green,
                                ),
                                onPressed: () => gotoUrl(AppStrings.whatsapp),
                              ),
                              IconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.linkedin,
                                  color: PortfolioAppTheme.blue,
                                ),
                                onPressed: () => gotoUrl(AppStrings.linkedIn),
                              ),
                              IconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.upwork,
                                  color: Colors.green,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: context.width * 0.06),
                    Container(
                        height: context.height * 0.6,
                        width: context.width * 0.001,
                        color: Colors.white),
                    SizedBox(width: context.width * 0.06),
                    Form(
                      key: _formKey,
                      child: Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Fill it out:",
                              style: textTheme.titleMedium,
                            ),
                            SizedBox(height: 0.01 * context.height),
                            CustomTextField(
                              hintText: 'Your Name',
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: context.height * 0.02),
                            CustomTextField(
                              hintText: 'Email',
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: context.height * 0.02),
                            CustomTextField(
                              hintText: 'Subject & Description',
                              controller: subjectController,
                              maxLines: 4,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter subject';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: context.height * 0.02),
                            SizedBox(
                              width: context.width * 0.23,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: PortfolioAppTheme.nameColor,
                                  side: const BorderSide(
                                      color: PortfolioAppTheme.nameColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Text(
                                  'Submit',
                                  style: textTheme.titleSmall!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void gotoUrl(String platform) {
    html.window.open(platform, '_blank');
  }
}
