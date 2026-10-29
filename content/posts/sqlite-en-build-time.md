---
title: "SQLite solo en tiempo de build"
date: 2026-10-28
description: "Usar SQL para indexar y agregar, sin llevar la base de datos a producción."
tags: [sqlite, build, unix, static]
---
SQL es muy buen lenguaje para **agrupar y filtrar**. Un sitio estático no
necesita una base de datos *en ejecución*, pero sí puede usarla *mientras se
construye*:

1. `tools/index.py` lee el Markdown y rellena `build/site.db`.
2. Dos consultas con `json_group_array` exportan JSON.
3. Hugo y el navegador consumen esos JSON como cualquier otro fichero.

```sql
SELECT tag, COUNT(*) AS total
FROM tags GROUP BY tag ORDER BY total DESC;
```

Cada pieza hace una cosa y se conecta con las demás mediante ficheros:
filosofía Unix pura.
