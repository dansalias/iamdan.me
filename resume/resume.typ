#set page(
  margin: (
    x: 24pt,
    top: 24pt,
    bottom: 12pt,
  ),
)

#set text(
  font: "Merriweather",
  weight: "light",
  size: 10.4pt,
  tracking: 0.20pt,
)

#show heading: set block(
  below: 12pt,
)

#show heading: set text(
  size: 24pt,
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
  spacing: 14pt,
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

    #text(size: 15pt)[
      Software Engineer
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

Failed at 2 startup attempts. Travelled to 7 new countries. Currently learning
the full ML stack from warps to ops.

#exp([=== Senior Software Engineer], [May 2019], [April 2023])

LoveToKnow Media—Barcelona, Spain

- Created and managed the cross-product monetisation stack.
- Led analytics and advertising updates for GDPR compliance.
- Built a centralised design system to simplify and accelerate product
  development.
- Introduced real-time performance monitoring to keep up with Core Web Vitals
  SEO ranking factors.

#exp([=== Software Engineer], [February 2016], [May 2019])

Freelance—Auckland, New Zealand

Led frontend development of:

- PrimePanels, creating a new website with interactive collection management.
- YourDrive, a peer-to-peer car rental app (discontinued).
- Quicksense Education dashboard, helping students master I/GCSE mathematics.
- MyBalance, allowing thousands of farmers to interactively optimise soil
  nutrients.
- movieXchange, streamlining media distribution and ticketing for cinemas
  worldwide.

#exp([=== Software Engineer], [January 2015], [January 2016])

Weirdly—Auckland, New Zealand

Led backend development of the Weirdly SaaS application, creating culture-fit
quizzes for multinational companies and 100,000+ candidates.

- Architected and led a live migration from SQL to MongoDB.
- Built the recurring billing system and merchant banking integration.
- Integrated AI sentiment analysis (back in 2015!).

#exp([=== Web Developer], [2007], [2014])

Auckland, New Zealand

- Built a number of small business e-commerce websites.
- Created and managed an online farmers market for \~20 local vendors.
- Launched a web hosting company while in high school.

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
