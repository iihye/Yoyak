import uvicorn
from fastapi import FastAPI, UploadFile, Request, status, File
from fastapi.responses import JSONResponse, FileResponse
import os
import uuid
from pathlib import Path
import sys
import platform

from predict import run;
app = FastAPI()

FILE = Path(__file__).resolve()
ROOT = FILE.parents[0]  # YOLO root directory
if str(ROOT) not in sys.path:
    sys.path.append(str(ROOT))  # add ROOT to PATH
ROOT = Path(os.path.relpath(ROOT, Path.cwd()))  # relative

@app.post("/api/upload")
async def upload_file(image: UploadFile = File(...)):
    extension = os.path.splitext(image.filename)[1]
    unique_name = f"{uuid.uuid4()}{extension}"

    upload_path = "uploads"
    if not os.path.exists(upload_path):
        os.makedirs(upload_path)
    file_path = os.path.join(upload_path, unique_name)
    with open(file_path, "wb") as buffer:
        buffer.write(image.file.read())

    option = {
        "weights":ROOT / './trained_model/yolov9c_instance.pt',
        "source" : file_path,
        "data": ROOT/'data/custom.yaml',
        "imgsz" : [320,320],
        "device" : "cpu"
    }
    print("option", option)
    names = run(**option)
    return {"file_path": file_path}

