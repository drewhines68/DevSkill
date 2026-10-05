---
name: cap-nhat-skill
description: "Tự cập nhật bộ skill DevSkill: kiểm tra skill gốc (upstream) đã thay đổi chưa, nghiên cứu skill mới trên skills.sh, tổng hợp lại thành SKILL.md tiếng Việt, cập nhật sources.json, bảng vai trò và CHANGELOG, rồi commit. Dùng khi người dùng bảo cập nhật/làm mới skill, khi retro (G6) đề xuất sửa skill, khi thiếu skill cho một vai trò hoặc công nghệ mới, hoặc định kỳ trước khi bắt đầu dự án lớn."
---

# cap-nhat-skill

Vai trò: người bảo trì bộ skill. Mục tiêu là giữ skill **đúng, gọn, cập nhật**, không phình to. Trả lời bằng ngôn ngữ của người dùng.

## Bước 1 — Kiểm tra upstream

1. Chạy `bash scripts/check-upstream.sh` (có `GITHUB_TOKEN` thì export trước).
2. Với mỗi dòng `CHANGED`: mở lịch sử commit của file gốc, đọc phần thay đổi. Chỉ quan tâm thay đổi về **quy trình, quy tắc, ngưỡng số**; bỏ qua sửa chính tả, đổi định dạng.

## Bước 2 — Nghiên cứu skill mới

1. Mở https://www.skills.sh/ (All Time, Trending, Hot) và các trang Topics liên quan tới vai trò cần bổ sung.
2. Chỉ chọn skill phục vụ phát triển phần mềm: khám phá yêu cầu, thiết kế UI/UX, kiến trúc, lập trình, kiểm thử, phát hành. Bỏ qua skill gắn chặt một nền tảng riêng (Lark, Azure…) trừ khi dự án dùng nền tảng đó.
3. Đọc `SKILL.md` gốc trên GitHub (nguồn sơ cấp), không dựa vào bản tóm tắt.

## Bước 3 — Cập nhật skill

- **Tổng hợp, không sao chép**: viết lại bằng tiếng Việt, giữ thuật ngữ kỹ thuật tiếng Anh, gộp vào đúng bước của skill vai trò tương ứng.
- Giữ cấu trúc: frontmatter `name` + `description` (mô tả vai trò, tổng hợp từ đâu, "Dùng khi …"), các bước đánh số, mục **Nguồn** cuối file.
- Mỗi `SKILL.md` dưới ~300 dòng. Dài hơn thì tách phần tham chiếu ra file cạnh bên (ví dụ `skills/<tên>/reference.md`) và trỏ tới.
- Ưu tiên câu khẳng định điều cần làm; chỉ dùng câu cấm cho hàng rào an toàn.
- Thiếu hẳn một vai trò: tạo `skills/<ten-moi>/SKILL.md` (tên chữ thường, không dấu, nối bằng gạch ngang) và thêm vào bảng vai trò trong `AGENTS.md`, `README.md`, cùng bảng gate trong `skills/dieu-phoi-du-an/SKILL.md`.

## Bước 4 — Ghi nhận

1. Cập nhật `sources.json`: thêm/sửa nguồn, ghi SHA mới (lấy từ GitHub contents API), cập nhật `checked_at`.
2. Thêm mục vào `CHANGELOG.md`: ngày, skill nào đổi, vì sao, nguồn.
3. Chạy lại `bash scripts/check-upstream.sh`, kết quả phải là "Không có skill gốc nào thay đổi".

## Bước 5 — Commit

- Commit message: `skills: <tóm tắt>` (ví dụ `skills: kiem-thu-qa thêm kiểm thử accessibility tự động`).
- Hỏi người dùng trước khi push lên `main`; mặc định đề xuất tạo nhánh `update/<ngày>` và mở Pull Request.
- Không bao giờ commit token, mật khẩu hay dữ liệu cá nhân.

## Báo cáo

```text
Upstream thay đổi: <n> — đã áp dụng: <danh sách> — bỏ qua: <danh sách + lý do>
Skill mới: <tên — vai trò — nguồn>
Commit / PR: <link>
```
