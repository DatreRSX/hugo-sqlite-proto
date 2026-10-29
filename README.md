# hugo-sqlite-proto

Prototipo didáctico: **Hugo** genera HTML estático desde Markdown y **SQLite** trabaja
**solo en tiempo de build** (indexar y agregar). En producción: ficheros estáticos, nada más.

Continuación de la práctica
[P1.2 — Tu mini sitio web con Hugo](https://www.librebits.info/2asir/iaw/mini-sitio-web-con-hugo/).

## Idea (Unix: cada pieza hace una cosa, se unen con ficheros)

```
content/*.md ──► tools/index.py ──► build/site.db ──┬─► static/search.json ─► navegador (search.js)
 (Markdown)      (parsea + INSERT)   (SQLite, local) └─► data/tags.json ────► Hugo (layouts/index.html)

                                    hugo ──► public/   ← lo único que se despliega
```

`build/`, `static/search.json` y `data/tags.json` están en `.gitignore`: se **regeneran** en cada build.

## Requisitos

- [Hugo](https://gohugo.io/installation/) (versión estándar, no hace falta *extended*)
- Python 3.8+ (solo biblioteca estándar: [`sqlite3`](https://docs.python.org/3/library/sqlite3.html), `json`, `re`)
- `make`

## Uso

```bash
make serve    # índice + servidor local en http://localhost:1313/
make build    # índice + hugo --gc --minify  → public/
make check    # valida que los JSON generados son JSON válido
make clean
```

## Estructura

```
content/            Markdown con front matter YAML (el borrador no se indexa ni se publica)
layouts/            Plantillas Hugo: baseof, single, list, index + parciales header/footer
static/search.js    Búsqueda en el navegador: vainilla ES6+, estilo funcional
static/style.css    CSS3 con variables y modo oscuro
tools/index.py      Markdown → SQLite → JSON (funciones puras + efectos al final)
Makefile            index · build · serve · check · clean
```

## Dónde mirar

- **SQL como generador de JSON**: `Q_SEARCH` y `Q_TAGS` en `tools/index.py`
  ([JSON1](https://www.sqlite.org/json1.html), `GROUP BY`, `COUNT`).
- **Datos de build en plantillas**: `hugo.Data.tags` en `layouts/index.html`
  ([Hugo data](https://gohugo.io/content-management/data-sources/)).
- **Búsqueda sin servidor**: `static/search.js` ([`fetch`](https://developer.mozilla.org/es/docs/Web/API/Fetch_API),
  [`filter`](https://developer.mozilla.org/es/docs/Web/JavaScript/Reference/Global_Objects/Array/filter),
  [`normalize`](https://developer.mozilla.org/es/docs/Web/JavaScript/Reference/Global_Objects/String/normalize)).

## Ejercicios

1. Añade un post con `tags: [sql]` y comprueba cómo cambia el conteo de etiquetas en la home (`make serve`).
2. `hugo server -D` muestra el borrador, pero la búsqueda no lo encuentra. ¿Por qué? Añade un
   flag `--drafts` a `tools/index.py` para que coincidan.
3. Añade una tabla `words(url, n)` con el número de palabras de cada post y muestra el total en el pie.
4. Cambia la búsqueda para ordenar los resultados por número de coincidencias (sigue siendo una función pura).
5. Despliega `public/` con `rsync` a tu VPS o con GitHub Pages. ¿Qué proceso corre en el servidor? (Ninguno de tuyos.)

## Límites a propósito (KISS)

`tools/index.py` entiende front matter YAML simple (`clave: valor` y `tags: [a, b]`); no TOML ni listas
multilínea. Para algo más serio, usa una biblioteca de YAML: aquí lo importante es el *flujo*.
