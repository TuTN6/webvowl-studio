# WebVOWL Studio

WebVOWL Studio is a web-based ontology visualization and editing tool built on
WebVOWL (VOWL notation). This repository bundles the JavaScript front-end and
the OWL2VOWL converter so you can load OWL/RDF/Turtle ontologies, render them
as VOWL graphs, and export or edit them.

## Features

- Interactive graph visualization of OWL ontologies using VOWL notation.
- Import ontologies by IRI, local file upload, or drag and drop.
- Built-in sample ontologies (FOAF, GoodRelations, MUTO, OntoViBe, PersonasOnto, SIOC).
- Edit mode for creating and modifying classes, properties, and datatypes.
- Filters for datatypes, object properties, subclasses, disjointness, set operators, and node degree.
- Export to JSON, SVG, TeX, Turtle, or a shareable URL.

## Project layout

- `src/webvowl`: Core visualization library and graph engine.
- `src/app`: WebVOWL application UI, menus, and editor.
- `src/app/data`: Sample ontology JSON used by the menu.
- `owl2vowl`: Java converter and Spring server that turns OWL/RDF/Turtle into VOWL JSON.
- `util/VowlCssToD3RuleConverter`: Helper for inlining SVG styles on export.
- `doc/Docker`: Legacy Tomcat-based Docker image and notes.

## Requirements

- Node.js and npm (Dockerfile uses Node 14).
- Java 8+ and Maven for building the OWL2VOWL module directly.
- Docker (optional) for containerized builds.

## Local development

1) Install dependencies (this runs a build via the postinstall script):
   `npm install`
2) Start the dev server with live reload:
   `npm run webserver`
   - Opens http://localhost:8000
3) Create a production build:
   `npm run release`

Build output is written to `deploy/`.

## Docker (full app with OWL2VOWL)

The root `Dockerfile` builds the WebVOWL UI and packages it into the OWL2VOWL server.

```sh
docker build -t webvowl-studio .
docker run --rm -p 8080:8080 webvowl-studio
```

Or with Docker Compose:

```sh
docker compose up --build
```

Then open http://localhost:8080.

## OWL2VOWL module

The `owl2vowl` folder is a standalone Java project. For detailed usage, see
`owl2vowl/README.md`. Common tasks:

```sh
cd owl2vowl
mvn package
mvn package -P war-release
mvn package -P standalone-release
```

## UI usage tips

- Load a built-in example from the ontology menu.
- Visualize a custom ontology by IRI or upload a local OWL/RDF/Turtle file.
- Drag and drop ontology files onto the canvas.
- Use the filter and config menus to tune the graph layout and visibility.
- Export from the export menu (JSON, SVG, TeX, Turtle, or URL).
- Enable edit mode to create or modify nodes and edges.

## Tests

Run the JavaScript unit tests:

```sh
npm test
```

## License

MIT. See `license.txt`.
