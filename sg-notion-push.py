#!/usr/bin/env python3
import os
import requests
import datetime

# Load Notion credentials from ~/.config/sgos.env
from pathlib import Path
env_path = Path.home() / '.config' / 'sgos.env'
if not env_path.exists():
    print('Missing ~/.config/sgos.env')
    exit(1)

env = {}
with open(env_path) as f:
    for line in f:
        if '=' in line:
            k, v = line.strip().split('=', 1)
            env[k] = v

NOTION_TOKEN = env.get('NOTION_TOKEN')
NOTION_PAGE_ID = env.get('NOTION_PAGE_ID')
if not NOTION_TOKEN or not NOTION_PAGE_ID:
    print('Notion credentials missing in ~/.config/sgos.env')
    exit(1)

# Read last 20 lines from log
log_path = Path.home() / 'SteinsGateLogs' / 'worldline.log'
if not log_path.exists():
    print('No log file found.')
    exit(1)
with open(log_path) as f:
    lines = f.readlines()[-20:]

log_text = ''.join(lines)

# Prepare Notion API request
url = f'https://api.notion.com/v1/pages'
headers = {
    'Authorization': f'Bearer {NOTION_TOKEN}',
    'Notion-Version': '2022-06-28',
    'Content-Type': 'application/json',
}
data = {
    "parent": {"page_id": NOTION_PAGE_ID},
    "properties": {
        "title": [{"text": {"content": f"Worldline Log {datetime.datetime.now().isoformat()}"}}]
    },
    "children": [
        {
            "object": "block",
            "type": "paragraph",
            "paragraph": {
                "text": [{"type": "text", "text": {"content": log_text}}]
            }
        }
    ]
}

response = requests.post(url, headers=headers, json=data)
if response.status_code == 200:
    print('✅ Log pushed to Notion!')
else:
    print(f'❌ Failed to push log: {response.text}')
