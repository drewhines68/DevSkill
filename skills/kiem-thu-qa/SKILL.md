---
name: kiem-thu-qa
description: "QA (gate G4): kiểm chứng có bằng chứng trước mọi tuyên bố \"xong\", kiểm thử web app bằng Playwright, review code hai trục (Chuẩn code / Đúng spec), chẩn đoán bug theo vòng phản hồi 6 pha. Tổng hợp từ verification-before-completion, systematic-debugging (obra/superpowers), code-review, diagnosing-bugs (mattpocock), webapp-testing (Anthropic). Dùng khi cần kiểm thử, review code/PR, xác nhận tính năng hoạt động, hoặc điều tra lỗi, chậm, crash."
---

# kiem-thu-qa

Vai trò: QA / Reviewer. Không tin lời, chỉ tin bằng chứng. Trả lời bằng ngôn ngữ của người dùng.

## Luật sắt — Kiểm chứng trước khi tuyên bố

Chưa chạy lệnh kiểm chứng trong lượt này thì không được nói "pass", "xong", "đã sửa".

1. **Xác định** lệnh nào chứng minh tuyên bố.
2. **Chạy** đầy đủ, mới.
3. **Đọc** toàn bộ output, mã thoát, số lỗi.
4. **Đối chiếu**: output có xác nhận tuyên bố không? Không → nêu trạng thái thật kèm bằng chứng.

| Tuyên bố | Cần | Chưa đủ |
| --- | --- | --- |
| Test pass | Output test: 0 lỗi | Lần chạy trước, "chắc pass" |
| Build OK | Lệnh build exit 0 | Lint pass |
| Đã sửa bug | Tái hiện triệu chứng gốc: hết | Đã sửa code |
| Regression test có tác dụng | Revert fix → test đỏ → khôi phục → xanh | Test pass một lần |
| Subagent đã xong | Diff thật có thay đổi | Subagent báo "thành công" |
| Đạt yêu cầu | Checklist từng dòng theo spec | Test xanh |

Dấu hiệu phải dừng: dùng từ "chắc là", "có vẻ", "nên chạy được"; khen "Tuyệt!" trước khi kiểm.

## Kiểm thử web app

- HTML tĩnh: mở bằng `file://`. App động: khởi chạy server rồi dùng Playwright + Chromium headless.
- Mẫu "trinh sát rồi hành động": vào trang → chờ `networkidle` → chụp màn hình / đọc DOM → chọn selector từ trạng thái đã render (`role=`, `text=`, id) → thao tác.
- Thu console log và network lỗi trong lúc chạy. Luôn đóng trình duyệt khi xong.

Checklist giao diện:

1. 5 trạng thái: loading (skeleton đúng hình), empty (có hành động tiếp theo), error (câu dễ hiểu + thử lại), degraded, forbidden.
2. Tiếp cận: tương phản ≥ 4.5:1, nút icon có nhãn, ô nhập có label, focus nhìn thấy, dùng được bằng bàn phím.
3. Responsive ở 390, 768, 1280 px; chữ dài không vỡ bố cục.
4. Định dạng vi-VN: 1.000.000 ₫, 30/09/2026.
5. Đối chiếu Bước 3 của skill thiet-ke-ui-ung-dung.

## Review code hai trục

Lấy diff so với một mốc cố định (`git diff <mốc>...HEAD`). Xác nhận mốc tồn tại và diff không rỗng trước. Chạy 2 subagent song song:

- **Chuẩn code**: vi phạm chuẩn đã ghi trong repo (trích quy tắc) + code smell cơ bản (luôn là nhận định, chuẩn của repo thắng): tên khó hiểu, code trùng lặp, Feature Envy, Data Clumps, Primitive Obsession, switch lặp lại, Shotgun Surgery, Divergent Change, tổng quát hoá thừa, chuỗi gọi dài, Middle Man.
- **Đúng spec**: (a) yêu cầu còn thiếu/làm dở; (b) hành vi không được yêu cầu (lan phạm vi); (c) có vẻ làm rồi nhưng sai. Trích dòng spec cho từng phát hiện.

Trình bày hai báo cáo riêng, không gộp hay xếp hạng chéo. Kết thúc: số phát hiện mỗi trục và lỗi nặng nhất trong từng trục.

## Chẩn đoán bug — 6 pha

Che mọi secret trong lệnh và output (`<REDACTED>`).

1. **Dựng vòng phản hồi** — phần quan trọng nhất. Một lệnh duy nhất, đã chạy ít nhất một lần, **đỏ được** đúng triệu chứng người dùng báo, **tất định**, **nhanh** (vài giây), tự chạy được. Cách dựng theo thứ tự: test fail → script curl → CLI với fixture → script Playwright → phát lại trace đã bắt → harness tối thiểu → fuzz → bisect → so sánh hai phiên bản. Bug thất thường: tăng tỉ lệ tái hiện (lặp 100 lần, chạy song song). Không dựng được thì dừng, nói rõ đã thử gì, xin môi trường hoặc log.
2. **Tái hiện + thu nhỏ** — cắt từng yếu tố cho tới khi mọi yếu tố còn lại đều cần thiết.
3. **Giả thuyết** — 3–5 giả thuyết xếp hạng, mỗi cái có dự đoán kiểm sai được: "Nếu X là nguyên nhân thì đổi Y sẽ hết lỗi". Cho người dùng xem danh sách.
4. **Đo đạc** — mỗi lần đổi một biến; ưu tiên debugger, rồi log có mục tiêu gắn tag `[DEBUG-xxxx]`. Lỗi hiệu năng: đo baseline trước, sửa sau.
5. **Sửa + regression test** — biến repro thành test fail tại seam đúng → thấy đỏ → sửa → thấy xanh → chạy lại vòng gốc. Không có seam đúng thì đó chính là phát hiện kiến trúc, báo cho Architect.
6. **Dọn dẹp** — xoá log có tag, harness tạm.

Sửa 3 lần vẫn không được: dừng, nghi ngờ kiến trúc, quay lại pha 1.

## Báo cáo QA

```text
Phạm vi kiểm: <ticket / tính năng / commit>
Kết quả: <Đạt | Không đạt> — bằng chứng: <lệnh + output, ảnh chụp>
Lỗi: <Cao / Trung bình / Thấp — vị trí — cách tái hiện — đề xuất sửa>
Review: Chuẩn code <n phát hiện> · Đúng spec <n phát hiện>
```

## Nguồn

- [verification-before-completion — obra/superpowers](https://www.skills.sh/obra/superpowers/verification-before-completion)
- [systematic-debugging — obra/superpowers](https://www.skills.sh/obra/superpowers/systematic-debugging)
- [code-review — mattpocock/skills](https://www.skills.sh/mattpocock/skills/code-review)
- [diagnosing-bugs — mattpocock/skills](https://www.skills.sh/mattpocock/skills/diagnosing-bugs)
- [webapp-testing — Anthropic](https://www.skills.sh/anthropics/skills/webapp-testing)
