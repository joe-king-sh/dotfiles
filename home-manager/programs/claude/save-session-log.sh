#!/bin/bash

# Claude Code SessionEnd hook: transcript を自動保存する
# 保存先: ~/.claude/session-logs/

INPUT=$(cat)

TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path')
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id')
CWD=$(echo "$INPUT" | jq -r '.cwd')
REASON=$(echo "$INPUT" | jq -r '.reason')

# transcript_path が空またはファイルが存在しない場合はスキップ
if [ -z "$TRANSCRIPT_PATH" ] || [ ! -f "$TRANSCRIPT_PATH" ]; then
  exit 0
fi

SAVE_DIR="$HOME/.claude/session-logs"
mkdir -p "$SAVE_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
PROJECT_NAME=$(basename "$CWD")
FILENAME="${TIMESTAMP}_${PROJECT_NAME}_${SESSION_ID}.jsonl"

cp "$TRANSCRIPT_PATH" "$SAVE_DIR/$FILENAME"
