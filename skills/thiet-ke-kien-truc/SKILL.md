---
name: thiet-ke-kien-truc
description: "Architect (gate G2): từ spec đã duyệt, chọn stack, thiết kế module sâu và seam, data model Postgres, hợp đồng API, ADR, rồi chia việc thành ticket tracer-bullet có quan hệ chặn. Tổng hợp từ codebase-design, improve-codebase-architecture, to-tickets, domain-modeling (mattpocock), writing-plans (obra/superpowers), supabase-postgres-best-practices (Supabase). Dùng khi cần thiết kế kiến trúc, schema, API, viết ADR, lập kế hoạch triển khai, chia ticket, hoặc rà kiến trúc codebase có sẵn."
---

# thiet-ke-kien-truc

Vai trò: Kiến trúc sư phần mềm. Đầu vào là spec G1 đã duyệt. Đầu ra là tài liệu kiến trúc (`docs/architecture.md`), ADR trong `docs/adr/` (nếu cần) và danh sách ticket sẵn sàng cho Dev. Trả lời bằng ngôn ngữ của người dùng.

## Bước 1 — Chọn hướng kỹ thuật

- Tôn trọng ràng buộc của người dùng (stack, hạ tầng, ngân sách). Nếu còn tự do, nêu 2–3 phương án kèm trade-off và một đề xuất.
- Ghi "Ràng buộc toàn cục": phiên bản tối thiểu, giới hạn thư viện, quy tắc đặt tên, yêu cầu nền tảng — mỗi dòng một giá trị chính xác.

## Bước 2 — Thiết kế module sâu

Dùng đúng từ vựng sau (không thay bằng "component", "service", "boundary"):

- **Module**: bất cứ thứ gì có interface và implementation, ở mọi cấp.
- **Interface**: mọi điều caller phải biết — kiểu, bất biến, thứ tự gọi, lỗi, cấu hình, hiệu năng.
- **Depth**: nhiều hành vi sau một interface nhỏ. Module **sâu** thì tốt, module **nông** (interface gần bằng implementation) thì tránh.
- **Seam**: vị trí interface sống, nơi đổi hành vi mà không sửa tại chỗ. **Adapter**: thứ cụ thể lắp vào seam.
- **Leverage** (caller được nhiều hơn) và **Locality** (sửa một chỗ, đúng mọi nơi).

Nguyên tắc:

- **Phép thử xoá**: tưởng tượng xoá module. Độ phức tạp biến mất → nó chỉ chuyển tiếp; phức tạp tràn ra N caller → nó đáng giữ.
- **Interface chính là bề mặt test**. Muốn test xuyên qua interface nghĩa là module sai hình dạng.
- **1 adapter = seam giả định, 2 adapter = seam thật**. Chỉ thêm seam khi thật sự có thứ thay đổi qua nó.
- Nhận dependency thay vì tự tạo; trả kết quả thay vì gây side effect.
- Với module cốt lõi, **thiết kế hai lần**: giao 2–3 subagent song song thiết kế interface theo hướng khác hẳn nhau, rồi so sánh về depth, locality, vị trí seam.

## Bước 3 — Data model & Postgres

Ưu tiên theo mức tác động:

1. **Truy vấn**: index cho cột lọc, join, khoá ngoại; partial index khi lọc theo điều kiện cố định; kiểm bằng `EXPLAIN`.
2. **Kết nối**: dùng connection pooling, giới hạn số kết nối.
3. **Bảo mật**: cô lập tenant (RLS hoặc lọc bắt buộc ở tầng truy cập), quyền tối thiểu, có test xác nhận chính sách.
4. **Schema**: kiểu đúng (`timestamptz`, `bigint identity`/`uuid`, `text`, `numeric` cho tiền), ràng buộc NOT NULL/UNIQUE/CHECK, migration rollback được.
5. **Đồng thời**: khoá lạc quan bằng cột revision cho bản ghi nhiều người sửa; transaction ngắn.

## Bước 4 — Hợp đồng API & bảo mật

- Mỗi endpoint: phương thức, đường dẫn, quyền/scope, request/response, mã lỗi, và **màn hình UI nào dùng nó** (không có API mồ côi).
- Ba câu hỏi bảo mật cố định: Tính năng có mở rộng thứ agent/người dùng chạm tới được không? Secret nào đi qua, sống bao lâu, ai thấy? Có vượt ranh giới tenant/tổ chức không?

## Bước 5 — ADR (dùng tiết kiệm)

Chỉ viết ADR khi đủ cả 3: **khó đảo ngược**, **gây bất ngờ nếu thiếu ngữ cảnh**, **là kết quả của trade-off thật**. Mẫu: Bối cảnh · Quyết định · Phương án đã loại và lý do · Hệ quả.

## Bước 6 — Chia ticket

- Mỗi ticket là một **lát cắt dọc (tracer bullet)**: đi xuyên mọi lớp (schema → API → UI → test), demo hoặc kiểm chứng được độc lập, vừa một context làm việc.
- Prefactor trước: "làm cho thay đổi trở nên dễ, rồi làm thay đổi dễ".
- Mỗi ticket khai báo **Bị chặn bởi**. Ticket không có blocker bắt đầu ngay.
- Refactor diện rộng (đổi tên cột, đổi kiểu dùng chung) không ép thành lát dọc: làm theo **expand–contract** — thêm dạng mới, chuyển dần, rồi bỏ dạng cũ.
- Mẫu ticket: Tiêu đề · Cần xây gì (hành vi đầu-cuối, góc nhìn người dùng) · Bị chặn bởi · Tiêu chí chấp nhận (checkbox). Không ghi đường dẫn file.
- Trình bày danh sách đánh số cho người dùng, hỏi: độ mịn đã hợp lý chưa? quan hệ chặn đúng chưa? cần gộp/tách ticket nào?

Kèm mục **Trọng tâm review**: 5 loại đầu vào hoặc tình huống dễ làm hỏng sản phẩm mà spec không nói tới (chuỗi rất dài, mất mạng, hai người sửa cùng lúc…), gán test cho ticket sở hữu.

## Khi rà kiến trúc codebase có sẵn

1. Tìm điểm nóng qua `git log` (file thay đổi nhiều gần đây) hoặc theo hướng người dùng chỉ định.
2. Đọc glossary và ADR liên quan trước.
3. Tìm ma sát: phải nhảy qua nhiều module nhỏ để hiểu một khái niệm, module nông, module rò rỉ qua seam, phần khó test.
4. Trình bày từng ứng viên: file liên quan · vấn đề · giải pháp · lợi ích (locality, leverage, test) · sơ đồ trước/sau · mức khuyến nghị (Mạnh / Đáng thử / Suy đoán). Kết thúc bằng một khuyến nghị ưu tiên.
5. Người dùng chọn ứng viên nào thì phỏng vấn theo cây quyết định (xem skill kham-pha-yeu-cau) trước khi đề xuất interface.

## Nguồn

- [codebase-design — mattpocock/skills](https://www.skills.sh/mattpocock/skills/codebase-design)
- [improve-codebase-architecture — mattpocock/skills](https://www.skills.sh/mattpocock/skills/improve-codebase-architecture)
- [to-tickets — mattpocock/skills](https://www.skills.sh/mattpocock/skills/to-tickets)
- [writing-plans — obra/superpowers](https://www.skills.sh/obra/superpowers/writing-plans)
- [supabase-postgres-best-practices — Supabase](https://www.skills.sh/supabase/agent-skills/supabase-postgres-best-practices)
