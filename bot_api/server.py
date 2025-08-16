import os, requests
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from dotenv import load_dotenv

load_dotenv()

AZURE_ENDPOINT    = os.environ["AZURE_OPENAI_ENDPOINT"].rstrip("/")
AZURE_KEY         = os.environ["AZURE_OPENAI_KEY"]
AZURE_API_VERSION = os.environ.get("AZURE_OPENAI_API_VERSION", "2024-06-01")
DEPLOYMENT        = os.environ["AZURE_OPENAI_DEPLOYMENT"]

# CORS
allow_origins = [o.strip() for o in os.environ.get("CORS_ALLOW_ORIGINS", "*").split(",") if o.strip()]

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=allow_origins if allow_origins else ["*"],  # tighten in prod
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class ChatMessage(BaseModel):
    role: str   # "system" | "user" | "assistant"
    content: str

class ChatRequest(BaseModel):
    messages: list[ChatMessage]

@app.post("/chat")
def chat(req: ChatRequest):
    url = f"{AZURE_ENDPOINT}/openai/deployments/{DEPLOYMENT}/chat/completions?api-version={AZURE_API_VERSION}"
    headers = {
        "Content-Type": "application/json",
        "api-key": AZURE_KEY,
    }

    # prepend a system persona for Stev-o-mate
    msgs = [{"role": "system", "content": "You are Stev-o-mate, the Smart-Campus assistant. Be concise and helpful."}]
    msgs += [m.dict() for m in req.messages]

    payload = {
        "messages": msgs,
        "temperature": 0.3,
        "max_tokens": 512,
    }

    try:
        r = requests.post(url, headers=headers, json=payload, timeout=60)
        r.raise_for_status()
        data = r.json()
        reply = data["choices"][0]["message"]["content"]
        return {"reply": reply}
    except requests.HTTPError as e:
        raise HTTPException(status_code=r.status_code, detail=r.text) from e
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e)) from e
