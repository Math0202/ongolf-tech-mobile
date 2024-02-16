import 'package:flutter/material.dart';
import 'package:ongolf_tech/RegistrationScreens/RegistrationOptions.dart';

class TandCs extends StatefulWidget {
  const TandCs({Key? key}) : super(key: key);

  @override
  State<TandCs> createState() => _TandCsState();
}

class _TandCsState extends State<TandCs> {
  final ScrollController _scrollController = ScrollController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Check if the user has reached the bottom of the terms text
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _isButtonEnabled = true;
      });
    } else {
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            const SizedBox(height: 60),

            // Header Text
            Container(
              child: const Text(
                "T & C's",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // Use Expanded and Flexible to ensure scrolling without overflow
            Expanded(
              child: Flexible(
                child: Container(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: const Text(
                      'OnGolf Mobile App - Terms and Conditions for Golf Players \n Last Updated: [30/01/2024]  \n Welcome to OnGolf, the ultimate mobile app for golf enthusiasts. Please read these terms and conditions carefully before using our app.  \n 1. Acceptance of Terms  \n By downloading, installing, or using the OnGolf mobile app ("App"), you agree to comply with and be bound by these terms and conditions. If you do not agree to these terms, please do not use the App.  \n 2. User Registration \n To access certain features of the App, you may be required to register for an account. You agree to provide accurate, current, and complete information during the registration process and to update such information to keep it accurate, current, and complete.  \n 3. Use of the App  \n a. Eligibility: You must be at least 16 years old to use the App for inputting scores and for online payments unless permitted by an elder or guardian to do so.  \n b. License: We grant you a personal, non-exclusive, non-transferable, limited license to use the App solely for your personal and non-commercial purposes.  \n c. Prohibited Activities: You agree not to engage in any of the following activities:  \n - Violating any applicable laws or regulations.  \n - Using the App for any purpose that is illegal or prohibited by these terms.  \n - Interfering with the security features of the App.  \n - Attempting to access or use another user’s account without authorization.  \n 4. Content and Submissions  \n a. User-Generated Content: You may have the opportunity to submit content, such as scores, reviews, or comments. By submitting content, you grant us a worldwide, non-exclusive, royalty-free, sublicensable license to use, reproduce, adapt, publish, translate, and distribute such content.  \n b. Content Guidelines: You agree not to submit any content that is unlawful, obscene, defamatory, threatening, invasive of privacy, or infringing on intellectual property rights.  \n 5. Privacy Policy  \n Your use of the App is also governed by our Privacy Policy. Please review the Privacy Policy to understand our practices.  \n 6. Modifications  \n We reserve the right to modify or discontinue the App at any time without notice. We also reserve the right to update or modify these terms at any time.  \n 7. Termination  \n We may terminate or suspend your access to the App without prior notice for any reason, including a breach of these terms.  \n 8. Disclaimer of Warranties  \n The App is provided on an "as-is" basis. We make no warranties, express or implied, regarding the accuracy, completeness, reliability, or suitability of the App.  \n 9. Limitation of Liability  \n To the extent permitted by law, we shall not be liable for any indirect, incidental, special, consequential, or punitive damages.  \n 10. Governing Law  \n These terms and conditions are governed by and construed in accordance with the laws of The Republic of Namibia.  \n By using the App, you agree to these terms and conditions. If you have any questions, please contact us at [Ongolftech@gmail.com].',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _isButtonEnabled
                  ? () => navigateToRegistrationOptions(context)
                  : null,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0),
                child: Text(
                  'ACCEPT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to navigate to RegistrationOptions screen
  void navigateToRegistrationOptions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegistrationOptions(),
      ),
    );
  }
}