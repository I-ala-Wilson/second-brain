# Module: school
Folder: `02-school/`

## Follow-up questions
- Institution, programme/major, year, and term dates (start, reading week, exam period).
- This term's courses: code, full name, instructor, and how each is graded (assignments, midterms, final, weights).
- Known test and assignment dates (all go into `deadlines.md`).
- Weakest and strongest subjects; how they like to study (practice problems, flashcards, explanations, mock exams).
- Accommodations or learning support they want tracked (optional).

## Files
- `02-school/courses.md`: one section per course: name, instructor, grading breakdown, key dates, links, grades so far.
- `02-school/study-log.md`: per-course list of mistakes from drills and practice, so they get retested later with harder versions. Format: `- YYYY-MM-DD · course · topic · what went wrong · retested? `.
- `02-school/plan.md` (if they shared a degree or programme plan): requirements, future terms.

## Index rows
| Courses, grading, instructors, grades so far | `02-school/courses.md` |
| Past mistakes to retest, study weak spots | `02-school/study-log.md` |
| Degree plan, requirements, future terms | `02-school/plan.md` |

## Rules to add to CLAUDE.local.md
- In study or drill sessions: log every wrong answer in `02-school/study-log.md`, and at the start of a session for that course retest logged misses with a similar but harder question.
- Explain the thinking, not just steps: what to notice, which question to ask, which method, then the full working.
- **Drill mode** ("quiz me on X"): one problem at a time, print the full problem text every time, wait for their answer, mark it, log misses, and finish with a score and the topics to revisit.
- **Practice sheets** ("make me a review sheet"): a set of problems built from their logged misses and the course's own topics, answers at the back. Use only techniques their course has taught (check `courses.md`).
- **Exam countdown:** from 14 days before each exam in `deadlines.md`, keep a line in NOW.md URGENT with days left and the next study block.
- In Brain Chat, teach maths with LaTeX and an interactive widget whenever moving a value builds intuition, and code with runnable or step-through blocks.
