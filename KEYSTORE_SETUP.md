# Keystore Setup - Final Steps

## ✅ What's Already Done

1. ✅ Application ID updated to `com.codek.fitnessworkouts`
2. ✅ `build.gradle.kts` configured for release signing
3. ✅ `key.properties` file created

## 🔑 Next Steps to Complete Setup

### Step 1: Create the Keystore File

Run this command in your terminal (from the project root):

```bash
cd android
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

**You'll be prompted for:**
- Keystore password (remember this!)
- Key password (can be same as keystore password)
- Your name, organization, etc.

**Important**: 
- Save the passwords securely!
- The keystore file is required for all future updates
- If you lose it, you cannot update your app on Play Store

### Step 2: Update key.properties

Edit `android/key.properties` and replace the placeholders:

```properties
storePassword=YOUR_ACTUAL_PASSWORD
keyPassword=YOUR_ACTUAL_PASSWORD
keyAlias=upload
storeFile=../upload-keystore.jks
```

**Replace**:
- `YOUR_ACTUAL_PASSWORD` with the password you set when creating the keystore

### Step 3: Verify .gitignore

Make sure these are in `.gitignore` (already done ✅):
```
android/key.properties
android/upload-keystore.jks
*.jks
```

### Step 4: Test the Build

After completing steps 1-2, test the release build:

```bash
flutter build appbundle --release
```

If successful, you'll find the AAB file at:
`build/app/outputs/bundle/release/app-release.aab`

## 🔒 Security Reminders

1. **Never commit** `key.properties` or `upload-keystore.jks` to git
2. **Backup** the keystore file securely (cloud storage, USB drive, etc.)
3. **Store passwords** in a password manager
4. **Keep** the keystore file safe - you'll need it for every update

## ✅ Verification Checklist

- [ ] Keystore file created (`upload-keystore.jks`)
- [ ] `key.properties` updated with real passwords
- [ ] Keystore file is in `android/` directory
- [ ] `.gitignore` includes keystore files
- [ ] Release build succeeds
- [ ] AAB file generated successfully

## 🚨 Troubleshooting

### Error: "key.properties not found"
- Make sure `key.properties` is in `android/` directory
- Check the path in `build.gradle.kts` matches

### Error: "Keystore file not found"
- Make sure `upload-keystore.jks` is in `android/` directory
- Check the `storeFile` path in `key.properties`

### Error: "Wrong password"
- Double-check passwords in `key.properties`
- Make sure they match what you set when creating the keystore

### Build succeeds but signing fails
- Verify all fields in `key.properties` are correct
- Make sure keystore file exists and is readable

## 📝 Current Configuration

**Application ID**: `com.codek.fitnessworkouts` ✅  
**Keystore Alias**: `upload`  
**Keystore File**: `android/upload-keystore.jks` (create this)  
**Properties File**: `android/key.properties` ✅

## 🎯 Once Complete

After completing these steps:
1. Build release AAB: `flutter build appbundle --release`
2. Upload to Google Play Console
3. Submit for review

You're almost ready to publish! 🚀

