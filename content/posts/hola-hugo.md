---
title: "Hola, Hugo"
date: 2026-10-27
description: "Un sitio estático es un directorio de ficheros HTML. Nada más."
tags: [hugo, static, kiss]
---
Hugo lee ficheros Markdown con *front matter* y escribe HTML en `public/`.
No hay servidor de aplicaciones, ni base de datos, ni procesos que vigilar.

```bash
hugo new site mi-sitio
hugo server
```

Escenario real: un departamento publica apuntes y entregas. Con Hugo, el
despliegue es copiar una carpeta (`rsync`, `scp`, GitHub Pages...) y el
servidor web solo sirve ficheros.
