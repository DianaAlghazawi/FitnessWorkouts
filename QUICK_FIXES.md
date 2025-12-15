# Quick Fixes for Google Play Submission

## ⚠️ MUST FIX BEFORE SUBMISSION

### 1. Application ID (2 minutes)

**File**: `android/app/build.gradle.kts`

**Change**:
```kotlin
// Line 9 - CHANGE THIS
namespace = "com.yourcompany.fitnessworkouts"

// Line 24 - CHANGE THIS  
applicationId = "com.yourcompany.fitnessworkouts"
```

**Replace** `com.yourcompany.fitnessworkouts` with your unique ID:
- Format: `com.yourname.appname`
- Example: `com.johndoe.fitnessworkouts`

### 2. App Name (Already Fixed ✅)

**File**: `android/app/src/main/AndroidManifest.xml`

**Status**: ✅ Already updated to "Offline Fitness Workouts"

### 3. Release Signing (10 minutes)

**Step 1**: Create keystore
```bash
cd android
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

**Step 2**: Create `android/key.properties`
```properties
storePassword=YOUR_PASSWORD
keyPassword=YOUR_PASSWORD
keyAlias=upload
storeFile=upload-keystore.jks
```

**Step 3**: Update `android/app/build.gradle.kts`

Add at the top (after plugins):
```kotlin
// Load keystore properties
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = java.util.Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(java.io.FileInputStream(keystorePropertiesFile))
}
```

Add signing configs (inside android block):
```kotlin
signingConfigs {
    create("release") {
        keyAlias = keystoreProperties["keyAlias"] as String
        keyPassword = keystoreProperties["keyPassword"] as String
        storeFile = file(keystoreProperties["storeFile"] as String)
        storePassword = keystoreProperties["storePassword"] as String
    }
}
```

Update buildTypes:
```kotlin
buildTypes {
    getByName("release") {
        signingConfig = signingConfigs.getByName("release")
    }
}
```

**Step 4**: Add to `.gitignore`
```
android/key.properties
android/upload-keystore.jks
```

## ✅ Already Compliant

- ✅ Zero permissions in release build
- ✅ No network requests
- ✅ Privacy policy included
- ✅ All features work offline
- ✅ Material 3 design
- ✅ Error handling
- ✅ Empty states

## 📦 Build Release

After fixes:
```bash
flutter build appbundle --release
```

Upload `build/app/outputs/bundle/release/app-release.aab` to Play Console.

## ⏱️ Time Estimate

- Application ID: 2 minutes
- Release signing: 10 minutes
- Build: 5 minutes
- **Total: ~20 minutes**

Then proceed with Play Console setup (store listing, screenshots, etc.)

