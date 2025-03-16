import 'package:flutter/material.dart';

class AppColors {
  // Color Stack

  // Theme Colors
  static const Color appThemeColor = Color(0xFFF3F3F3); // Main theme color
  static const Color appThemeColorAppBar = Color(0xFFF8F8F8); // AppBar theme color
  static const Color homeBG = Color(0xFFF3F5F9); // Background color for home screen
  static const Color appBarBG = Color(0xFFFEFEFC); // AppBar background color

  // Form Colors
  static const Color formBorder = Color(0xFFC0C0C0); // Border color for forms

  // Icon and Text Colors
  static const Color iconColor = Color(0xFF747880); // Color for icons
  static const Color currentValue = Color(0xFF1F262A); // Color for current value
  static const Color currentValueText = Color(0xFF000000); // Text color for current value
  static const Color installmentsColor = Color(0xFF6F6F6F); // Color for installment labels
  static const Color installmentsBoxColor = Color(0xFF85CCFF); // Color for installment boxes
  static const Color investedValueMain = Color(0xFF2F4F4F); // Color for main investment value
  static const Color contrastContainer = Color(0xFFCBE3EF); // Contrast container color (60%)
  static const Color totInvestments = Color(0xFF0D65D9); // Total investments color
  static const Color fieldColor = Color(0xFF96B0BD); // Color for input fields
  static const Color hintTextColor = Color(0xFF626672); // Hint text color
  static const Color hintTextColor2 = Color(0xFF5F93B1); // Hint text color
  static const Color textFieldOutlineBorderColor = Color(0xFF626672); // Outline border color for text fields

  // Button Colors
  static const Color loginBtnColor2 = Color(0xFF254E7A); // Alternate login button color
  static const Color loginBtnColor = Color(0xFF254E7A); // Primary login button color
  static const Color prevBtnColor = Color(0xFF6F6E6E); // Previous button color
  static const Color prevNextBtnTextColor = Color(0xFF909296); // Text color for prev/next buttons

  // Text Colors
  static const Color blackTextColor = Color(0xFF101010); // Default black text color
  static const Color whiteTextColor = Color(0xFFFBFBFB); // Default white text color
  static const Color noFocusBorderColor = Color(0xFFAAAAAA); // No-focus border color
  static const Color colorBlack = Color(0xFF070707); // Deep black color for specific elements
  static const Color paleOrange = Color(0xFFFFA869); // Pale orange color for highlights
  static const Color currentStatus = Color(0xFFFCAA00); // Color for current status indicators

  // Card and Scheme Colors
  static const Color mainCardField = Color(0xFF37474F); // Card background color
  static const Color schemeColor = Color(0xFF2B2B2C); // Scheme section color
  static const Color borderSideColor = Color(0xFF0065A0); // Scheme section color
  static const Color dividerColor = Color(0xFF96B0BD); // Scheme section color

  // Calculator Colors
  static const Color expectedColor = Color(0xFFDDE59B); // Expected returns color
  static const Color gainedColor = Color(0xFFFDAEA9); // Gained returns color
  static const Color investedColor = Color(0xFFF0CA86); // Invested amount color
  static const Color fieldValueColor = Color(0xFFD9EDFF); // Color for field values
  static const Color switchLabelColor = Color(0xFFF3F1F1); // Switch label color
  static const Color switchTabColor = Color(0xFFF3F1F1); // Switch tab color
  static const Color inputColor = Color(0xFF2F4F4F); // Input field color
  static const Color switchLabelBorderColor = Color(0xFFD7D7D7); // Switch label border color
  static const Color inputFieldBorderColor = Color(0xFFC1CFD7); // Input field border color (60%)

  // Accent Colors
  static const Color redAccent = Color(0xFFEB5757); // Red accent color
  static const Color greenAccent = Color(0xFF27AE60); // Green accent color
  static const Color orangeAccent = Color(0xFFDB5C00); // Orange accent color
  static const Color grey = Color(0xFF757575); // General grey color

  // Progress Colors
  static const Color progressOuterContainerColor = Color(0xFF404553); // Progress outer container color

  // Additional Colors
  static const Color paleRed = Color(0xFFE57373); // Pale red color
  static const Color red = Color(0xFFD10000); // Strong red color
}

// import 'package:flutter/material.dart';

class AppColorsTry {
  // Primary Colors
  static const Color primary = Color(0xFF254E7A); // Base Primary Color
  static const Color primaryDark = Color(0xFF19334F); // Darker Shade
  static const Color primaryLight = Color(0xFF4A729E); // Lighter Shade

  // Compatible Blue Shades
  static const Color blueAccent = Color(0xFF336B8E); // Soft, muted blue accent
  static const Color lightBlue = Color(0xFF6C98B7); // Lighter shade of blue for subtle elements
  static const Color deepBlue = Color(0xFF1F4C6B); // Deep blue for darker accents
  static const Color skyBlueAccent = Color(0xFF5B7C92); // Sky blue accent, slightly muted
  static const Color steelBlueAccent = Color(0xFF3A6E8E); // Steel blue with a darker touch

  // Secondary One Colors
  static const Color secondaryOne = Color(0xFF7A8D25); // Base Secondary One Color
  static const Color secondaryOneDark = Color(0xFF596618); // Darker Shade
  static const Color secondaryOneLight = Color(0xFFA2B14F); // Lighter Shade

  // Compatible Green Shades for Secondary One
  static const Color oliveGreen = Color(0xFF6B7A20); // Muted olive green for accents
  static const Color limeAccent = Color(0xFF8DA845); // Lighter lime-green for highlights
  static const Color mossGreen = Color(0xFF5C6917); // Dark mossy green for depth
  static const Color paleGreen = Color(0xFFB7CC72); // Pale green for softer backgrounds

  // Secondary Two Colors
  static const Color secondaryTwo = Color(0xFF7A2525); // Base Secondary Two Color
  static const Color secondaryTwoDark = Color(0xFF591A1A); // Darker Shade
  static const Color secondaryTwoLight = Color(0xFF9E4A4A); // Lighter Shade

  // Compatible Red Shades for Secondary Two
  static const Color maroonAccent = Color(0xFF6B2020); // Deep maroon for bold accents
  static const Color brickRed = Color(0xFF8A3939); // Brick red for medium contrast
  static const Color salmonPink = Color(0xFFB57272); // Light salmon pink for softer tones
  static const Color rosyRed = Color(0xFFCC8585); // Rosy red for muted highlights

  // Background Colors
  static const Color background = Color(0xFFF5F5F5); // General background
  static const Color surface = Color(0xFFFFFFFF); // Surfaces like cards and sheets

  // Text Colors
  static const Color textPrimary = Color(0xFF212121); // Main text
  static const Color textSecondary = Color(0xFF757575); // Secondary text
  static const Color textOnPrimary = Color(0xFFFFFFFF); // Text on primary backgrounds
  static const Color textOnSecondary = Color(0xFF000000); // Text on secondary backgrounds

  // Accent Colors
  static const Color success = Color(0xFF4CAF50); // For success states
  static const Color warning = Color(0xFFFFC107); // For warnings
  static const Color error = Color(0xFFF44336); // For errors

  // Divider and Border Colors
  static const Color divider = Color(0xFFE0E0E0); // Divider or border

  // Shadow
  static const Color shadow = Color(0x40000000); // Shadow with transparency
}

class AppColors4 {
  // Primary color and shades
  static const Color primary = Color(0xFF254E7A);
  static const Color primaryLight = Color(0xFF3F6E9D);
  static const Color primaryDark = Color(0xFF172F50);

  // Secondary color and shades
  static const Color secondary = Color(0xFFE67E22);
  static const Color secondaryLight = Color(0xFFF39C51);
  static const Color secondaryDark = Color(0xFFA55A16);

  // Tertiary color and shades
  static const Color tertiary = Color(0xFFF4F4F4);
  static const Color tertiaryLight = Color(0xFFFFFFFF);
  static const Color tertiaryDark = Color(0xFFD9D9D9);

  // Quaternary color and shades
  static const Color quaternary = Color(0xFFD92E28);
  static const Color quaternaryLight = Color(0xFFE6645E);
  static const Color quaternaryDark = Color(0xFF9A1F1A);
}
