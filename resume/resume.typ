#set page(
  margin: (
    x: 36pt,
    top: 36pt,
    bottom: 22pt,
  ),
)

#set text(
  font: "Merriweather",
  weight: "light",
  size: 11.6pt,
  tracking: 0.22pt,
)

#show heading: set block(
  below: 16pt,
)

#show heading: set text(
  size: 28pt,
  weight: "regular",
)

#show heading.where(level: 2): set block(
  above: 24pt,
  below: 12pt,
)

#show heading.where(level: 2): set text(
  size: 19pt,
)

#show heading.where(level: 3): set text(
  size: 14pt,
)

#set par(
  leading: 9pt,
  spacing: 16pt,
)

#show link: set text(fill: rgb("#4287f5"))

#let exp(title, start, end) = {
  grid(
    columns: (2fr, 1fr),
    inset: (top: 6pt, bottom: -5pt),
    align: (left, right),
    [#title],
    [
      #set text(
        style: "italic",
      )
      #start–#end
    ],
  )
}

#grid(
  columns: (1fr, 1fr),
  align: (left, right),
  [
    = Daniel Young

    #text(size: 16pt)[
      Full Stack Software Engineer
    ]
  ],
  [
    #set par(
      spacing: 8pt,
    )

    #link("https://www.linkedin.com/in/dansalias/")[linkedin.com/in/dansalias]

    #link("https://github.com/dansalias")[github.com/dansalias]

    #link("https://iamdan.me")[iamdan.me]
  ]
)

10+ years building SaaS—primarily with TypeScript, Vue, Node, Linux, Docker and
AWS.

== Experience

#exp(
  [=== #strike(stroke: 1.4pt, extent: 1.2pt, offset: -4pt)[Unemployed] Sabbatical],
  [April 2023],
  [present],
)

#v(5pt)

Failed at 2 startup attempts. Travelled to 7 new countries. Added Rust to the
toolbox. Currently learning ML from the ground up and determined to help shape
the future of software engineering for the better.

#exp([=== Senior Frontend Engineer], [May 2019], [April 2023])

LoveToKnow Media—Barcelona, Spain

- Consolidated 5 discrete advertising implementations into a single shared
  library.
- Led analytics and advertising updates for GDPR compliance.
- Built a centralised design system to simplify and accelerate product
  development.
- Introduced real-time performance monitoring to keep up with Core Web Vitals
  SEO ranking factors.

#exp([=== Frontend Developer], [February 2016], [May 2019])

Freelance—Auckland, New Zealand

Led frontend development of:

- PrimePanels, creating a new website with interactive collection management.
- YourDrive, a peer-to-peer car rental app (discontinued).
- Quicksense Education dashboard, helping students master I/GCSE mathematics.
- MyBalance, allowing thousands of farmers to interactively optimise soil
  nutrients.
- movieXchange, streamlining media distribution and ticketing for cinemas
  worldwide.

#exp([=== Backend Developer], [January 2015], [January 2016])

Weirdly—Auckland, New Zealand

Led backend development of the Weirdly SaaS application, creating culture-fit
quizzes for multinational companies and 100,000+ candidates.

- Architected and led a live migration from SQL to MongoDB.
- Built the recurring billing system and merchant banking integration.
- Integrated AI sentiment analysis (back in 2015!).

== Qualifications

#grid(
  columns: (2fr, 1fr),
  inset: (top: 6pt, bottom: -5pt),
  align: (left, right),
  [=== Bachelor of Engineering (Mechanical)],
  [_Graduated 2016_]
)

#grid(
  columns: (1fr, 1fr),
  align: (left, right),
  [The University of Auckland],
)

// == Fun Facts
// - Launched a web hosting company in high school.
// - Lived and worked in 5 countries (and travelled to an additional 32).
// - Hand-types em dashes and eats slices of cake the other way 'round.

#align(center + bottom)[
  #set text(
    size: 10pt,
  )

  #link("https://github.com/dansalias/iamdan.me/blob/trunk/resume/resume.typ")[
    VIEW SOURCE ON GITHUB
  ]
]
