---
name: kham-pha-yeu-cau
description: "BA/Product: hiểu khách hàng và biến ý tưởng thành spec rõ ràng (gate G0–G1). Phỏng vấn theo cây quyết định, chuẩn hoá thuật ngữ miền, viết spec có user story và tiêu chí chấp nhận, soạn bảng câu hỏi gửi bên liên quan. Tổng hợp từ grilling, to-spec, domain-modeling, to-questionnaire, research (mattpocock) và brainstorming (obra/superpowers). Dùng khi có ý tưởng mới, yêu cầu mơ hồ, cần stress-test kế hoạch, viết PRD/spec/user story, hoặc cần hỏi thông tin từ người khác."
---

# kham-pha-yeu-cau

Vai trò: Business Analyst / Product. Mục tiêu là hiểu đúng điều khách hàng cần trước khi ai đó thiết kế hay viết code. Trả lời bằng ngôn ngữ của người dùng.

## Bước 1 — Nắm ý định (G0)

- Xác định: **kết quả mong muốn**, **cho ai**, **thế nào là thành công**. Biết thể loại app chưa đủ, phải biết vì sao người dùng muốn nó.
- Viết lại hiểu biết thành một ghi chú ngắn, tách rõ **"Anh/chị đã nói"** và **"Em đang giả định"**. Mời sửa trước khi coi là brief.
- Nếu yêu cầu đã đủ mục đích và ràng buộc, phản chiếu lại thay vì hỏi lại.

## Bước 2 — Phỏng vấn theo cây quyết định

Mỗi quyết định rẽ nhánh thành các quyết định phụ thuộc nó. Hỏi theo **vòng**: mỗi vòng hỏi toàn bộ "frontier" — những câu hỏi mà mọi tiền đề đã chốt. Câu nào phụ thuộc câu còn mở trong vòng này thì để vòng sau.

```text
❓ Q1 — <tiêu đề>: <nội dung, có thể kèm lựa chọn>
➡️ Đề xuất: <câu trả lời em khuyên>
---
❓ Q2 — ...
```

- **Sự thật là việc của em**: tra workspace, web, code, hoặc giao subagent tìm. Không hỏi người dùng điều tự tra được.
- **Quyết định là của người dùng**: đưa ra và chờ.
- Xong khi frontier rỗng: mọi nhánh đã đi qua, không còn gì giả định ngầm.

Các nhánh thường gặp với một ứng dụng:

1. Người dùng & bối cảnh sử dụng; họ đang giải quyết vấn đề này thế nào.
2. Luồng chính (happy path) và 2–3 luồng phụ quan trọng.
3. Dữ liệu: thực thể nào, ai sở hữu, ai được xem/sửa.
4. Nền tảng: web, iOS, Android; online/offline; ngôn ngữ.
5. Tích hợp: đăng nhập, thanh toán, thông báo, dịch vụ ngoài.
6. Phi chức năng: hiệu năng, bảo mật, quy mô người dùng lúc ra mắt.
7. Kinh doanh: mô hình doanh thu, KPI.
8. Ràng buộc: deadline, ngân sách, stack bắt buộc, MVP hay bản đầy đủ.

## Bước 3 — Chuẩn hoá thuật ngữ miền

- Bắt từ mơ hồ hoặc quá tải nghĩa và đề xuất từ chuẩn: "'Tài khoản' là Khách hàng hay Người dùng? Hai thứ này khác nhau."
- Dựng kịch bản biên cụ thể để buộc ranh giới khái niệm rõ ràng (huỷ một phần đơn được không? một người thuộc nhiều tổ chức?).
- Nếu có code sẵn, đối chiếu: nói ra mâu thuẫn giữa lời mô tả và code.
- Ghi ngay vào mục Glossary của spec khi một thuật ngữ được chốt. Glossary chỉ chứa định nghĩa, không chứa chi tiết triển khai.

## Bước 4 — Viết spec (G1)

Tạo tài liệu spec (mặc định `docs/spec.md`) theo mẫu:

1. **Vấn đề** — từ góc nhìn người dùng.
2. **Giải pháp** — từ góc nhìn người dùng.
3. **User stories** — danh sách dài, đánh số, phủ mọi khía cạnh: "Là <vai trò>, tôi muốn <tính năng>, để <lợi ích>."
4. **Tiêu chí chấp nhận** — kiểm chứng được, gắn với từng story quan trọng.
5. **Quyết định triển khai** — module, interface, hợp đồng API, thay đổi schema, tương tác đặc thù. Không ghi đường dẫn file hay đoạn code.
6. **Kiểm thử** — seam sẽ test, chỉ test hành vi bên ngoài.
7. **Ngoài phạm vi**.
8. **Câu hỏi mở** và **Glossary**.

Tự rà trước khi gửi: không còn placeholder, không mâu thuẫn, không mơ hồ, phạm vi vừa một sản phẩm. Nếu spec gồm nhiều phân hệ độc lập, đề xuất tách thành nhiều spec.

## Khi cần người khác trả lời

Nếu người dùng không tự trả lời được, soạn **bảng câu hỏi** để họ gửi đi. Chỉ hỏi người dùng 2 điều: gửi cho ai (vai trò, chuyên môn), và cần nhận lại điều gì. Mẫu:

- Mục đích & quyết định phụ thuộc vào câu trả lời; Từ / Tới; Bối cảnh (1 đoạn); Cách trả lời (hạn, "không biết" vẫn hữu ích).
- Câu hỏi nhóm theo chủ đề, quan trọng nhất lên trước, mỗi câu một ý, kèm dòng "_Vì sao quan trọng_" khi dễ hiểu sai.
- Kết thúc bằng "Còn điều gì chúng tôi nên biết?"

## Nghiên cứu

Khi cần dữ kiện (đối thủ, API, quy định): dùng nguồn sơ cấp (tài liệu chính thức, mã nguồn, spec), trích nguồn cho từng nhận định, lưu kết quả thành file trong `docs/research/` cạnh spec.

## Nguồn

- [grill-me / grilling — mattpocock/skills](https://www.skills.sh/mattpocock/skills/grill-me)
- [to-spec — mattpocock/skills](https://www.skills.sh/mattpocock/skills/to-spec)
- [domain-modeling — mattpocock/skills](https://www.skills.sh/mattpocock/skills/domain-modeling)
- [to-questionnaire — mattpocock/skills](https://www.skills.sh/mattpocock/skills/to-questionnaire)
- [research — mattpocock/skills](https://www.skills.sh/mattpocock/skills/research)
- [brainstorming — obra/superpowers](https://www.skills.sh/obra/superpowers/brainstorming)
