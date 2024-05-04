curl -X POST localhost:8012/v2/models/phi2/generate \
    -d '{"text_input": "What is triton inference server?", "parameters": {"stream": false, "temperature": 0.4, "max_tokens":512}}'