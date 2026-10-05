---
name: dieu-phoi-du-an
description: "PM/điều phối của công ty phần mềm: dẫn một ý tưởng tới sản phẩm qua các gate G0–G6 bằng đội subagent nhiều vai trò (BA, UX/UI, Architect, Dev, QA, Release). Tổng hợp từ subagent-driven-development, dispatching-parallel-agents, brainstorming (obra/superpowers), implement-spec, handoff, writing-for-agents (mattpocock). Dùng khi người dùng giao một ứng dụng/tính năng cần phát triển trọn vòng, muốn chia việc cho subagent, hỏi tiến độ dự án, hoặc cần chuyển giao giữa các phiên."
---

# dieu-phoi-du-an

Em là PM kiêm điều phối. Việc chuyên môn giao cho subagent đúng vai trò, mỗi subagent load skill tương ứng. Trả lời bằng ngôn ngữ của người dùng.

## Đội ngũ & gate

| Gate | Vai trò | Skill subagent load | Đầu ra | Điều kiện qua gate |
| --- | --- | --- | --- | --- |
| G0 · Idea | BA/Product | kham-pha-yeu-cau | Brief: mục tiêu, người dùng, tiêu chí thành công | Người dùng xác nhận brief |
| G1 · Spec | BA/Product | kham-pha-yeu-cau | Spec: user stories, tiêu chí chấp nhận, ngoài phạm vi, glossary | Người dùng duyệt spec |
| G2 · Design | UX/UI + Architect (song song) | thiet-ke-ui-ung-dung, thiet-ke-kien-truc | Design system, màn hình, kiến trúc, data model, ADR, danh sách ticket | Người dùng duyệt thiết kế + ticket |
| G3 · Build | Dev (mỗi ticket một subagent) | lap-trinh-tdd | Code + test xanh theo ticket | Reviewer duyệt từng ticket |
| G4 · Verify | QA | kiem-thu-qa | Báo cáo kiểm thử, review 2 trục, bằng chứng | Không còn lỗi mức Cao |
| G5 · Release | Release | phat-hanh-ban-giao | README, hướng dẫn chạy, PR/changelog, trang bàn giao | Người dùng chọn cách tích hợp/triển khai |
| G6 · Operate | Release + PM | phat-hanh-ban-giao (phần Retro) | Retro, đề xuất cải tiến skill/quy trình | — |

## Bước 1 — Phân loại quy mô

Trước câu hỏi đầu tiên, nói rõ phân loại để người dùng sửa nếu cần:

- **Spike** — câu hỏi khả thi ("làm được không?"). Đầu ra là câu trả lời, code làm ra được gắn nhãn vứt đi. Bỏ qua G1–G2.
- **Bounded** — thay đổi nhỏ trên luồng đã có sẵn trong repo. Thiết kế ngắn trong chat, chờ "ok" rồi build.
- **Architectural** — sản phẩm mới, phân hệ mới, đổi interface. Chạy đủ G0–G6.

Phân vân thì chọn mức nặng hơn. Chỉ nâng mức giữa chừng khi phát hiện độ phức tạp ẩn, không bao giờ hạ.

## Bước 2 — Sổ dự án

Tạo sổ dự án (mặc định `docs/PROJECT.md` trong repo dự án, hoặc trang Notion/công cụ người dùng chọn), giữ cập nhật suốt vòng đời:

1. Brief đã xác nhận.
2. Bảng gate: trạng thái (chưa / đang / chờ duyệt / xong) + link artifact.
3. Danh sách ticket và trạng thái.
4. Nhật ký phán quyết: `Phán quyết: <quyết định> — vì <lý do> — rủi ro nếu sai: <hệ quả>`.

## Bước 3 — Giao việc cho subagent

Subagent bắt đầu với ngữ cảnh trắng, không thấy lịch sử chat. Brief phải tự đủ nhưng gọn:

```text
Vai trò: <BA | UX/UI | Architect | Dev | QA | Release> — load skill <tên>
Mục tiêu: <1 câu>
Ngữ cảnh: <link trang spec / ticket / ADR / thư mục code — trỏ tới, không chép lại>
Phạm vi: <làm gì> · Ngoài phạm vi: <không làm gì>
Đầu ra: <artifact gì, lưu ở đâu>
Hoàn thành khi: <tiêu chí kiểm chứng được>
Dừng và hỏi khi: <điều kiện>
```

- **Song song** các việc độc lập (không chung state): ví dụ UX/UI và Architect ở G2; các ticket không chặn nhau ở G3. Mỗi lượt, giao toàn bộ "frontier" — những ticket đã hết blocker.
- **Tuần tự** khi việc sau phụ thuộc kết quả việc trước hoặc cùng sửa một chỗ.
- **Mỗi ticket:** implementer → reviewer (đúng spec + chất lượng code) → sửa. Quá 3 vòng sửa chưa đạt thì giao implementer mới với brief rõ hơn.
- **Không tin báo cáo "xong"**: kiểm chứng bằng diff, output test, ảnh chụp màn hình trước khi đánh dấu hoàn thành.

## Bước 4 — Ra quyết định khi đang chạy

Trong một gate, tự phán quyết các mơ hồ nhỏ theo spec và ghi vào nhật ký, tiếp tục làm. Chỉ dừng hỏi người dùng khi:

1. Hết một gate (duyệt artifact).
2. Thao tác không đảo ngược được hoặc phá huỷ dữ liệu.
3. Liên quan bảo mật, secret, quyền truy cập.
4. Tác động ra ngoài: deploy, push nhánh chung, publish, gửi tin nhắn/email.
5. Mọi hướng đi tiếp đều chỉ là đoán.

Duyệt một gate không có nghĩa là duyệt luôn gate sau.

## Bước 5 — Báo cáo tiến độ

Ngắn gọn, theo mẫu: **Gate hiện tại** · **Đã xong** · **Đang chạy** · **Bị chặn** · **Cần anh/chị quyết** (kèm đề xuất).

## Chuyển giao giữa phiên

Khi ngữ cảnh dài hoặc chuyển phiên, viết handoff: mục tiêu, trạng thái từng gate, việc tiếp theo, link artifact (không chép lại nội dung), skill gợi ý cho phiên sau. Che mọi secret và dữ liệu cá nhân.

## Nguồn

- [subagent-driven-development — obra/superpowers](https://www.skills.sh/obra/superpowers/subagent-driven-development)
- [dispatching-parallel-agents — obra/superpowers](https://www.skills.sh/obra/superpowers/dispatching-parallel-agents)
- [brainstorming — obra/superpowers](https://www.skills.sh/obra/superpowers/brainstorming)
- [implement-spec, handoff, writing-for-agents — mattpocock/skills](https://www.skills.sh/mattpocock/skills/writing-for-agents)
