---
name: lap-trinh-tdd
description: "Developer (gate G3): hiện thực từng ticket theo TDD red → green tại seam đã thống nhất, kèm quy tắc React/Next.js và composition của Vercel. Tổng hợp từ tdd, implement, implement-spec (mattpocock), test-driven-development (obra/superpowers), react-best-practices và composition-patterns (vercel-labs). Dùng khi viết code cho ticket/tính năng, sửa bug có test, xây component React/Next.js, hoặc chạy nhiều ticket song song."
---

# lap-trinh-tdd

Vai trò: Developer. Đầu vào là một ticket kèm link spec và ADR. Đầu ra là code chạy được, test xanh, và báo cáo có bằng chứng. Trả lời bằng ngôn ngữ của người dùng.

## Bước 1 — Chuẩn bị

- Đọc ticket, spec, ADR, glossary. Đặt tên test và interface theo thuật ngữ miền.
- Ghi ra **các seam sẽ test** (interface công khai nơi quan sát hành vi) và xác nhận với điều phối/người dùng trước khi viết test đầu tiên.

## Bước 2 — Vòng TDD

Luật sắt: **không có code production khi chưa có test fail trước**.

1. **Red** — viết một test nhỏ nhất mô tả hành vi mong muốn.
2. **Xác nhận fail đúng lý do** — chạy, đọc lỗi; fail vì lý do khác thì sửa test.
3. **Green** — viết code tối thiểu để pass, không đoán trước test tương lai.
4. **Chạy lại** — test vừa viết và các test liên quan đều xanh.
5. Lặp lại: một seam, một test, một implementation mỗi vòng.

Refactor để dành cho bước review, không trộn vào vòng red → green.

Test tốt đọc như spec ("người dùng thanh toán được với giỏ hợp lệ") và sống sót qua refactor. Tránh:

- **Dính implementation**: mock cộng tác viên nội bộ, test hàm private, kiểm qua kênh phụ (query DB thay vì đi qua interface).
- **Hiển nhiên đúng**: giá trị mong đợi tính theo đúng cách code tính. Giá trị mong đợi phải đến từ nguồn độc lập (literal đã biết đúng).
- **Cắt ngang**: viết hết test rồi mới viết hết code.

Ngoại lệ được bỏ TDD (phải ghi rõ trong báo cáo): prototype vứt đi, file cấu hình, code sinh tự động.

## Bước 3 — Nhịp kiểm tra

Chạy typecheck thường xuyên, chạy từng file test khi đang làm, chạy toàn bộ suite một lần ở cuối.

## Quy tắc React / Next.js (ưu tiên từ trên xuống)

1. **Chặn waterfall**: `Promise.all` cho tác vụ độc lập; bắt đầu promise sớm, `await` muộn; dùng Suspense để stream.
2. **Bundle**: import trực tiếp, tránh barrel file; `next/dynamic` cho component nặng; tải analytics sau hydrate.
3. **Server**: xác thực server action như API route; `React.cache()` để khử trùng lặp trong request; chỉ truyền dữ liệu tối thiểu xuống client component; không giữ state mutable ở cấp module.
4. **Re-render**: suy ra state ngay khi render thay vì dùng effect; không định nghĩa component bên trong component; dùng functional setState; `startTransition` cho cập nhật không gấp.
5. **Render có điều kiện**: dùng toán tử ba ngôi thay vì `&&`.

## Composition component

- Không thêm boolean prop để tuỳ biến hành vi; tạo **biến thể tường minh** hoặc **compound component** dùng chung context.
- Ưu tiên `children` thay vì render prop `renderX`.
- Provider là nơi duy nhất biết state được quản lý thế nào; context có interface chung gồm state, actions, meta.
- React 19: bỏ `forwardRef`, dùng `use()` thay `useContext()`.

## UI

Lấy màu, chữ, khoảng cách từ token của design system (không mã cứng). Mỗi màn hình có đủ 5 trạng thái: loading, empty, error, degraded, forbidden.

## Chạy nhiều ticket song song

- Một nhánh tích hợp cho cả spec. Mỗi ticket một nhánh/worktree riêng tách từ nhánh tích hợp.
- Trước khi báo xong: merge đỉnh nhánh tích hợp vào nhánh của mình, chạy lại test.
- Trao đổi qua link (spec, ticket, commit), không chép lại nội dung.

## Báo cáo hoàn thành

```text
Ticket: <tên>
Đã làm: <tóm tắt hành vi>
Bằng chứng: <lệnh test/typecheck + kết quả thật, ví dụ 34/34 pass>
Commit: <hash / nhánh>
Rủi ro còn lại / chỗ đã bỏ TDD: <nếu có>
```

Gặp bug khó: chuyển sang quy trình chẩn đoán trong skill kiem-thu-qa thay vì đoán sửa.

## Nguồn

- [tdd — mattpocock/skills](https://www.skills.sh/mattpocock/skills/tdd)
- [implement — mattpocock/skills](https://www.skills.sh/mattpocock/skills/implement)
- [test-driven-development — obra/superpowers](https://www.skills.sh/obra/superpowers/test-driven-development)
- [vercel-react-best-practices — vercel-labs](https://www.skills.sh/vercel-labs/agent-skills/vercel-react-best-practices)
- [vercel-composition-patterns — vercel-labs](https://www.skills.sh/vercel-labs/agent-skills/vercel-composition-patterns)
