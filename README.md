# Astro SEO Website Builder

A Claude Code plugin that acts as a full web agency team. Run one command and get a complete, production-ready, SEO-optimized Astro website for any service-based business, deployed to Cloudflare.

## What it builds

- Full Astro project with Tailwind CSS, Cloudflare Pages adapter, sitemap, robots.txt
- Every page: homepage, about, contact, service pages, location pages
- Schema markup: LocalBusiness, Service, FAQ, BreadcrumbList, WebSite
- GSAP animations: hero entrance, scroll reveals, stat counters, card staggering
- Contact form with Cloudflare Workers backend via Resend
- AI-generated WebP images for every hero, OG image, and team photo
- `llms.txt` for AI crawler readability

## Prerequisites

- [Claude Code](https://claude.ai/code) installed
- Node.js 18+
- A Cloudflare account (free tier works)
- A [Resend](https://resend.com) account for contact form email delivery
- The `nano-banana-pro` skill active in Claude Code (for AI image generation)

## Install

One command:

```bash
curl -sL https://raw.githubusercontent.com/NicoSKOOL/astro-seo-website-builder/main/install.sh | bash
```

Restart Claude Code after installing.

## Usage

1. Create a new empty folder for your client's project
2. Open it in Claude Code
3. Run `/build-website`
4. Answer 9 onboarding questions about the business
5. Watch the agents build the full site

The plugin spawns three specialist agents:

| Agent | Role |
|-------|------|
| `tech-builder` | Builds all Astro files, components, schemas, config |
| `seo-writer` | Writes all content: titles, metas, body copy, FAQs, CTAs |
| `seo-auditor` | Runs a full PASS/FAIL audit before images are generated |

## What gets asked in onboarding

1. Business name, tagline, phone, email, address
2. Services offered (with descriptions and differentiators)
3. Locations/cities served
4. Value propositions and USPs
5. Brand tone (professional, friendly, authoritative, local)
6. Color palette (hex codes, screenshot, or "choose for me")
7. Social media handles
8. Existing reviews/testimonials
9. Hours of operation

## Deploy to Cloudflare

After the build completes:

```bash
npx wrangler pages deploy ./dist
```

Then in Cloudflare Dashboard:
- Point your domain
- Add `RESEND_API_KEY` environment variable
- Submit `/sitemap-index.xml` to Google Search Console

## Quality targets

After deploy, run Lighthouse. The plugin is built to hit:

- Performance: >90
- SEO: 100
- Accessibility: >90

## Updating the plugin

Run the install script again to get the latest version:

```bash
curl -sL https://raw.githubusercontent.com/NicoSKOOL/astro-seo-website-builder/main/install.sh | bash
```

## Plugin structure

```
.claude/plugins/website-builder/
├── plugin.json
├── commands/
│   └── build-website.md      (orchestrator)
└── agents/
    ├── tech-builder.md
    ├── seo-writer.md
    └── seo-auditor.md
```

## License

MIT
