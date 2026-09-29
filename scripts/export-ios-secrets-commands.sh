#!/usr/bin/env bash
# Run on Mac after you have Distribution .p12 and App Store .mobileprovision for com.pt.shagymart
# Usage: ./scripts/export-ios-secrets-commands.sh /path/to/cert.p12 /path/to/profile.mobileprovision

set -euo pipefail

P12="${1:?Usage: $0 cert.p12 profile.mobileprovision}"
PP="${2:?Usage: $0 cert.p12 profile.mobileprovision}"

echo "=== Add these GitHub Secrets (Shagy repo → Settings → Secrets → Actions) ==="
echo ""
echo "IOS_DIST_CERTIFICATE_BASE64:"
base64 -i "$P12" | tr -d '\n'
echo ""
echo ""
echo "IOS_PROVISIONING_PROFILE_BASE64:"
base64 -i "$PP" | tr -d '\n'
echo ""
echo ""
echo "IOS_PROVISIONING_PROFILE_NAME (copy exact name from Apple Developer / Xcode):"
security cms -D -i "$PP" 2>/dev/null | plutil -extract Name raw - 2>/dev/null || echo "(open profile in Xcode to see name)"
echo ""
echo "IOS_TEAM_ID: 7WSYLQ8Y87  (verify in Apple Developer → Membership)"
echo "IOS_DIST_CERTIFICATE_PASSWORD: (your .p12 export password)"
echo "IOS_KEYCHAIN_PASSWORD: any random string, e.g. $(openssl rand -hex 16)"
