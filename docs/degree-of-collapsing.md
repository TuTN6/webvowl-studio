# Degree of collapsing slider

This document summarizes how the node degree filter slider reduces visible elements by collapsing low-degree nodes and how it is wired into the app.

## Purpose

The degree slider filters nodes below a chosen degree threshold to trim the graph and improve readability and performance when many elements are present.

## Key code references

- **UI and events** – slider element creation, value label updates, and change/input/wheel/focusout handlers live in `src/app/js/menu/filterMenu.js`. The slider updates the label live, triggers graph refreshes on change and wheel interactions, and avoids redundant updates when the value is unchanged. 【F:src/app/js/menu/filterMenu.js†L116-L176】【F:src/app/js/menu/filterMenu.js†L185-L200】
- **App integration and options** – the slider menu is initialized during app setup and its node-degree module is registered in the graph `filterModules`, so graph updates respect the selected threshold. 【F:src/app/js/app.js†L197-L239】
- **Filtering logic** – `nodeDegreeFilter` initializes the slider bounds, auto-selects a default degree based on dataset size, and filters nodes/properties when enabled. It also highlights the slider and flags a filter warning when the default exceeds zero. 【F:src/webvowl/js/modules/nodeDegreeFilter.js†L21-L124】【F:src/webvowl/js/modules/nodeDegreeFilter.js†L126-L156】
- **UX warning** – the warning module shows guidance when collapsing is activated, instructing users to adjust the slider in the filter menu. 【F:src/app/js/warningModule.js†L273-L300】

## Libraries and utilities

- **D3.js** handles DOM binding and event listeners across the filter menu and warning module (e.g., `d3.select`, `on`, `classed`). 【F:src/app/js/menu/filterMenu.js†L11-L157】【F:src/app/js/warningModule.js†L1-L116】
- **Internal utilities** – `filterTools` and `elementTools` support node-degree calculations and datatype filtering inside the module logic. 【F:src/webvowl/js/modules/nodeDegreeFilter.js†L1-L124】

## Slider configuration

| Property | Value / Source | Notes |
| --- | --- | --- |
| `id` | `nodeDegreeDistanceSlider` | Created in `filterMenu` with a paired label. 【F:src/app/js/menu/filterMenu.js†L119-L134】 |
| `min` | `0` | Static lower bound. 【F:src/app/js/menu/filterMenu.js†L122-L123】 |
| `step` | `1` | Integer degree increments. 【F:src/app/js/menu/filterMenu.js†L122-L123】 |
| `max` | Dynamic, set from graph max degree | Updated through `setMaxDegreeSetter` when data loads. 【F:src/app/js/menu/filterMenu.js†L99-L111】【F:src/webvowl/js/modules/nodeDegreeFilter.js†L21-L40】 |
| Change trigger | `change` event updates graph and stored degree | Ensures graph refresh after slider release. 【F:src/app/js/menu/filterMenu.js†L136-L141】 |
| Live feedback | `input` updates the value label | Keeps label synced while dragging. 【F:src/app/js/menu/filterMenu.js†L144-L148】 |
| Wheel adjust | `wheel` increments/decrements value and refreshes graph | Supports mouse wheel control with bounds checks. 【F:src/app/js/menu/filterMenu.js†L150-L176】 |
| Blur handling | `focusout` refreshes if value changed | Prevents stale graph state after keyboard entry. 【F:src/app/js/menu/filterMenu.js†L150-L156】 |

## Testing checklist

- Drag the degree slider and confirm the label updates and the graph refreshes on release.
- Use the mouse wheel over the slider to increment/decrement the degree and observe graph updates.
- Move focus away after editing the slider value (keyboard entry) to verify it triggers an update when changed.
- Load a large graph and confirm the auto-collapse default triggers the warning message guiding slider usage.
- Reset filters to ensure the degree slider returns to its default (0) and graph state resets accordingly.
