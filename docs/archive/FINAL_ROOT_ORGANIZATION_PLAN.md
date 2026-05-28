# Final Root Organization Plan

> **This is a read-only advisory document.** Nothing has been moved, deleted, or modified.  
> Every recommendation below is designed to be executed **manually** by you, at your own pace, after reviewing each item.  
> The project is currently **working** — every suggestion is marked with its risk level.

---

## 1. Current Root-Level Inventory

Below is every file and directory at the repository root as of May 28, 2026.

### 1.1 Directories

| Directory | Contents | Role |
| :--- | :--- | :--- |
| `ai_service/` | `camera.py`, `best.pt` | **Core runtime** — the real AI detection script and trained model weights |
| `backend/` | Django project (fireguard), 4 apps, `requirements.txt`, `Dockerfile` | **Core runtime** — REST API, database, Firebase push |
| `frontend/` | Flutter project (`fire_gaurd`), `pubspec.yaml`, `lib/` | **Core runtime** — mobile app |
| `docs/` | `architecture.md`, `firebase-setup.md`, `diagrams/` (empty, only `.gitkeep`) | **Documentation only** |
| `screenshots/` | Only `.gitkeep` (empty) | **Placeholder** — intended for README images |
| `.git/` | Git internals | System — do not touch |
| `.cursor/` | IDE settings | Gitignored — local only |
| `__pycache__/` | `main.cpython-311.pyc` | **Junk** — should be gitignored and is, but the folder still exists locally |

### 1.2 Files

| # | File | Size | Git-tracked? | Category | Summary |
| :-: | :--- | :--- | :---: | :--- | :--- |
| 1 | `README.md` | 50 KB | ✅ | Documentation | Primary project documentation (1,444 lines). Has duplicate sections (two "Future Improvements", two "Contributors", two "License" blocks) and leftover merge markers like `(docs: reorganize repository and improve documentation)` scattered throughout. |
| 2 | `DEPLOYMENT.md` | 12.5 KB | ✅ | Documentation | Thorough deployment guide covering Docker, manual setup, Firebase, Flutter, PythonAnywhere, and troubleshooting. Well-written and useful. |
| 3 | `Deploymemt.md` | 12.5 KB | ✅ | **Exact duplicate** | Byte-for-byte identical to `DEPLOYMENT.md` (SHA-256 verified). Name has a typo ("Deploymemt"). Not linked from any other document. |
| 4 | `README_1.MD` | 4.9 KB | ✅ | Legacy doc | An older runbook describing an alternative architecture where `ai_service` ran as a FastAPI/Uvicorn server on port 8001 and Flutter talked to it directly. Still referenced by `README.md` line 1243. |
| 5 | `API_DOCS.md` | **0 bytes** | ✅ | **Empty placeholder** | Tracked in git but completely empty. Referenced by `README.md` line 1241. |
| 6 | `CONTRIBUTING.md` | 4.2 KB | ✅ | Documentation | Contribution guidelines and coding standards. |
| 7 | `LICENSE` | 1.1 KB | ✅ | Legal | MIT License. |
| 8 | `.env.example` | 4.2 KB | ✅ | Configuration template | Environment variables template for backend, AI service, and Flutter. |
| 9 | `.gitignore` | 2.3 KB | ✅ | Configuration | Properly ignores `.env`, `__pycache__`, model weights, `firebase_credentials.json`, `prompts_book.md`, etc. |
| 10 | `docker-compose.yml` | 1.7 KB | ✅ | Deployment | Multi-service Docker Compose (ai_service, backend, db). Optional for runtime — see section 5. |
| 11 | `main.py` | 1.4 KB | ✅ | **Legacy code** | A FastAPI app that imports from `inference.py` and exposes a `/predict` endpoint on port 8001. This is an **alternative architecture** that is NOT used in the real working demo. The real AI workflow uses `ai_service/camera.py`. |
| 12 | `inference.py` | 1.5 KB | ✅ | **Legacy code** | `FireDetector` class used by root `main.py`. Imports from root `model.py`. Not used by `ai_service/camera.py`. |
| 13 | `model.py` | 1.7 KB | ✅ | **Legacy code** | YOLO loader and `run_inference()` function. Referenced by root `inference.py`. Expects model at `model/best.pt` (a path that doesn't exist at root). Not used by `ai_service/camera.py`. |
| 14 | `webcam_client.py` | 1.8 KB | ✅ | **Legacy utility** | Captures webcam frames and POSTs them to `http://localhost:8001/predict` — this is a client for the root `main.py` FastAPI server, not for the real `camera.py` workflow. |
| 15 | `demo.py` | 1.9 KB | ✅ | **Legacy utility** | Pretty-printed terminal demo, also a client for root `main.py`'s `/predict` endpoint. |
| 16 | `prompts_book.md` | 58.7 KB | ❌ (gitignored) | Private notes | AI-generation prompts history. Already gitignored. Only exists locally. |
| 17 | `scratch_fix_prompts.py` | 1.7 KB | ✅ | **Junk** | A one-time string-replacement script that was used to fix text in `prompts_book.md` and `CONTRIBUTING.md`. Hardcodes absolute paths on your machine. Has no ongoing purpose. |
| 18 | `requirements-ai.txt` | 73 B | ✅ | Configuration | AI dependencies file (created in the previous session). |
| 19 | `RUN_PROJECT.md` | 5.1 KB | ✅ | Documentation | Runtime guide (created in the previous session). |
| 20 | `ROOT_STRUCTURE_RECOMMENDATIONS.md` | 2.2 KB | ✅ | Documentation | Earlier cleanup recommendations (created in the previous session). |

---

## 2. File Classification

### ✅ Actively Used (REQUIRED for the project to work)

These files are essential. **Do not move or rename them.**

| File / Directory | Why it's essential |
| :--- | :--- |
| `ai_service/camera.py` | The actual real-time detection script |
| `ai_service/best.pt` | Trained YOLOv8 weights |
| `backend/` (entire directory) | Django REST API, database, Firebase push |
| `frontend/` (entire directory) | Flutter mobile app |

### 📖 Documentation (valuable for graduation, safe to reorganize)

| File | Notes |
| :--- | :--- |
| `README.md` | Keep at root. Has duplicate sections that could be cleaned up (see section 6). |
| `DEPLOYMENT.md` | Useful. Keep at root or move to `docs/`. |
| `CONTRIBUTING.md` | Standard open-source file. Keep at root. |
| `LICENSE` | Must stay at root for GitHub to detect it. |
| `RUN_PROJECT.md` | Practical runtime guide. Keep at root. |
| `docs/architecture.md` | Extended architecture docs. Already in the right place. |
| `docs/firebase-setup.md` | Firebase config guide. Already in the right place. |
| `.env.example` | Environment template. Keep at root. |

### ⚙️ Deployment/Configuration (optional for runtime)

| File | Notes |
| :--- | :--- |
| `docker-compose.yml` | Optional. The project works without Docker. Keep at root. |
| `.gitignore` | Essential for git. Keep at root. |
| `requirements-ai.txt` | Useful reference. Keep at root. |

### 🗃️ Legacy / Alternative Architecture (NOT used in the real workflow)

| File | What it is | Why it's legacy |
| :--- | :--- | :--- |
| `main.py` | FastAPI server | The real workflow uses `ai_service/camera.py` directly, not a FastAPI microservice. |
| `inference.py` | FastAPI inference helper | Only imported by root `main.py`. `camera.py` does its own inference. |
| `model.py` | YOLO wrapper for FastAPI | Only imported by root `inference.py`. `camera.py` loads the model itself. |
| `webcam_client.py` | Client for FastAPI `/predict` | Only works with root `main.py`. Not used with `camera.py`. |
| `demo.py` | Pretty-print client for FastAPI | Only works with root `main.py`. Not used with `camera.py`. |

> **Key insight:** The three root Python files (`main.py` → `inference.py` → `model.py`) form a **self-contained alternative architecture** where the AI ran as a FastAPI microservice. The **real working demo** uses `ai_service/camera.py` which directly reads the webcam, runs YOLO, and POSTs to Django. These two architectures are completely independent.

### 🗑️ Duplicates / Junk

| File | Issue |
| :--- | :--- |
| `Deploymemt.md` | Byte-for-byte duplicate of `DEPLOYMENT.md` with a typo in the filename. Not linked from anywhere. |
| `API_DOCS.md` | Tracked in git but **completely empty** (0 bytes). Referenced by `README.md` but contains nothing. |
| `README_1.MD` | An older runbook for the FastAPI-based architecture. Content is outdated (references `uvicorn`, `ai_service/requirements.txt` which doesn't exist). Referenced by `README.md`. |
| `scratch_fix_prompts.py` | One-time script with hardcoded local paths. Already served its purpose. |
| `__pycache__/` | Should be gitignored (and is), but the folder exists locally. |
| `ROOT_STRUCTURE_RECOMMENDATIONS.md` | Superseded by this document. |

---

## 3. Recommended Final Root Structure

Below is the ideal structure. Items marked with 🔒 must stay exactly where they are.

```text
Fire Detection/
│
├── 🔒 ai_service/                # Core: AI detection script + model weights
│   ├── camera.py
│   └── best.pt
│
├── 🔒 backend/                   # Core: Django REST API
│   └── (all existing contents)
│
├── 🔒 frontend/                  # Core: Flutter mobile app
│   └── (all existing contents)
│
├── docs/                         # All extended documentation
│   ├── architecture.md           (already here)
│   ├── firebase-setup.md         (already here)
│   ├── diagrams/                 (already here)
│   ├── DEPLOYMENT.md             (moved from root — optional)
│   └── API_DOCS.md               (moved from root, once content is added — optional)
│
├── screenshots/                  # App screenshots (add real ones before presentation)
│
├── scripts/                      # Developer utility scripts (optional)
│   ├── demo.py                   (moved from root)
│   └── webcam_client.py          (moved from root)
│
├── archive/                      # Legacy code not used in real workflow (optional)
│   ├── main.py                   (FastAPI server — legacy)
│   ├── inference.py              (FastAPI helper — legacy)
│   └── model.py                  (FastAPI YOLO wrapper — legacy)
│
├── 🔒 README.md                  # Primary documentation
├── 🔒 LICENSE                    # MIT License
├── 🔒 .gitignore
├── 🔒 .env.example               # Environment template
├── CONTRIBUTING.md
├── RUN_PROJECT.md                # Practical runtime guide
├── requirements-ai.txt           # AI dependencies
└── docker-compose.yml            # Optional Docker orchestration
```

**Files removed entirely (not moved):**
- `Deploymemt.md` — exact duplicate, safe to delete
- `scratch_fix_prompts.py` — one-time junk script, safe to delete
- `API_DOCS.md` — empty file, either delete or populate with real content
- `README_1.MD` — outdated runbook for a different architecture, safe to delete
- `ROOT_STRUCTURE_RECOMMENDATIONS.md` — superseded by this document
- `__pycache__/` — delete locally, already gitignored

---

## 4. Suggested Folders

### `docs/`
**Already exists.** Currently contains `architecture.md`, `firebase-setup.md`, and an empty `diagrams/` folder.

| Candidate to move here | Currently at | Risk |
| :--- | :--- | :--- |
| `DEPLOYMENT.md` | Root | 🟡 Low — you would need to update the link in `README.md` line 1242 from `(DEPLOYMENT.md)` to `(docs/DEPLOYMENT.md)` |
| `API_DOCS.md` | Root | 🟢 None — the file is empty anyway. If you decide to write real API docs, put them here. Update `README.md` line 1241. |

### `scripts/`
**Does not exist yet.** Would hold developer utilities that are not part of the core runtime.

| Candidate to move here | Currently at | Risk |
| :--- | :--- | :--- |
| `demo.py` | Root | 🟢 None — this file is a standalone script. No other file imports it. It connects to `localhost:8001/predict` which is the legacy FastAPI architecture. Moving it won't break anything. |
| `webcam_client.py` | Root | 🟢 None — same as `demo.py`. Standalone script, no imports from it. |

### `archive/`
**Does not exist yet.** Would hold legacy code from the alternative FastAPI-based architecture.

| Candidate to move here | Currently at | Risk |
| :--- | :--- | :--- |
| `main.py` | Root | 🟡 Low — see detailed analysis in section 5 |
| `inference.py` | Root | 🟡 Low — see detailed analysis in section 5 |
| `model.py` | Root | 🟡 Low — see detailed analysis in section 5 |

### `screenshots/`
**Already exists** but is empty (only `.gitkeep`). Add real app screenshots before your graduation presentation. The `README.md` already references images like `screenshots/splash.png`, `screenshots/login.png`, etc.

### `deployment/`
**Not recommended.** The `docker-compose.yml` belongs at root (Docker expects it there), and `DEPLOYMENT.md` is fine in either root or `docs/`. Creating a separate `deployment/` folder would be overkill for this project.

---

## 5. Detailed Move/Stay Analysis for Each File

### `main.py` (root) — Recommend: Archive

| Question | Answer |
| :--- | :--- |
| **Is it used at runtime?** | No. The real detection uses `ai_service/camera.py`. |
| **Does anything import it?** | No. Nothing imports the root `main.py`. |
| **Does moving it affect runtime?** | No. |
| **Does moving it break imports?** | No. The import chain is `main.py → inference.py → model.py`, all at root. If you move all three together, nothing breaks (they weren't being used anyway). |
| **Does moving it break documentation links?** | The `README.md` references it in the folder structure section (lines 890, 912) as "Root copies for local dev". You should update that text. |
| **Risk level** | 🟢 Very low |

### `inference.py` (root) — Recommend: Archive

| Question | Answer |
| :--- | :--- |
| **Is it used at runtime?** | No. Only imported by root `main.py`. |
| **Does anything import it?** | Only root `main.py` (line 5: `from inference import FireDetector`). |
| **Does moving it affect runtime?** | No. |
| **Does moving it break imports?** | Only if you run root `main.py`, which is not the real workflow. |
| **Risk level** | 🟢 Very low |

### `model.py` (root) — Recommend: Archive

| Question | Answer |
| :--- | :--- |
| **Is it used at runtime?** | No. Only imported by root `inference.py`. |
| **Does anything import it?** | Only root `inference.py` (line 7: `from model import load_model, run_inference`). |
| **Does moving it affect runtime?** | No. |
| **Note** | This file expects the model at `model/best.pt` which doesn't exist at root (the real model is at `ai_service/best.pt`). This further confirms it's unused. |
| **Risk level** | 🟢 Very low |

### `webcam_client.py` — Recommend: Archive or Scripts

| Question | Answer |
| :--- | :--- |
| **Is it used at runtime?** | No. It sends frames to `http://localhost:8001/predict` — the FastAPI endpoint from root `main.py`, not the real `camera.py` workflow. |
| **Does anything import it?** | No. |
| **Does moving it affect runtime?** | No. |
| **Does moving it break documentation links?** | `README.md` references it in lines 888, 910, 952, 1175. Update those references. |
| **Risk level** | 🟢 Very low |

### `demo.py` — Recommend: Archive or Scripts

| Question | Answer |
| :--- | :--- |
| **Is it used at runtime?** | No. Same as `webcam_client.py` — talks to the FastAPI `/predict` endpoint. |
| **Does anything import it?** | No. |
| **Does moving it affect runtime?** | No. |
| **Does moving it break documentation links?** | `README.md` references it in lines 889, 911, 1182. Update those references. |
| **Risk level** | 🟢 Very low |

### `Deploymemt.md` — Recommend: Delete

| Question | Answer |
| :--- | :--- |
| **Is it different from `DEPLOYMENT.md`?** | No. SHA-256 hash verified identical. |
| **Is it linked from anywhere?** | No. Not referenced by any other file. |
| **Does deleting it affect anything?** | No. |
| **Risk level** | 🟢 Zero |

### `scratch_fix_prompts.py` — Recommend: Delete

| Question | Answer |
| :--- | :--- |
| **Is it used at runtime?** | No. One-time text-replacement script. |
| **Does anything import it?** | No. |
| **Does it contain valuable logic?** | No. It has hardcoded absolute paths to `C:\Users\user\.gemini\...` |
| **Risk level** | 🟢 Zero |

### `API_DOCS.md` — Recommend: Delete or Populate

| Question | Answer |
| :--- | :--- |
| **Does it contain anything?** | No. 0 bytes. |
| **Is it linked from `README.md`?** | Yes, line 1241. |
| **Options** | Either (a) delete it and remove the link from `README.md`, or (b) write real API documentation into it. Option (a) is simpler. The README already has a thorough API Overview section. |
| **Risk level** | 🟢 Zero |

### `README_1.MD` — Recommend: Delete

| Question | Answer |
| :--- | :--- |
| **Is its content still accurate?** | Partially outdated. It describes the FastAPI/Uvicorn architecture and references `ai_service/requirements.txt` which does not exist. |
| **Is it linked from `README.md`?** | Yes, line 1243. |
| **Does the project need it?** | No. The new `RUN_PROJECT.md` covers the real workflow. `DEPLOYMENT.md` covers deployment. |
| **If you delete it** | Remove the link from `README.md` line 1243. |
| **Risk level** | 🟢 Very low |

### `prompts_book.md` — No action needed

Already gitignored. It only exists on your local machine and will not appear on GitHub. No action required.

### `__pycache__/` — Recommend: Delete locally

Already gitignored, so it won't appear on GitHub. You can safely delete the local `__pycache__/` folder. It will be regenerated if you ever run a root-level Python file again.

### `docker-compose.yml` — Keep at root

Docker Compose expects this file at the project root. It describes an optional deployment method. Keeping it at root is the standard convention and does not clutter the repository.

### `.env.example` — Keep at root

Standard convention for environment templates. Keep at root.

### `CONTRIBUTING.md` — Keep at root

Standard GitHub convention. GitHub's UI automatically links to it on the repository page.

### `LICENSE` — Keep at root (REQUIRED)

GitHub uses this file to detect and display the license type. **Must** stay at root.

### `RUN_PROJECT.md` — Keep at root

The practical runtime guide. Keeping it at root ensures high visibility for anyone visiting the repository.

### `requirements-ai.txt` — Keep at root

Separates AI dependencies from backend dependencies. Good practice. Keep at root for easy discoverability.

---

## 6. Additional Cleanup Notes (README.md)

The `README.md` currently has **duplicate sections** that should be consolidated. These are editorial issues, not file-organization issues:

| Issue | Lines | Recommendation |
| :--- | :--- | :--- |
| Duplicate "Future Improvements" | Lines 1192–1230 and 1299–1337 | Remove one copy |
| Duplicate "Contributors" | Lines 1253–1296 and 1358–1401 | Remove one copy |
| Duplicate "License" | Lines 1345–1355 and 1413–1425 | Remove one copy |
| Leftover merge markers | Lines 42, 58, 100, 913, 1107, 1127, 1146, 1247, 1339, 1403, 1426, 1442 — all say `(docs: reorganize repository and improve documentation)` | Remove all of them |
| Duplicate screenshot references | Lines 1118–1127 reference both `frontend/screenshots/` and `screenshots/` paths | Pick one path and remove the other |
| Duplicate folder structure tree | Lines 811–913 has the tree listed twice with slight variations | Consolidate into one clean tree |

> **These edits to `README.md` are safe** — they only affect documentation text, not imports, not runtime, not architecture.

---

## 7. Execution Checklist

If you decide to follow this plan, here is the step-by-step manual checklist. Do each step one at a time and verify nothing broke before proceeding.

### Phase 1 — Safe deletions (zero risk)

- [ ] Delete `Deploymemt.md` (exact duplicate, not linked anywhere)
- [ ] Delete `scratch_fix_prompts.py` (one-time junk script)
- [ ] Delete local `__pycache__/` folder

### Phase 2 — Empty/outdated files (very low risk)

- [ ] Delete `API_DOCS.md` (empty, 0 bytes)
- [ ] Remove the `API_DOCS.md` link from `README.md` line 1241
- [ ] Delete `README_1.MD` (outdated runbook for wrong architecture)
- [ ] Remove the `README_1.MD` link from `README.md` line 1243
- [ ] Delete `ROOT_STRUCTURE_RECOMMENDATIONS.md` (superseded by this document)

### Phase 3 — Archive legacy code (low risk)

- [ ] Create `archive/` folder at root
- [ ] Move `main.py` → `archive/main.py`
- [ ] Move `inference.py` → `archive/inference.py`
- [ ] Move `model.py` → `archive/model.py`
- [ ] Move `webcam_client.py` → `archive/webcam_client.py`
- [ ] Move `demo.py` → `archive/demo.py`
- [ ] Add a short `archive/README.md` explaining these are legacy FastAPI-architecture files
- [ ] Update `README.md` folder structure section to reflect the moves

### Phase 4 — Optional documentation moves

- [ ] Move `DEPLOYMENT.md` → `docs/DEPLOYMENT.md` (optional — root is also fine)
- [ ] If moved, update `README.md` link at line 1242

### Phase 5 — README cleanup (cosmetic, safe)

- [ ] Remove all `(docs: reorganize repository and improve documentation)` leftover markers
- [ ] Remove duplicate "Future Improvements" section (keep one)
- [ ] Remove duplicate "Contributors" section (keep one)
- [ ] Remove duplicate "License" section (keep one)
- [ ] Consolidate duplicate folder structure tree
- [ ] Fix duplicate screenshot paths (pick `screenshots/` only)
- [ ] Update folder structure to match the new layout

### Phase 6 — Final verification

- [ ] Run `cd backend && python manage.py runserver 0.0.0.0:8000` — confirm backend starts
- [ ] Run `cd ai_service && python camera.py` — confirm AI script starts
- [ ] Run `cd frontend && flutter pub get && flutter run` — confirm app builds
- [ ] Verify `git status` looks clean
- [ ] Commit with message like `chore: clean up root directory, archive legacy files`

---

## 8. Risk Summary

| Action | Risk | Affects Runtime? | Affects Imports? | Affects Doc Links? |
| :--- | :---: | :---: | :---: | :---: |
| Delete `Deploymemt.md` | 🟢 Zero | No | No | No |
| Delete `scratch_fix_prompts.py` | 🟢 Zero | No | No | No |
| Delete `__pycache__/` | 🟢 Zero | No | No | No |
| Delete `API_DOCS.md` | 🟢 Zero | No | No | Yes — update README |
| Delete `README_1.MD` | 🟢 Zero | No | No | Yes — update README |
| Archive `main.py` | 🟢 Very low | No | No (self-contained chain) | Yes — update README |
| Archive `inference.py` | 🟢 Very low | No | Only root `main.py` | Yes — update README |
| Archive `model.py` | 🟢 Very low | No | Only root `inference.py` | Yes — update README |
| Archive `webcam_client.py` | 🟢 Very low | No | No | Yes — update README |
| Archive `demo.py` | 🟢 Very low | No | No | Yes — update README |
| Move `DEPLOYMENT.md` to `docs/` | 🟡 Low | No | No | Yes — update README |
| Clean up README duplicates | 🟢 Zero | No | No | No |

> **Bottom line:** None of the recommended changes affect the three core runtime components (`ai_service/camera.py`, `backend/`, `frontend/`). All changes are to root-level files that exist outside the active runtime path.
