#!/usr/bin/env bash
# So sánh SHA hiện tại của các skill gốc (upstream) với SHA đã ghi trong sources.json.
# Dùng: bash scripts/check-upstream.sh   (tuỳ chọn: export GITHUB_TOKEN=... để tránh giới hạn 60 request/giờ)
# In ra danh sách skill gốc đã thay đổi; exit 0 nếu không có thay đổi, 10 nếu có.
set -euo pipefail
cd "$(dirname "$0")/.."
command -v jq >/dev/null || { echo "Cần cài jq"; exit 1; }
AUTH=(); [ -n "${GITHUB_TOKEN:-}" ] && AUTH=(-H "Authorization: Bearer $GITHUB_TOKEN")
changed=0
while IFS=$'\t' read -r skill repo branch path sha; do
  cur=$(curl -fsS "${AUTH[@]}" "https://api.github.com/repos/$repo/contents/$path?ref=$branch" | jq -r .sha 2>/dev/null || echo "ERROR")
  if [ "$cur" != "$sha" ]; then
    changed=1
    echo "CHANGED  $skill  <-  $repo/$path  (cũ: ${sha:0:7}  mới: ${cur:0:7})"
    echo "         xem: https://github.com/$repo/commits/$branch/$path"
  fi
done < <(jq -r '.skills | to_entries[] | .key as $s | .value[] | [$s,.repo,.branch,.path,.sha] | @tsv' sources.json)
[ $changed -eq 0 ] && echo "Không có skill gốc nào thay đổi." && exit 0
exit 10
