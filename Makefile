# Hugo + SQLite (solo en build). Cada objetivo hace una cosa.
.PHONY: index build serve check clean

index:   ## Markdown → SQLite → static/search.json + data/tags.json
	python3 tools/index.py

build: index   ## Genera el sitio estático en public/ (esto es lo que se despliega)
	hugo --gc --minify

serve: index   ## Servidor local con recarga: http://localhost:1313/
	hugo server

check: index   ## Valida que los JSON generados son JSON de verdad
	python3 -m json.tool static/search.json > /dev/null
	python3 -m json.tool data/tags.json > /dev/null
	@echo "check: OK"

clean:
	rm -rf public resources build static/search.json data/tags.json .hugo_build.lock
