# DevSkill

Bộ skill tiếng Việt biến AI agent thành **công ty phát triển phần mềm từ ý tưởng tới sản phẩm**: hiểu khách hàng, thiết kế, lập trình, kiểm thử, phát hành — mỗi việc do một subagent đúng vai trò đảm nhận, đi qua các gate G0–G6 có duyệt.

Skill được tổng hợp và Việt hoá từ các skill nổi bật trên [skills.sh](https://www.skills.sh/) (mattpocock/skills, obra/superpowers, anthropics/skills, vercel-labs/agent-skills, supabase, impeccable, taste-skill, emilkowalski). Nguồn chi tiết ở cuối mỗi `SKILL.md` và trong `sources.json`.

## Dùng ngay

Đưa cho AI câu sau:

> Đây là bộ skill của tôi: https://github.com/drewhines68/DevSkill — đọc `AGENTS.md` và làm theo. Tôi muốn làm ứng dụng: <mô tả ý tưởng>.

AI sẽ tự nhận vai PM, gán vai trò cho subagent, và bắt đầu từ G0.

## Cài theo công cụ

| Công cụ | Cách cài |
| --- | --- |
| Claude Code, Cursor, Codex, Copilot… | `npx skills add drewhines68/DevSkill` hoặc clone repo vào dự án; `AGENTS.md` / `CLAUDE.md` được đọc tự động |
| Claude Code (thủ công) | copy `skills/*` vào `~/.claude/skills/` hoặc `.claude/skills/` của dự án |
| Notion AI | tạo mỗi skill thành một trang Skill (nội dung = `SKILL.md`) |
| ChatGPT / chat khác | dán link repo hoặc raw URL của `AGENTS.md` |

## Vai trò & skill

| Gate | Vai trò | Skill |
| --- | --- | --- |
| G0–G6 | 🧭 PM / Điều phối | [dieu-phoi-du-an](skills/dieu-phoi-du-an/SKILL.md) |
| G0–G1 | 🔍 BA / Product | [kham-pha-yeu-cau](skills/kham-pha-yeu-cau/SKILL.md) |
| G2 | 🎨 UX/UI Designer | [thiet-ke-ui-ung-dung](skills/thiet-ke-ui-ung-dung/SKILL.md) |
| G2 | 🏗️ Architect | [thiet-ke-kien-truc](skills/thiet-ke-kien-truc/SKILL.md) |
| G3 | 💻 Developer | [lap-trinh-tdd](skills/lap-trinh-tdd/SKILL.md) |
| G4 | 🧪 QA / Reviewer | [kiem-thu-qa](skills/kiem-thu-qa/SKILL.md) |
| G5–G6 | 🚀 Release / Docs | [phat-hanh-ban-giao](skills/phat-hanh-ban-giao/SKILL.md) |
| — | 🔄 Bảo trì skill | [cap-nhat-skill](skills/cap-nhat-skill/SKILL.md) |

## Cập nhật skill

```bash
bash scripts/check-upstream.sh      # skill gốc nào đã thay đổi?
```

Hoặc bảo AI: *"Cập nhật bộ skill DevSkill"* — AI sẽ dùng skill `cap-nhat-skill` để nghiên cứu, sửa, ghi CHANGELOG và commit.

## Cấu trúc

```text
AGENTS.md            # điểm vào cho mọi AI agent
CLAUDE.md            # trỏ tới AGENTS.md
skills/<tên>/SKILL.md
sources.json         # nguồn gốc + SHA của skill gốc
scripts/check-upstream.sh
CHANGELOG.md
```
