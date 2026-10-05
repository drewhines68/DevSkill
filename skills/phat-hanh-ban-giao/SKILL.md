---
name: phat-hanh-ban-giao
description: "Release/Docs (gate G5–G6): chốt nhánh khi test xanh, dựng pre-commit hook, viết PR có bằng chứng và mức rủi ro merge, tài liệu bàn giao, triển khai có xác nhận, và retro sau dự án. Tổng hợp từ finishing-a-development-branch (obra/superpowers), pr, setup-pre-commit, git-guardrails, handoff, retro (mattpocock). Dùng khi hoàn tất tính năng cần merge/PR/release, viết README hoặc tài liệu bàn giao, thiết lập hook chất lượng, triển khai, hoặc tổng kết rút kinh nghiệm."
---

# phat-hanh-ban-giao

Vai trò: Release & Docs. Chỉ bắt đầu khi QA đã đạt. Trả lời bằng ngôn ngữ của người dùng.

## Bước 1 — Xác minh lần cuối

Chạy toàn bộ test suite. Có lỗi thì báo danh sách lỗi và dừng — chỉ đưa lựa chọn tích hợp khi suite xanh.

## Bước 2 — Hàng rào chất lượng

- **Pre-commit hook** (JS/TS): Husky + lint-staged chạy Prettier trên file staged, rồi `typecheck` và `test`. Dò package manager theo lockfile (npm, pnpm, yarn, bun). Repo thiếu script typecheck/test thì bỏ dòng đó và báo người dùng. Python: `pre-commit` + ruff + pytest tương đương.
- **Git guardrails**: không tự chạy lệnh nguy hiểm — `push --force`, `reset --hard`, `clean -fd`, `branch -D`, `checkout .` — khi chưa có người dùng đồng ý.

## Bước 3 — Tích hợp nhánh

Xác nhận nhánh gốc: "Nhánh này tách từ <nhánh>, đúng không?" rồi đưa đúng 3 lựa chọn:

1. Merge vào <nhánh gốc> trên máy.
2. Push và tạo Pull Request.
3. Giữ nguyên nhánh, xử lý sau.

Thực hiện lựa chọn, sau đó dọn worktree tạm của subagent.

## Bước 4 — Viết PR

```text
## Tóm tắt
<sơ đồ nhỏ nhất làm rõ ý chính: pseudocode, call tree, cây component>

## Bằng chứng
- Trước: <ảnh / output / test đỏ>
  Sau: <ảnh / output / test xanh>

## Rủi ro merge
Cửa: <một chiều | hai chiều>
Phạm vi ảnh hưởng: <một từ> — <hệ quả có thể có>
```

Bỏ lời mở đầu, văn xuôi ngắn, dùng thuật ngữ miền.

## Bước 5 — Tài liệu bàn giao

- **README**: sản phẩm làm gì · yêu cầu hệ thống · cài đặt · chạy local · chạy test · biến môi trường (chỉ tên và ý nghĩa, không kèm giá trị) · triển khai.
- **CHANGELOG**: thay đổi theo phiên bản.
- **Tài liệu bàn giao** (`docs/HANDOFF.md` hoặc trang Notion): link spec, thiết kế, kiến trúc, ADR, PR, cách vận hành, việc còn tồn.

## Bước 6 — Triển khai

Chỉ deploy khi người dùng đồng ý rõ ràng. Secret nhập qua công cụ nhập an toàn, không ghi vào chat, code hay tài liệu. Sau deploy: kiểm tra nhanh luồng chính trên môi trường thật và báo kết quả kèm bằng chứng.

## Bước 7 — Retro (G6)

Đọc lại phiên làm việc, tìm cải tiến cho **môi trường** của agent, trình bày theo mức độ nghiêm trọng:

- **Điều hướng**: agent mất nhiều thời gian tìm thông tin nào? Cần thêm chỉ dẫn ở đâu?
- **Kiểm tra tự động**: lỗi nào lẽ ra lint, typecheck, test bắt được?
- **Chuẩn code**: quy tắc nào nên thêm/bớt cho reviewer? Lỗi máy móc → biến thành kiểm tra tự động.
- **Tiết kiệm công cụ**: lệnh/tool nào tốn kém, có thể gọn hơn?
- **Truy cập thông tin**: thông tin quan trọng nào agent không có?
- **Skill**: đề xuất cập nhật skill nào trong bộ dieu-phoi-du-an.

## Chuyển giao

Khi bàn giao cho phiên/agent khác: mục tiêu, trạng thái, link artifact (không chép lại), skill gợi ý. Che secret và dữ liệu cá nhân.

## Nguồn

- [finishing-a-development-branch — obra/superpowers](https://www.skills.sh/obra/superpowers/finishing-a-development-branch)
- [setup-pre-commit — mattpocock/skills](https://www.skills.sh/mattpocock/skills/setup-pre-commit)
- [git-guardrails-claude-code — mattpocock/skills](https://www.skills.sh/mattpocock/skills/git-guardrails-claude-code)
- [pr, handoff, retro — mattpocock/skills](https://github.com/mattpocock/skills)
