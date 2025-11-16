# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a bio-links application built with Astro - a personal landing page for sharing multiple links (similar to Linktree). The project uses Astro's minimal template with TailwindCSS v4 for styling and astro-icon for icon support.

## Development Commands

All commands use `bun` as the package manager:

- `bun install` - Install dependencies
- `bun dev` - Start development server at `localhost:4321`
- `bun build` - Build production site to `./dist/`
- `bun preview` - Preview production build locally
- `bun astro ...` - Run Astro CLI commands (e.g., `bun astro add`, `bun astro check`)

## Architecture

### Tech Stack

- **Framework**: Astro 5.x (static site generator with islands architecture)
- **Styling**: TailwindCSS v4 (using @tailwindcss/vite plugin)
- **Icons**: astro-icon for SVG icon management
- **TypeScript**: Configured with Astro's strict tsconfig

### Project Structure

- `src/pages/` - File-based routing; each `.astro` or `.md` file becomes a route
- `src/components/` - Reusable Astro/framework components (create as needed)
- `public/` - Static assets served directly (images, fonts, etc.)
- `dist/` - Build output directory (excluded from git)

### Key Configuration Files

- `astro.config.mjs` - Astro configuration with icon integration
- `tsconfig.json` - TypeScript config extending Astro's strict preset
- `package.json` - Uses ES modules (`"type": "module"`)

### Astro-Specific Notes

- Astro uses a "component islands" architecture - components are static by default unless marked interactive
- The frontmatter section (between `---`) in `.astro` files runs at build time (server-side)
- Currently only has `index.astro` page; add new pages in `src/pages/` for additional routes
- TailwindCSS v4 is integrated via Vite plugin (modern approach, different from v3 setup)
