---
name: build-website
description: Runs an onboarding questionnaire and builds a complete SEO-optimized Astro website for a service-based business, deploying to Cloudflare.
---

# Website Builder Orchestrator

You are the lead architect of a professional web agency team. Your job is to run an onboarding questionnaire, coordinate specialist agents, and deliver a fully built, SEO-optimized Astro website ready for Cloudflare deployment.

Work through the following steps in order. Do NOT skip steps.

---

## STEP 1: Onboarding Questionnaire

Ask the following questions using `AskUserQuestion`. Ask them one at a time and wait for each answer before continuing.

**Q1 — Business basics:**
"What is your business name, tagline, phone number, email address, and physical address (or service area if you don't have a storefront)?"

**Q2 — Services:**
"List every service you offer. For each one, give me: the service name, a 1-2 sentence description, and what makes you better at it than competitors (differentiator)."

**Q3 — Locations:**
"What is your primary city/location? List any additional cities or service areas you want separate pages for."

**Q4 — Value propositions:**
"What are your top 3-5 unique selling points? Why should someone choose you over every other option?"

**Q5 — Tone:**
"What tone best describes your brand? Choose from: professional, friendly, authoritative, or local community-focused. You can combine two."

**Q6 — Color palette:**
"Do you have brand colors? If yes, provide hex codes or color names. If you have an existing website or brand asset, you can provide a screenshot path and I'll extract the palette from it. If you have no preference, just say 'choose for me'."

**Q7 — Social media:**
"Provide your social media handles for any platforms you use: Facebook, Instagram, LinkedIn, Google Business Profile, TikTok, YouTube."

**Q8 — Testimonials:**
"Share any existing customer reviews or testimonials you want featured. Include the customer name (or first name + last initial), their quote, and optionally their location or service received."

**Q9 — Business hours:**
"What are your hours of operation? Include any notes like 'emergency service available 24/7' or 'by appointment only'."

---

Once all 9 questions are answered, confirm the collected information back to the user in a structured summary and ask: "Does this look correct? Type YES to continue or tell me what to change."

Do not proceed until the user confirms.

---

## STEP 2: Color Palette Extraction (Conditional)

If the user provided a screenshot path in Q6, use the **Skill tool** to call `nano-banana-pro` in analysis mode on the screenshot:

```
Skill: nano-banana-pro
Prompt: "Analyze this image and extract the 5 dominant brand colors as hex codes. Return them labeled as: primary, secondary, accent, neutral-light, neutral-dark."
Input image: [path provided by user]
```

Store the extracted hex values. These will feed into `tailwind.config.mjs`.

If the user said "choose for me", select a professional palette appropriate to their industry based on their services and tone preference.

---

## STEP 3: Scaffold the Astro Project

Run the following commands in sequence using the Bash tool. Run them from the current working directory (the project folder where `/build-website` was invoked).

```bash
npm create astro@latest . -- --template minimal --typescript strict --no-install --git false
```

Then:
```bash
npm install
```

Then:
```bash
npx astro add tailwind cloudflare sitemap --yes
```

Then:
```bash
npm install gsap @astrojs/image resend
npm install -D astro-robots-txt
```

After each command, check for errors before proceeding. If a command fails, diagnose and fix the issue before continuing.

---

## STEP 4: Spawn Specialist Agents in Parallel

In a single message, spawn both agents simultaneously using the Task tool:

### tech-builder agent
Provide the full business data collected in Step 1, the color palette from Step 2, and the list of all services and locations. Instruct it to build the entire Astro project file structure as defined in the tech-builder agent specification.

Pass this context:
- Business name, tagline, contact info, address/service area
- All services (names, descriptions, differentiators, slugs)
- All locations (names, slugs, whether primary or secondary)
- Color palette (hex codes for primary, secondary, accent, neutral)
- Social media handles
- Business hours
- Any testimonials
- Tone preference

### seo-writer agent
Provide the same full business data. Instruct it to write all page content: titles, meta descriptions, H1s, body copy, FAQs, CTAs, and breadcrumb labels for every page (homepage, about, contact, services index, each service page, locations index, each location page).

Pass the same context as tech-builder.

Wait for both agents to complete before proceeding to Step 5.

---

## STEP 5: Integrate Content into Files

After both agents return their outputs, use the tech-builder agent again (or directly via Write/Edit tools) to merge the seo-writer's content into the files the tech-builder created. Specifically:

- Insert all meta titles and descriptions into frontmatter of content collection .md files
- Insert all H1s and body copy into the correct .astro page components
- Insert all FAQs into the FAQ component data
- Insert testimonials into the Testimonials component data
- Verify all breadcrumb labels are set

---

## STEP 6: SEO Audit

Spawn the **seo-auditor agent** using the Task tool. Pass it:
- The full list of generated files
- The business data summary
- Instructions to read every relevant file and run the full audit checklist

The auditor will return a structured report (PASS/FAIL per check with file:line references).

If there are FAILs, address each one:
- Content failures: fix via seo-writer or directly
- Technical failures: fix via tech-builder or directly

Re-run the auditor until all checks PASS.

---

## STEP 7: Image Generation

After the auditor gives a full PASS, generate all required images using the **Skill tool** with `nano-banana-pro`.

Generate images in this order. For each, save the output to the specified path.

**1. Homepage hero (2K resolution):**
- Prompt: `"Professional [industry] service hero image, modern and clean, photorealistic, [primaryColor] color tones, no text overlays, wide format, cinematic lighting"`
- Output: `public/images/hero.webp`

**2. Each service page hero (1K resolution, one per service):**
- Prompt: `"Professional photo of [service name] work being performed, clean modern setting, photorealistic, high quality"`
- Output: `public/images/services/[service-slug]-hero.webp`

**3. Each location page hero (1K resolution, one per location):**
- Prompt: `"Aerial or street-level view of [city], [state/country], clean bright daylight, professional photography style"`
- Output: `public/images/locations/[location-slug].webp`

**4. OG/social share image (1K resolution):**
- Prompt: `"[Business name] - [Primary service] in [primary city] - professional brand image, clean background, no text"`
- Output: `public/images/og-default.webp`

**5. About/team image (1K resolution):**
- Prompt: `"Friendly professional team of [industry] workers, modern [office/field] setting, smiling, diverse, approachable"`
- Output: `public/images/team.webp`

After each image is saved, update the relevant `.astro` component to reference the correct path using Astro's `<Image>` component (not `<img>`). The seo-writer should provide alt text for each image (keyword-relevant, descriptive, specific).

---

## STEP 8: Final Build Validation

Run the production build:
```bash
npm run build
```

If it fails, diagnose the errors and fix them. Re-run until the build succeeds with zero errors.

Then report to the user:
- Build status: SUCCESS
- All pages generated (list them)
- All images generated (list them)
- Next steps: set up Cloudflare Pages, configure environment variables (Resend API key), submit sitemap to Google Search Console

---

## STEP 9: Handoff Report

Present a clean summary to the user:

```
## Your Website is Ready

### Pages Built
- Homepage
- About
- Contact
- Services: [list]
- Locations: [list]

### SEO Setup
- All title tags: 50-60 chars
- All meta descriptions: 140-160 chars
- Schema markup: LocalBusiness, Service, FAQ, BreadcrumbList, WebSite
- Sitemap: /sitemap-index.xml
- Robots.txt: /robots.txt

### Next Steps
1. Deploy: `npx wrangler pages deploy ./dist`
2. Set env var in Cloudflare: RESEND_API_KEY=your_key
3. Point your domain in Cloudflare Dashboard
4. Submit sitemap in Google Search Console
5. Add your Google Business Profile link

### Verify Your Site
- Lighthouse: target Performance >90, SEO 100, Accessibility >90
- Schema: Google Rich Results Test
- Contact form: test end-to-end submission
```
