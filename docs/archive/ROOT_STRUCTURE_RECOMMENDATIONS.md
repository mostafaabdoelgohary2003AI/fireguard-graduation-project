# Root Structure Recommendations

This report outlines a **non-destructive** plan for cleaning up the root directory of the repository.

Currently, the root folder contains several duplicate, legacy, and alternative-architecture files that make the project look more complicated than it actually is. By moving these files into an `archive/` folder or deleting exact duplicates, the project will be much cleaner for graduation grading.

### 📁 Current Root Files & Their Purpose

| File | Purpose in Reality | Action Recommendation |
| :--- | :--- | :--- |
| `API_DOCS.md` | API documentation | **Keep** |
| `CONTRIBUTING.md` | Open-source guidelines | **Keep** |
| `DEPLOYMENT.md` | Deployment guide | **Keep** |
| `LICENSE` | MIT License | **Keep** |
| `README.md` | Primary documentation | **Keep** |
| `docker-compose.yml` | Optional Docker setup | **Keep** |
| `requirements-ai.txt` | Newly added AI dependencies | **Keep** |
| `RUN_PROJECT.md` | Newly added runtime guide | **Keep** |
| `Deploymemt.md` | Typo duplicate of `DEPLOYMENT.md` | **Safe to delete** |
| `README_1.MD` | Older backup of the README | **Safe to archive/delete** |
| `demo.py` | Demo client for alternative FastAPI architecture | **Archive** to `archive/` or `demo/` |
| `webcam_client.py` | Webcam client for alternative FastAPI architecture | **Archive** to `archive/` or `demo/` |
| `main.py` | FastAPI server entrypoint (Unused in final workflow) | **Archive** to `archive/` |
| `inference.py` | FastAPI inference logic (Unused in final workflow) | **Archive** to `archive/` |
| `model.py` | FastAPI YOLO wrapper (Unused in final workflow) | **Archive** to `archive/` |
| `prompts_book.md` | AI generation prompts / history | **Archive** to `docs/` or `archive/` |
| `scratch_fix_prompts.py`| Temporary scratchpad script | **Safe to delete** |

---

### 🌟 Recommended Final Root Structure

If the cleanup is performed, your root directory will look beautifully simple:

```text
Fire Detection/
├── 📂 ai_service/             # ⚡ Local inference script (camera.py, best.pt)
├── 📂 archive/                # 🗃️ Legacy FastAPI scripts & unused clients
├── 📂 backend/                # 🗄️ Django REST API
├── 📂 docs/                   # 📖 Additional documentation & prompts
├── 📂 frontend/               # 📱 Flutter mobile app
├── 📂 screenshots/            # 📸 Readme images
├── API_DOCS.md
├── CONTRIBUTING.md
├── DEPLOYMENT.md
├── LICENSE
├── README.md
├── RUN_PROJECT.md             # The definitive runtime guide
├── docker-compose.yml         
└── requirements-ai.txt        # Separated AI dependencies
```

### 💡 Why this structure is better:
1. **Removes confusion:** The existence of `main.py` and `camera.py` simultaneously leads people to wonder which one to run. The real working one is `ai_service/camera.py`.
2. **Focuses grading:** Graduation judges will only see the cleanly separated `ai_service`, `backend`, and `frontend` folders, making the architecture immediately obvious.
3. **Non-destructive:** We aren't deleting your old work (`main.py`, `inference.py`, etc.), we are simply moving it into `archive/` so you still have it if you ever need it.
