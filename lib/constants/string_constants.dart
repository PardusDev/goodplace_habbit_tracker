import 'dart:math';

import 'package:flutter/material.dart';

@immutable
class StringConstants {
  // Can't instantiate this class. Use it directly.
  const StringConstants._();

  static const String appName = 'GoodPlace';

  //region Error screen strings
  static const String notFound = "We couldn't find the page you were looking for";
  static const String notFoundSub = "Something went wrong. Try again later 👉👈";
  static const String back = "Back";
  //endregion

  //region No Network screen strings
  static const String noNetwork = "No Network";
  static const String noNetworkSub = "Please check your internet connection and try again.";
  //endregion

  //region Welcome screen strings
  static const String welcomeScreenStrongTitle = 'Hi, Welcome';
  static const String welcomeScreenTitle = "to $appName";
  static const String welcomeScreenSubtitle = 'Explore the app, Find some peace of mind to achive good habits.';
  static const String welcomeScreenButton = 'Get Started';
  //endregion

  //region Login screen strings
  static const String loginScreenTitle = 'Welcome Back!';
  static const String loginWithGoogle = 'Continue with Google';
  static const String loginScreenOrText = 'OR LOG IN WITH EMAIL';
  static const String loginScreenEmailHint = 'Email address';
  static const String loginScreenPasswordHint = 'Password';
  static const String loginScreenLoginButton = 'LOG IN';
  static const String loginScreenForgotPassword = 'Forgot Password?';
  static const String dontHaveAnAccount = "Don't have an account? ";
  static const String signUp = 'Sign Up';

  // Password error
  static const String loginScreenPasswordCantBeEmpty = "Password can't be empty.";
  static const String loginScreenEmailOrPasswdNotRight  = "Invalid email or password.";
  static const String anErrorOccured = "An error occured.";
  //endregion

  //region Register screen strings
  static const String registerScreenTitle = 'Create your account';
  static const String registerScreenOrText = 'OR SIGN UP WITH EMAIL';
  static const String registerScreenNameHint = 'Name';
  static const String registerScreenEmailHint = "Email address";
  static const String registerScreenPasswordHint = "Password";
  static const String registerScreenRetypePasswordHint = "Retype Password";
  static const String registerScreenPrivacyPolicyText = "I have read the ";
  static const String registerScreenPrivacyPolicyLink = "Privacy Policy";
  static const String registerScreenGetStartedButton = 'Get Started';
  static const String registerScreenAlreadyHaveAnAccount = 'ALREADY HAVE AN ACCOUNT? ';
  static const String registerScreenSignIn = "SIGN IN";
  static const String pleaseWait = "Please wait...";

  static const String registerScreenNameCantBeEmpty = "Name can't be empty.";
  static const String registerScreenNameNotValid = "Name is not valid.";
  static const String registerScreenNameShouldBeAtLeast2Chars = "Name should be at least 2 characters.";

  static const String registerScreenEmailCantBeEmpty = "Email can't be empty.";
  static const String registerScreenEmailNotValid = "Email is not valid.";

  static const String registerScreenPasswordCantBeEmpty = "Password can't be empty.";
  static const String registerScreenPasswordShouldBeAtLeast6Chars = "Password should be at least 6 characters.";
  static const String registerScreenPasswordShouldContainNumber = "Password should contain at least one number.";
  static const String registerScreenPasswordShouldContainLetter = "Password should contain at least one letter.";
  static const String registerScreenCannotContainSpace = "Password cannot contain space.";
  static const String registerScreenPrivacyPolicyNotChecked = "Please accept the Privacy Policy.";
  //endregion

  //region Onboarding screen strings
  static const String onboardingPage1Title = 'Track Your Habit';
  static const String onboardingPage1Subtitle = "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals";

  static const String onboardingPage2Title = 'Get Burn';
  static const String onboardingPage2Subtitle = "Let's keep burning, to achive yours goals, it hurts only temporarily, if you give up now you will be in pain forever";

  static const String onboardingPage3Title = 'Eat Well';
  static const String onboardingPage3Subtitle = "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun";

  static const String onboardingPage4Title = 'Morning Yoga';
  static const String onboardingPage4Subtitle = "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun";
  //endregion

  //region Firebase Auth Exceptions
  static const String invalidEmail = "The email address is badly formatted.";
  static const String wrongPassword = "The password is incorrect. Please try again.";
  static const String userDisabled = "This user account has been disabled. Please contact support.";
  static const String emailAlreadyInUse = "The email address is already in use by another account.";
  static const String userNotFound = "No user found with this email. Please check the email address and try again.";
  static const String tooManyRequests = "Too many requests. Please try again later.";
  static const String operationNotAllowed = "Operation not allowed. Please contact support.";

  static const String accountExists = 'An account already exists with a different credential.';
  static const String invalidCredential = 'The credential received is not valid or has expired. Please try again.';
  static const String invalidVerificationCode = 'The verification code is invalid.';
  static const String invalidVerificationId = 'The verification ID is invalid.';
  //endregion

  //region Firebase General Exceptions
  static const String operationCancelled = 'The operation was cancelled.';
  static const String unknownError = 'An unknown error occurred.';
  static const String invalidArgument = 'An invalid argument was provided.';
  static const String deadlineExceeded = 'The operation timed out.';
  static const String documentNotFound = 'The requested document was not found.';
  static const String documentAlreadyExists = 'The document already exists.';
  static const String permissionDenied = 'You do not have permission to perform this operation.';
  static const String resourceExhausted = 'The resource has been exhausted (quota exceeded).';
  static const String failedPrecondition = 'Operation could not be performed due to failed preconditions.';
  static const String operationAborted = 'The operation was aborted.';
  static const String outOfRange = 'The operation was attempted outside the valid range.';
  static const String operationNotImplemented = 'This operation is not implemented or supported.';
  static const String internalError = 'An internal error occurred.';
  static const String serviceUnavailable = 'The service is currently unavailable.';
  static const String dataLoss = 'Unrecoverable data loss or corruption.';
  static const String unauthenticated = 'You are not authenticated. Please log in and try again.';
  //endregion

  // region Dio Exceptions
  static const String requestCancelled = "Request to the server was cancelled.";
  static const String connectionTimeout = "Connection timeout with the server.";
  static const String sendTimeout = "Send timeout in connection with the server.";
  static const String receiveTimeout = "Receive timeout in connection with the server.";
  static const String badRequest = "Bad request.";
  static const String unauthorized = "Unauthorized request.";
  static const String forbidden = "Forbidden request.";
  static const String dioNotFound = "Requested resource not found.";
  static const String internalServerError = "Internal server error.";
  static const String badCertificate = "Bad SSL certificate.";
  static const String connectionError = "Connection error occurred.";
  // endregion Dio Exceptions END

  //region Privacy Policy
  static const String privacyPolicy = 'Privacy Policy';
  static const String privacyPolicyText = '''
  <h1>Privacy Policy</h1>
<p>Last updated: August 17, 2024</p>
<p>This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.</p>
<p>We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the <a href="https://www.freeprivacypolicy.com/free-privacy-policy-generator/" target="_blank">Free Privacy Policy Generator</a>.</p>
<h2>Interpretation and Definitions</h2>
<h3>Interpretation</h3>
<p>The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.</p>
<h3>Definitions</h3>
<p>For the purposes of this Privacy Policy:</p>
<ul>
<li>
<p><strong>Account</strong> means a unique account created for You to access our Service or parts of our Service.</p>
</li>
<li>
<p><strong>Affiliate</strong> means an entity that controls, is controlled by or is under common control with a party, where &quot;control&quot; means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.</p>
</li>
<li>
<p><strong>Application</strong> refers to GoodPlace, the software program provided by the Company.</p>
</li>
<li>
<p><strong>Company</strong> (referred to as either &quot;the Company&quot;, &quot;We&quot;, &quot;Us&quot; or &quot;Our&quot; in this Agreement) refers to GoodPlace.</p>
</li>
<li>
<p><strong>Country</strong> refers to:  Turkey</p>
</li>
<li>
<p><strong>Device</strong> means any device that can access the Service such as a computer, a cellphone or a digital tablet.</p>
</li>
<li>
<p><strong>Personal Data</strong> is any information that relates to an identified or identifiable individual.</p>
</li>
<li>
<p><strong>Service</strong> refers to the Application.</p>
</li>
<li>
<p><strong>Service Provider</strong> means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.</p>
</li>
<li>
<p><strong>Usage Data</strong> refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).</p>
</li>
<li>
<p><strong>You</strong> means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.</p>
</li>
</ul>
<h2>Collecting and Using Your Personal Data</h2>
<h3>Types of Data Collected</h3>
<h4>Personal Data</h4>
<p>While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:</p>
<ul>
<li>
<p>Email address</p>
</li>
<li>
<p>First name and last name</p>
</li>
<li>
<p>Usage Data</p>
</li>
</ul>
<h4>Usage Data</h4>
<p>Usage Data is collected automatically when using the Service.</p>
<p>Usage Data may include information such as Your Device's Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.</p>
<p>When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.</p>
<p>We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.</p>
<h4>Information Collected while Using the Application</h4>
<p>While using Our Application, in order to provide features of Our Application, We may collect, with Your prior permission:</p>
<ul>
<li>Pictures and other information from your Device's camera and photo library</li>
</ul>
<p>We use this information to provide features of Our Service, to improve and customize Our Service. The information may be uploaded to the Company's servers and/or a Service Provider's server or it may be simply stored on Your device.</p>
<p>You can enable or disable access to this information at any time, through Your Device settings.</p>
<h3>Use of Your Personal Data</h3>
<p>The Company may use Personal Data for the following purposes:</p>
<ul>
<li>
<p><strong>To provide and maintain our Service</strong>, including to monitor the usage of our Service.</p>
</li>
<li>
<p><strong>To manage Your Account:</strong> to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.</p>
</li>
<li>
<p><strong>For the performance of a contract:</strong> the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service.</p>
</li>
<li>
<p><strong>To contact You:</strong> To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application's push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation.</p>
</li>
<li>
<p><strong>To provide You</strong> with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information.</p>
</li>
<li>
<p><strong>To manage Your requests:</strong> To attend and manage Your requests to Us.</p>
</li>
<li>
<p><strong>For business transfers:</strong> We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which Personal Data held by Us about our Service users is among the assets transferred.</p>
</li>
<li>
<p><strong>For other purposes</strong>: We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience.</p>
</li>
</ul>
<p>We may share Your personal information in the following situations:</p>
<ul>
<li><strong>With Service Providers:</strong> We may share Your personal information with Service Providers to monitor and analyze the use of our Service,  to contact You.</li>
<li><strong>For business transfers:</strong> We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company.</li>
<li><strong>With Affiliates:</strong> We may share Your information with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies that We control or that are under common control with Us.</li>
<li><strong>With business partners:</strong> We may share Your information with Our business partners to offer You certain products, services or promotions.</li>
<li><strong>With other users:</strong> when You share personal information or otherwise interact in the public areas with other users, such information may be viewed by all users and may be publicly distributed outside.</li>
<li><strong>With Your consent</strong>: We may disclose Your personal information for any other purpose with Your consent.</li>
</ul>
<h3>Retention of Your Personal Data</h3>
<p>The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.</p>
<p>The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.</p>
<h3>Transfer of Your Personal Data</h3>
<p>Your information, including Personal Data, is processed at the Company's operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from Your jurisdiction.</p>
<p>Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.</p>
<p>The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.</p>
<h3>Delete Your Personal Data</h3>
<p>You have the right to delete or request that We assist in deleting the Personal Data that We have collected about You.</p>
<p>Our Service may give You the ability to delete certain information about You from within the Service.</p>
<p>You may update, amend, or delete Your information at any time by signing in to Your Account, if you have one, and visiting the account settings section that allows you to manage Your personal information. You may also contact Us to request access to, correct, or delete any personal information that You have provided to Us.</p>
<p>Please note, however, that We may need to retain certain information when we have a legal obligation or lawful basis to do so.</p>
<h3>Disclosure of Your Personal Data</h3>
<h4>Business Transactions</h4>
<p>If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.</p>
<h4>Law enforcement</h4>
<p>Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).</p>
<h4>Other legal requirements</h4>
<p>The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:</p>
<ul>
<li>Comply with a legal obligation</li>
<li>Protect and defend the rights or property of the Company</li>
<li>Prevent or investigate possible wrongdoing in connection with the Service</li>
<li>Protect the personal safety of Users of the Service or the public</li>
<li>Protect against legal liability</li>
</ul>
<h3>Security of Your Personal Data</h3>
<p>The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.</p>
<h2>Children's Privacy</h2>
<p>Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.</p>
<p>If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent's consent before We collect and use that information.</p>
<h2>Links to Other Websites</h2>
<p>Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party's site. We strongly advise You to review the Privacy Policy of every site You visit.</p>
<p>We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.</p>
<h2>Changes to this Privacy Policy</h2>
<p>We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.</p>
<p>We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the &quot;Last updated&quot; date at the top of this Privacy Policy.</p>
<p>You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.</p>
<h2>Contact Us</h2>
<p>If you have any questions about this Privacy Policy, You can contact us:</p>
  ''';
  //endregion

  //region Collapsable Bottom Sheet
  static const String collapsableBottomSheetClose = 'Close';
  //endregion

  // region Alert Dialog
  static const String alertDialogOk = 'OK';
  static const String alertDialogConfirm = 'Confirm';
  static const String alertDialogCancel = 'Cancel';
  // endregion

  // region Settings screen strings
  static const String settingsScreenTitle = "Settings";
  static const String deleteAccount = "Delete Account";
  // endregion

  // region Delete Account Confirmation
  static const String areYouSure = "Are you sure?";
  static const String deleteAccountConfirmationText = "Are you sure you want to delete your account? This action cannot be undone.";
  // endregion Settings screen strings END

  // region Habits operations
  static const String myHabits = "My Habits";
  static const String homePageHabitListIsEmpty = "You don't have any habits yet. Create one now!";
  static const String homePageHabitListTileButton = "Do it!";
  static const String homePageHabitListTileButtonCompleted = "Already Done";
  static const String homePageHabitListTileShowAllText = "Show All";
  // region Create Habit Screen
  static const String createHabitScreenTitle = "Create Habit";
  static const String createHabitScreenNameHint = "Habit Name";
  static const String createHabitScreenSubjectHint = "What is your subject?";
  static const String createHabitScreenAddImageLabel = "Add Image";
  static const String createHabitScreenCreateButton = "Create";
  static const String createHabitScreenNameEmptyError = "Habit name can't be empty.";
  static const String createHabitScreenImageNotSelectedError = "Please select an image for your habit.";

  static const String fetchImagesError = "An error occured while fetching images. Please try again later.";
  static const String uploadImageError = "An error occured while uploading image. Please try again later.";
  static const String createHabitError = "An error occured while creating habit. Please try again later.";

  // endregion
  // region Success Screen
  static const String successScreenTitle = "Success!";

  static const List<String> successScreenSubtitles = [
    "High five! You’re on fire (in a good way)!",
    "Boom! You just owned that task!",
    "Achievement unlocked: You’re officially awesome!",
    "Habit complete! You’re basically a habit ninja now.",
    "Habit success! Who’s the boss? You’re the boss!",
    "Daily habit done! Your streak is hotter than your morning coffee.",
    "Crushed it! Your future self is giving you a high five!"
  ];

  static get successScreenSubtitleRandom => successScreenSubtitles[Random().nextInt(successScreenSubtitles.length)];

  static const String successScreenButton = "Done";
  // endregion

  // region Habit Alert Dialog
  static const String habitAlertDialogTitle = "Are you sure?";
  static const String habitAlertDialogBody = "Do you want to remove this habit?";
  // endregion Habits operations END

  // region Habit Errors
  static const String habitPastDateError = "You can't mark habits for the past.";
  // endregion

}