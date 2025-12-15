# Google Play Console Submission Guide

## ⚠️ CRITICAL: Before You Submit

### 1. Change Application ID (REQUIRED)

**Current**: `com.example.fitnessworkouts`  
**Required**: Your unique application ID

**Steps**:
1. Open `android/app/build.gradle.kts`
2. Change line 9: `namespace = "com.yourcompany.fitnessworkouts"`
3. Change line 24: `applicationId = "com.yourcompany.fitnessworkouts"`

**Format**: `com.yourcompany.appname` or `com.yourname.appname`

**Example**:
- `com.johndoe.fitnessworkouts`
- `com.mycompany.offlinefitness`
- `com.fitnessapps.workouts`

⚠️ **WARNING**: Once published, you CANNOT change the application ID!

### 2. Configure Release Signing (REQUIRED)

**Current**: Using debug keys (NOT for production!)

**Steps to Create Release Keystore**:

1. **Create keystore** (run in project root):
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2. **Create `android/key.properties`**:
```properties
storePassword=<your-keystore-password>
keyPassword=<your-key-password>
keyAlias=upload
storeFile=<path-to-keystore>/upload-keystore.jks
```

3. **Update `android/app/build.gradle.kts`** (see instructions below)

### 3. Update App Version

In `pubspec.yaml`:
```yaml
version: 1.0.0+1
```
- Format: `versionName+versionCode`
- Increment versionCode for each release

## 📝 Step-by-Step Submission Process

### Step 1: Fix Application ID

1. Open `android/app/build.gradle.kts`
2. Replace `com.example.fitnessworkouts` with your unique ID
3. Update both `namespace` and `applicationId`

### Step 2: Setup Release Signing

1. **Create keystore** (one-time):
```bash
cd android
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2. **Create `android/key.properties`**:
```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=upload
storeFile=upload-keystore.jks
```

3. **Add to `.gitignore`**:
```
android/key.properties
android/upload-keystore.jks
```

4. **Update `android/app/build.gradle.kts`** (see file below)

### Step 3: Build Release Bundle

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### Step 4: Create Play Console Listing

1. **App Name**: "Offline Fitness Workouts"
2. **Short Description** (80 chars):
   "Fully offline fitness app with workout routines, timer, and progress tracking. Zero permissions required."

3. **Full Description** (4000 chars):
   Use content from `app_description.txt` or expand it.

4. **Screenshots Required**:
   - Phone: 2-8 screenshots
   - Tablet (7"): 1+ screenshots (if supported)
   - Tablet (10"): 1+ screenshots (if supported)

5. **Feature Graphic**: 1024 x 500 pixels

6. **App Icon**: 512 x 512 pixels

### Step 5: Content Rating

Complete the questionnaire:
- Category: Health & Fitness
- No user-generated content
- No social features
- No ads
- No in-app purchases
- No location data
- No personal information collected

### Step 6: Privacy Policy

- **URL**: You can use an in-app privacy policy
- **Content**: Already included in app (`PrivacyPolicyScreen`)
- **Note**: For apps with zero data collection, you can state "No data collected"

### Step 7: Upload and Submit

1. Upload the AAB file
2. Complete all required sections
3. Review and submit
4. Wait for review (usually 1-3 days)

## ✅ Pre-Submission Checklist

### Code
- [ ] Application ID changed from `com.example`
- [ ] App name updated in manifest
- [ ] Release signing configured
- [ ] Version code incremented
- [ ] No debug code in release build
- [ ] Tested release build

### Content
- [ ] App description written
- [ ] Screenshots prepared
- [ ] Feature graphic created
- [ ] App icon finalized
- [ ] Privacy policy accessible

### Testing
- [ ] Tested on multiple devices
- [ ] Tested release build
- [ ] No crashes
- [ ] All features work
- [ ] Performance acceptable

### Play Console
- [ ] Developer account ready
- [ ] App created
- [ ] Store listing complete
- [ ] Content rating done
- [ ] AAB uploaded
- [ ] Release notes written

## 🚨 Common Issues & Solutions

### Issue: "Invalid Application ID"
**Solution**: Change from `com.example` to your unique ID

### Issue: "Missing Privacy Policy"
**Solution**: Add privacy policy URL or state "No data collected"

### Issue: "App Crashes on Launch"
**Solution**: Test release build thoroughly before submission

### Issue: "Incomplete Store Listing"
**Solution**: Complete all required fields in Play Console

## 📱 Testing Release Build

Before submitting, test the release build:

```bash
# Build release APK for testing
flutter build apk --release

# Install on device
adb install build/app/outputs/flutter-apk/app-release.apk

# Test all features
# - App launches
# - All screens work
# - No crashes
# - Performance is good
```

## 🔒 Security Notes

- **Never commit** `key.properties` or keystore files
- **Backup** your keystore file securely
- **Store passwords** in a secure password manager
- **Use App Signing by Google Play** (recommended)

## 📞 Support

If you encounter issues:
1. Check Google Play Console help
2. Review Flutter documentation
3. Check Android developer guides

## ✅ Final Checklist

Before clicking "Submit for Review":

- [ ] Application ID is unique (not com.example)
- [ ] Release signing is configured
- [ ] App has been tested in release mode
- [ ] All store listing fields are complete
- [ ] Screenshots are uploaded
- [ ] Privacy policy is accessible
- [ ] Content rating is complete
- [ ] App complies with all policies

**Good luck with your submission! 🚀**

