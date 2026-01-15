#set page(
  margin: (
    x: 36pt,
    y: 32pt,
  ),
)

#set text(
  font: "Merriweather",
  weight: "light",
  size: 12pt,
  tracking: 0.25pt,
)

#show heading: set block(
  below: 18pt,
)

#show heading: set text(
  size: 28pt,
  weight: "regular",
)

#show heading.where(level: 2): set block(
  above: 36pt,
  below: 16pt,
)

#show heading.where(level: 2): set text(
  size: 22pt,
)

#show heading.where(level: 3): set text(
  size: 16pt,
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
  [=== #strike(stroke: 1.4pt, extent: 1.2pt, offset: -5pt)[Unemployed] Sabbatical],
  [April 2023],
  [present],
)

#v(5pt)

Failed at 2 startup attempts. Travelled to 7 new countries. Currently learning
Rust and experimenting with machine learning with a focus on better code
generation.

#exp([=== Senior Frontend Engineer], [May 2019], [April 2023])

LoveToKnow Media—Barcelona, Spain

- Built news and reference products serving 100 million pageviews/month.
- Managed a cross-product advertising library responsible for \$1million/month
  revenue.
- Updated sites and advertising integrations for GDPR compliance.
- Migrated production sites to a centralised design system to ease product
  workloads.

#exp([=== Frontend Developer], [February 2016], [May 2019])

Freelance—Auckland, New Zealand

- Led frontend development of the YourDrive peer-to-peer car rental app
  (discontinued).
- Built the client dashboard for Quicksense Education.
- Developed the user dashboard for MyBalance in partnership with Dow Goodfolk.
- Built movieXchange with Phosphor Essence.

#exp([=== Backend Developer], [January 2015], [January 2016])

Weirdly—Auckland, New Zealand

Led backend development of the Weirdly SaaS application, creating culture-fit
quizzes for multinational companies and 100,000+ candidates.

- Architected and led a live migration from SQL to MongoDB.
- Built the recurring billing system and merchant banking integration.
- Integrated AI sentiment analysis.

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
    size: 11pt,
  )

  #link("https://github.com/dansalias/iamdan.me/blob/trunk/resume/resume.typ")[
    VIEW SOURCE ON GITHUB
  ]
]
