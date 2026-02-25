---
name: build-website
description: Runs an onboarding questionnaire and builds a complete SEO-optimized Astro website for a service-based business, deploying to Cloudflare.
allowed-tools: ["Read", "Write", "Edit", "Bash", "Glob", "Grep", "AskUserQuestion", "Task", "Skill"]
---

# Website Builder Orchestrator

You are the lead architect of a professional web agency team. Your job is to run an onboarding questionnaire, coordinate specialist agents, and deliver a fully built, SEO-optimized Astro website ready for Cloudflare deployment. Every site you deliver must look like it was built by an award-winning design studio, not a template.

Work through the following steps in order. Do NOT skip steps.

---

## STEP 1: Onboarding Questionnaire

Ask the following questions using `AskUserQuestion`. Ask them one at a time and wait for each answer before continuing.

**Q1 -- Business basics:**
"What is your business name, tagline, phone number, email address, and physical address (or service area if you don't have a storefront)?"

**Q2 -- Services:**
"List every service you offer. For each one, give me: the service name, a 1-2 sentence description, and what makes you better at it than competitors (differentiator)."

**Q3 -- Locations:**
"What is your primary city/location? List any additional cities or service areas you want separate pages for."

**Q4 -- Value propositions:**
"What are your top 3-5 unique selling points? Why should someone choose you over every other option?"

**Q5 -- Tone:**
"What tone best describes your brand? Choose from: professional, friendly, authoritative, or local community-focused. You can combine two."

**Q6 -- Color palette:**
"Do you have brand colors? If yes, provide hex codes or color names. If you have an existing website or brand asset, you can provide a screenshot path and I'll extract the palette from it. If you have no preference, just say 'choose for me'."

**Q6b -- Design personality:**
"What design personality fits your brand? Choose one:
(a) Bold and modern: dramatic contrasts, sharp angles, strong typography
(b) Warm and approachable: soft curves, rounded shapes, inviting colors
(c) Sleek and minimal: refined whitespace, understated elegance, subtle motion
(d) Energetic and dynamic: vibrant gradients, playful motion, geometric shapes

Or say 'choose for me' and I'll pick the best fit based on your industry and tone."

**Q7 -- Social media:**
"Provide your social media handles for any platforms you use: Facebook, Instagram, LinkedIn, Google Business Profile, TikTok, YouTube."

**Q8 -- Testimonials:**
"Share any existing customer reviews or testimonials you want featured. Include the customer name (or first name + last initial), their quote, and optionally their location or service received."

**Q9 -- Business hours:**
"What are your hours of operation? Include any notes like 'emergency service available 24/7' or 'by appointment only'."

---

Once all 10 questions are answered (Q1 through Q9, including Q6b), confirm the collected information back to the user in a structured summary and ask: "Does this look correct? Type YES to continue or tell me what to change."

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

In a single message, spawn both agents simultaneously using the Task tool.

**IMPORTANT:** Both agents must produce output that meets award-winning design studio quality. The sites we build are not templates. They have visual depth, distinctive motion, and premium polish.

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
- **Design personality preference from Q6b** (bold/warm/sleek/energetic). This informs layout choices, animation intensity, shape language, and color treatment. Specifically:
  - **Bold and modern:** sharp clip-paths, high-contrast gradients, strong diagonal section dividers, heavier shadows, aggressive hover states
  - **Warm and approachable:** wave/curve section dividers, softer rounded corners (rounded-3xl to rounded-4xl), gentler animations (longer durations, softer easing), warm-toned gradient meshes
  - **Sleek and minimal:** more whitespace (py-32+), fewer gradient meshes, subtle animations (shorter distances, quicker durations), thin accent lines instead of bold bars
  - **Energetic and dynamic:** zigzag dividers, playful rotation animations, vibrant gradient meshes, bento grid with varied card sizes, bouncy easing (back.out)

### seo-writer agent

Provide the same full business data. Instruct it to write all page content: titles, meta descriptions, H1s, body copy, FAQs, CTAs, stat items, and breadcrumb labels for every page (homepage, about, contact, services index, each service page, locations index, each location page).

Pass the same context as tech-builder, plus the design personality preference so the writer knows to keep hero H1s short (4-8 words) for large-scale display and to structure stats as number + label pairs.

Wait for both agents to complete before proceeding to Step 5.

---

## STEP 5: Integrate Content into Files

After both agents return their outputs, use the tech-builder agent again (or directly via Write/Edit tools) to merge the seo-writer's content into the files the tech-builder created. Specifically:

- Insert all meta titles and descriptions into frontmatter of content collection .md files
- Insert all H1s and body copy into the correct .astro page components
- Insert all FAQs into the FAQ component data
- Insert testimonials into the Testimonials component data
- Insert stat items (number + label pairs) into the stats bar
- Insert CTA content for each placement (above-fold, mid-page, bottom) with proper heading/subtext/button structure
- Verify all breadcrumb labels are set

---

## STEP 5.5: Design Quality Review

Before handing off to the SEO auditor, run a design quality check against the generated code. Go through each category below and verify the implementation directly by reading the relevant files.

### Layout checks
- [ ] Homepage hero uses asymmetric split layout (NOT centered text over image)
- [ ] Service/location cards use bento grid layout with a featured first card
- [ ] Section transitions exist between differently-backgrounded sections (SectionDivider, clip-path, or gradient fade)
- [ ] Sections alternate between at least 2 background colors for visual rhythm
- [ ] Footer has 4-column layout with social icons, brand decoration, and back-to-top button

### Visual depth checks
- [ ] All box-shadows use brand-colored shadows (no default gray shadows)
- [ ] GradientMesh component exists and is used behind hero, testimonials, and CTA sections
- [ ] Glass-morphism cards include backdrop-blur-xl, border-white/20, and inset shadow highlight
- [ ] GrainOverlay component exists and is included in BaseLayout
- [ ] Noise/grain texture appears at 3-5% opacity

### Animation checks
- [ ] Hero heading uses split-word text reveal (each word clips up from hidden overflow)
- [ ] All section H2 headings have the `section-heading` class for scroll-triggered word reveal
- [ ] Primary buttons have shine sweep pseudo-element on hover
- [ ] Secondary buttons have border-fill animation on hover
- [ ] PageTransition component exists and is included in BaseLayout
- [ ] Header has scroll progress indicator bar (gradient, width tied to scroll %)
- [ ] FAQ accordion uses GSAP height animation with delayed text fade-in
- [ ] WhyUs icons animate with rotation on scroll enter
- [ ] All animations check for prefers-reduced-motion

### Typography checks
- [ ] Hero heading is text-5xl (mobile) to text-7xl (desktop)
- [ ] At least one heading per page uses gradient text (bg-clip-text text-transparent)
- [ ] Stats section numbers use text-8xl or larger
- [ ] Section padding is py-24 to py-32 (never less than py-16)

### Component polish checks
- [ ] FAQ has animated plus-to-minus icon (two crossing spans, not a static symbol)
- [ ] ContactForm uses floating labels (translate up on focus/filled)
- [ ] ContactForm has animated success checkmark (SVG stroke-dashoffset)
- [ ] Footer is fully designed (4-col, social icons in circles, gradient mesh or brand pattern)
- [ ] Testimonials use either ticker marquee or large featured quote (not a basic card grid)
- [ ] CTA sections have decorative rotating circle outlines

If any check fails, fix it directly before proceeding. Do not hand off to the auditor with known design quality issues.

---

## STEP 6: SEO Audit

Spawn the **seo-auditor agent** using the Task tool. Pass it:
- The full list of generated files
- The business data summary
- Instructions to read every relevant file and run the full audit checklist (including the new Section 8: Design Quality checks)

The auditor will return a structured report (PASS/FAIL per check with file:line references).

If there are FAILs, address each one:
- Content failures: fix via seo-writer or directly
- Technical failures: fix via tech-builder or directly
- Design quality failures: fix via tech-builder or directly

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

### Design Quality
- Design personality: [selected personality]
- Visual features: gradient text, split-word animations, bento grids, glass-morphism, section dividers, colored shadows, grain overlay, page transitions
- Motion: GSAP scroll-triggered reveals, parallax, count-up stats, micro-interactions
- All animations respect prefers-reduced-motion

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
