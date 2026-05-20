#!/bin/bash
set -e

# --- 設定 ---
# 1Password のアイテム名
OP_ITEM="AWS Access Key"

# 1Password 上のフィールドラベル（実際のラベルに合わせる / 大文字小文字も区別される）
OP_ITEM_LABEL_CACHE="session_cache"
OP_ITEM_LABEL_ACCESS_KEY="access key id"
OP_ITEM_LABEL_SECRET_KEY="secret access key" # pragma: allowlist secret
OP_ITEM_LABEL_MFA_SERIAL="mfa serial"

# --- 0. 環境変数を完全にクリア ---
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
unset AWS_SECURITY_TOKEN
unset AWS_PROFILE

# --- 1. 1Password からアイテム情報を一括取得 ---
OP_JSON=$(op item get "$OP_ITEM" --format json)

# --- 2. キャッシュの確認 ---
ENCODED_CACHE=$(echo "$OP_JSON" | jq -r --arg label "$OP_ITEM_LABEL_CACHE" '.fields[] | select(.label==$label).value // empty')

if [ -n "$ENCODED_CACHE" ]; then
    DECODED_CACHE=$(echo "$ENCODED_CACHE" | base64 -d 2>/dev/null || echo "")
    if [ -n "$DECODED_CACHE" ]; then
        CURRENT_TIME=$(date +%s)
        IS_VALID=$(echo "$DECODED_CACHE" | jq -r --argjson now "$CURRENT_TIME" '
            if .Credentials.Expiration then
                (.Credentials.Expiration | sub("\\+00:00$"; "Z") | sub("\\.[0-9]+Z$"; "Z") | fromdateiso8601) > ($now + 30)
            else
                false
            end
        ')
        if [ "$IS_VALID" = "true" ]; then
            echo "$DECODED_CACHE" | jq '{Version: 1, AccessKeyId: .Credentials.AccessKeyId, SecretAccessKey: .Credentials.SecretAccessKey, SessionToken: .Credentials.SessionToken, Expiration: .Credentials.Expiration}'
            exit 0
        fi
    fi
fi

# --- 3. キャッシュがない/切れそうな場合は新規取得 ---
ACCESS_KEY=$(echo "$OP_JSON" | jq -r --arg label "$OP_ITEM_LABEL_ACCESS_KEY" '.fields[] | select(.label==$label).value')
SECRET_KEY=$(echo "$OP_JSON" | jq -r --arg label "$OP_ITEM_LABEL_SECRET_KEY" '.fields[] | select(.label==$label).value')
MFA_SERIAL=$(echo "$OP_JSON" | jq -r --arg label "$OP_ITEM_LABEL_MFA_SERIAL" '.fields[] | select(.label==$label).value')

MFA_CODE=$(op item get "$OP_ITEM" --otp)

if [ -z "$ACCESS_KEY" ] || [ -z "$SECRET_KEY" ] || [ -z "$MFA_CODE" ]; then
    echo "Error: Failed to retrieve credentials from 1Password." >&2
    exit 1
fi

# --- 4. AWS STS 実行 ---
export AWS_ACCESS_KEY_ID="$ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="$SECRET_KEY"

OUTPUT=$(aws sts get-session-token \
    --serial-number "$MFA_SERIAL" \
    --token-code "$MFA_CODE" \
    --output json 2>&1)

STATUS=$?

if [ $STATUS -ne 0 ]; then
    echo "Error calling aws sts get-session-token:" >&2
    echo "$OUTPUT" >&2
    exit 1
fi

# --- 5. 1Password にキャッシュを保存 ---
ENCODED_OUTPUT=$(echo "$OUTPUT" | base64)

op item edit "$OP_ITEM" "$OP_ITEM_LABEL_CACHE[password]=$ENCODED_OUTPUT" >/dev/null 2>&1

echo "$OUTPUT" | jq '{Version: 1, AccessKeyId: .Credentials.AccessKeyId, SecretAccessKey: .Credentials.SecretAccessKey, SessionToken: .Credentials.SessionToken, Expiration: .Credentials.Expiration}'
