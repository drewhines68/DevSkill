---
name: thiet-ke-ui-ung-dung
description: "Thiết kế UI ứng dụng (mobile/web app) từ ý tưởng đến màn hình hoàn chỉnh theo quy trình 4 bước: định hướng thẩm mỹ → thiết kế → kiểm tra theo chuẩn → review & hoàn thiện. Tổng hợp từ frontend-design (Anthropic), web-design-guidelines (Vercel), critique & polish (impeccable), design-taste-frontend (leonxlnx) và emil-design-eng (Emil Kowalski). Dùng khi người dùng muốn: thiết kế giao diện/màn hình app, dựng design system (màu, font, spacing), thiết kế chuyển động, tạo prototype HTML, vẽ user flow trên FigJam, review/nhận xét một UI có sẵn (ảnh chụp, link, code), hoặc hoàn thiện UI trước khi bàn giao."
---

# thiet-ke-ui-ung-dung

Skill thiết kế UI ứng dụng, gộp 4 skill: **frontend-design** (định hướng thẩm mỹ), **web-design-guidelines** (chuẩn giao diện), **critique** (đánh giá), **polish** (hoàn thiện). Trả lời bằng ngôn ngữ của người dùng.

## Đầu vào cần có

- **Sản phẩm:** app làm gì, lĩnh vực nào.
- **Người dùng:** ai dùng, trong bối cảnh nào.
- **Nền tảng:** iOS, Android, web app hay đa nền tảng.
- **Phạm vi:** những màn hình / luồng cần thiết kế.
- **Ràng buộc (nếu có):** thương hiệu, màu logo, design system sẵn có, ảnh tham khảo.

Nếu thiếu, tự đề xuất một giả định cụ thể (sản phẩm, người dùng, nhiệm vụ chính của màn hình) rồi xin xác nhận trong một câu hỏi ngắn trước khi thiết kế. Nếu người dùng chỉ đưa UI có sẵn để review, bỏ qua Bước 1–2, đi thẳng Bước 3–4.

## Bước 1 — Định hướng thẩm mỹ

Đóng vai design lead của một studio nổi tiếng vì mỗi khách hàng có bản sắc riêng. Khách đã từ chối các phương án rập khuôn, nên phải có quan điểm rõ ràng.

- Lấy chất liệu thị giác từ chính lĩnh vực sản phẩm: ngành nghề, vật liệu, ngôn ngữ, văn hoá người dùng. App đồ chơi cho bé gái 8–11 tuổi phải khác hẳn dashboard cho chuyên viên tài chính.
- Đề xuất **2–3 hướng thẩm mỹ** (ví dụ: tối giản tinh tế, editorial, retro-futuristic, organic, brutalist, luxury), mỗi hướng gồm: tên, cảm xúc mục tiêu, bảng màu, cặp font, 1 câu lý do. Đề xuất một hướng mặc định.
- Tránh dấu hiệu "AI slop": gradient tím-xanh mặc định, glassmorphism tràn lan, font Inter/Roboto chỉ vì quen, bố cục card lặp lại vô hồn, hero "số lớn + nhãn nhỏ + gradient" khi không thật sự phù hợp.
- Trước khi thiết kế, viết một dòng **Design read** (đọc brief: loại sản phẩm, đối tượng, cảm xúc) rồi đặt **3 núm chỉnh** thang 1–10: **Biến tấu** (đối xứng ↔ phá cách), **Chuyển động** (tĩnh ↔ điện ảnh), **Mật độ** (thoáng ↔ dày dữ liệu). Gợi ý: tối giản/editorial 5/3/2 · cao cấp/thương hiệu 7/6/3 · landing SaaS 7/6/4 · dịch vụ công/cần tin cậy 3/2/5 · dashboard/công cụ nội bộ 4/3/7. Brief mơ hồ thì hỏi đúng một câu, không đoán.

## Bước 2 — Thiết kế

### 2.1 Design system tối thiểu

- **Màu:** primary, secondary, nền, bề mặt, chữ (3 cấp), trạng thái (success / warning / error / info). Ghi mã HEX và đảm bảo tương phản chữ/nền ≥ 4.5:1 (chữ lớn ≥ 3:1). Có biến thể dark mode nếu phù hợp.
- **Typography:** 1–2 họ font chọn có chủ đích (nếu 2 thì phải khác biệt rõ). Thang cỡ chữ rõ ràng (ví dụ 12/14/16/20/24/32), weight và line-height cho từng cấp. Dòng chữ ≤ 80 ký tự; serif cần line-height lớn hơn sans.
- **Spacing & layout:** thang 4 hoặc 8pt, lưới, bo góc, độ đổ bóng.
- **Component cốt lõi:** button (primary/secondary/ghost, đủ trạng thái default/hover/pressed/focus/disabled/loading), input, card, list item, navigation (tab bar / sidebar), modal/bottom sheet, toast, empty state.

### 2.2 Màn hình

Với mỗi màn hình, mô tả:

1. **Mục tiêu:** hành động chính người dùng cần làm.
2. **Cấu trúc:** các vùng từ trên xuống, thứ bậc thị giác (cái gì nổi nhất).
3. **Nội dung thật:** dùng nội dung đúng lĩnh vực, không dùng lorem ipsum.
4. **Trạng thái:** loading, rỗng, lỗi, thành công, nội dung rất dài/rất ngắn.
5. **Tương tác & chuyển động:** phản hồi khi chạm, chuyển màn, micro-interaction có mục đích.

Mobile: vùng chạm ≥ 44×44pt, hành động chính trong tầm ngón cái, tôn trọng safe area (tai thỏ, thanh home).

### 2.3 Xuất bản (chọn theo yêu cầu)

- **Tài liệu thiết kế:** `docs/design.md` (hoặc trang Notion) gồm design system + từng màn hình (mặc định).
- **Prototype HTML:** dựng file HTML/CSS tĩnh, khung điện thoại 390×844 cho mobile. Dùng CSS variables cho token. Chụp ảnh màn hình bằng Chromium headless để tự kiểm tra trước khi gửi.
- **FigJam / sơ đồ:** nếu có công cụ Figma/FigJam thì vẽ user flow / sitemap; nếu không, dùng Mermaid trong tài liệu. Chỉ hứa vẽ màn hình trên canvas khi công cụ thật sự hỗ trợ.

### 2.4 Chuyển động

Trước khi thêm animation, trả lời theo thứ tự:

1. **Có nên animate không?** Thao tác lặp 100+ lần/ngày (phím tắt, command palette): không animate. Hàng chục lần/ngày (hover, điều hướng list): giảm tối đa. Thỉnh thoảng (modal, drawer, toast): chuẩn. Hiếm/lần đầu (onboarding, ăn mừng): được thêm điểm nhấn. Không animate thao tác bàn phím.
2. **Mục đích là gì?** Nhất quán không gian, báo trạng thái, giải thích, phản hồi khi nhấn, tránh xuất hiện đột ngột. "Trông hay" mà lặp nhiều thì bỏ.
3. **Easing:** vào/ra màn hình → ease-out; di chuyển trên màn hình → ease-in-out; đổi màu/hover → ease; liên tục → linear. Không dùng ease-in cho UI. Dùng đường cong mạnh, ví dụ `cubic-bezier(0.23, 1, 0.32, 1)`.
4. **Thời lượng:** phản hồi nhấn, tooltip ~100–200ms; dropdown, popover ~150–250ms; modal, drawer ~200–400ms.

Chi tiết hoàn thiện: nút co nhẹ khi nhấn (scale ~0.97); không animate từ `scale(0)`; popover mở từ phía nút gốc (transform-origin); tooltip bỏ delay ở lần hover kế tiếp; ưu tiên CSS transition (ngắt được giữa chừng) hơn keyframes.

### 2.5 Luật bố cục cho landing page

- Hero nằm gọn trong màn hình đầu: tiêu đề ≤ 2 dòng, mô tả ≤ 20 từ, CTA thấy ngay không cần cuộn; tối đa 4 phần tử chữ (eyebrow · tiêu đề · mô tả · CTA).
- Logo "Được tin dùng bởi" đặt ngay dưới hero, không nhét vào hero.
- Thanh điều hướng một dòng trên desktop, cao 64–72px (tối đa 80px).
- Mỗi kiểu bố cục section chỉ dùng một lần mỗi trang; tối đa 2 section ảnh–chữ so le liên tiếp; tối đa 1 eyebrow mỗi 3 section.
- Bento grid có đúng số ô bằng số nội dung, không để ô trống.

## Bước 3 — Kiểm tra theo chuẩn

Rà từng mục; chỉ báo mục không đạt, kèm vị trí và cách sửa.

- **Tiếp cận (accessibility):** tương phản đủ; nút chỉ có icon phải có nhãn; mọi ô nhập có label; ảnh có mô tả; thứ bậc heading hợp lý; không chỉ dùng màu để truyền tải thông tin.
- **Focus & tương tác:** có trạng thái focus nhìn thấy được; hover/pressed nổi hơn trạng thái nghỉ; header/footer dính không che phần tử đang focus.
- **Form:** đúng loại bàn phím (email, số, điện thoại); không chặn dán; lỗi hiển thị ngay cạnh ô và kèm cách khắc phục; nút gửi hiển thị loading khi đang xử lý; cảnh báo khi rời trang còn thay đổi chưa lưu.
- **Chuyển động:** có phương án giảm chuyển động (reduced motion); animation ngắt được giữa chừng; chỉ animate transform/opacity.
- **Typography:** dùng `…` thay `...`; trạng thái loading kết thúc bằng `…` ("Đang tải…"); số trong bảng dùng chữ số đều (tabular); tiêu đề không để chữ mồ côi.
- **Nội dung:** xử lý chữ dài (cắt, xuống dòng); có empty state; lường trước dữ liệu người dùng ngắn/trung bình/rất dài.
- **Điều hướng & trạng thái:** hành động phá huỷ (xoá…) phải có xác nhận hoặc hoàn tác; trạng thái lọc/tab có thể chia sẻ bằng link (web).
- **Chạm & cử chỉ:** mọi cử chỉ vuốt/kéo đều có phương án chạm hoặc bàn phím thay thế; modal/sheet không cuộn xuyên nền.
- **Theme & bản địa hoá:** dark mode đồng bộ (cả thanh cuộn, ô nhập); ngày, số, tiền tệ định dạng theo locale (vi-VN: 1.000.000 ₫, 30/09/2026).
- **Câu chữ:** giọng chủ động; nhãn nút cụ thể ("Lưu thay đổi" thay vì "Tiếp tục"); thông báo lỗi nêu cách sửa; dùng chữ số cho số đếm.

## Bước 4 — Review & hoàn thiện

### Critique

Chấm 1–5 trên 10 chiều: thứ bậc thị giác, kiến trúc thông tin, cảm xúc/bản sắc, khả năng khám phá, bố cục, typography, chiến lược màu, xử lý trạng thái, microcopy, affordance (nhìn là biết tương tác được). Kết luận có hay không dấu hiệu "AI slop". Liệt kê vấn đề theo mức ưu tiên (Cao / Trung bình / Thấp), mỗi vấn đề kèm cách sửa cụ thể, và 2–3 câu hỏi gợi mở để thiết kế tốt hơn.

### Polish

Hỏi mức chất lượng: **MVP** (sửa mục Cao) hay **flagship** (sửa tất cả). Sau đó rà lần cuối: căn lề và khoảng cách đúng thang, typography nhất quán, màu lấy từ token thay vì mã cứng, component không bị nhân bản, đủ trạng thái tương tác, chuyển động mượt, responsive ở các kích thước màn hình.

## Định dạng đầu ra

Mặc định tạo **một tài liệu thiết kế** (`docs/design.md` hoặc trang Notion) gồm:

1. Tóm tắt brief (sản phẩm, người dùng, nền tảng).
2. Hướng thẩm mỹ đã chọn và lý do.
3. Design system (bảng màu, typography, spacing, component).
4. Spec từng màn hình.
5. Kết quả kiểm tra (Bước 3) và critique (Bước 4).
6. Link/ảnh prototype hoặc sơ đồ FigJam nếu có.

Khi chỉ review UI có sẵn: trả lời trong chat bằng bảng điểm 10 chiều, danh sách vấn đề theo ưu tiên và checklist mục không đạt.

## Nguồn

- [frontend-design — Anthropic](https://www.skills.sh/anthropics/skills/frontend-design)
- [web-design-guidelines — Vercel](https://www.skills.sh/vercel-labs/agent-skills/web-design-guidelines)
- [critique — impeccable](https://www.skills.sh/pbakaus/impeccable/critique)
- [polish — impeccable](https://www.skills.sh/pbakaus/impeccable/polish)
- [design-taste-frontend — leonxlnx/taste-skill](https://www.skills.sh/leonxlnx/taste-skill/design-taste-frontend)
- [emil-design-eng — Emil Kowalski](https://www.skills.sh/emilkowalski/skills/emil-design-eng)
