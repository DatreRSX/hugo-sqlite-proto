---
title: "Búsqueda sin servidor"
date: 2026-10-29
description: "Un JSON estático y JavaScript vainilla bastan para buscar en el navegador."
tags: [javascript, mdn, kiss, static]
---
El navegador descarga `search.json` una vez y filtra en memoria con
`fetch`, `filter` y `every`. Sin frameworks, sin dependencias.

Referencias en MDN:

- [Fetch API](https://developer.mozilla.org/es/docs/Web/API/Fetch_API)
- [Array.prototype.filter()](https://developer.mozilla.org/es/docs/Web/JavaScript/Reference/Global_Objects/Array/filter)
- [String.prototype.normalize()](https://developer.mozilla.org/es/docs/Web/JavaScript/Reference/Global_Objects/String/normalize)

Prueba a buscar "sqlite" o "mdn" en la página de inicio.
