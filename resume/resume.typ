#set page(
  margin: (
    x: 24pt,
    top: 26pt,
    bottom: 18pt,
  ),
)

#set text(
  font: "Merriweather",
  weight: "light",
  size: 10.4pt,
  tracking: 0.20pt,
)

#show heading: set text(
  weight: "regular",
)

#show heading.where(level: 1): set block(
  below: 16pt,
)

#show heading.where(level: 1): set text(
  size: 24pt,
)

#show heading.where(level: 2): set block(
  above: 24pt,
  below: 6pt,
)

#show heading.where(level: 2): set text(
  size: 13pt,
  ligatures: false,
)

#show heading.where(level: 2): it => {
  it
  v(-18pt)
  line(length: 100%, stroke: 0.8pt + black)
}

#show heading.where(level: 2): smallcaps

#show heading.where(level: 3): set text(
  size: 12pt,
)

#set par(
  leading: 9pt,
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

#align(center)[
  = Daniel Young

  Full-stack software engineer. 10+ years building web applications and
  distributed systems at scale.

  #link("https://www.linkedin.com/in/dansalias/")[linkedin.com/in/dansalias] \u{2B29}
  #link("https://github.com/dansalias")[github.com/dansalias] \u{2B29}
  #link("https://iamdan.me")[iamdan.me]
]

== Experience

#exp(
  [=== #strike(stroke: 0.75pt, extent: 1.2pt, offset: -3.4pt)[Unemployed] Sabbatical],
  [April 2023],
  [present],
)

#v(5pt)

Failed at 2 startup attempts. Travelled to 9 new countries. Currently learning
the full ML stack from warps to ops.

#exp([=== Senior Software Engineer], [May 2019], [April 2023])

LoveToKnow Media—Barcelona, Spain

Developed cross-product libraries and systems to improve engineering
productivity across websites and applications serving 200million+
pageviews/month.

- Enabled product teams to focus on feature development by consolidating 5
  discrete ad-tech implementations into a single monetisation stack managing
  monthly revenue of \$1million+.
- Ensured organisation-wide GDPR compliance by creating shared analytics and
  consent libraries.
- Accelerated product development by introducing a centralised design system.

#exp([=== Software Engineer], [February 2016], [May 2019])

Freelance—Auckland, New Zealand

Led frontend development of several web applications and sites in partnership
with local digital agencies:

- PrimePanels, creating a new website with interactive collection management.
- YourDrive, a peer-to-peer car rental app (discontinued).
- Quicksense Education dashboard, helping students master I/GCSE mathematics.
- MyBalance, allowing thousands of farmers to interactively optimise soil
  nutrients.
- movieXchange, streamlining media distribution and ticketing for cinemas
  worldwide.

#exp([=== Software Engineer], [January 2015], [January 2016])

Weirdly—Auckland, New Zealand

Built the Weirdly SaaS application, creating culture-fit quizzes for
multinational companies and 100,000+ candidates.

- Greatly improved reliability by scaling cloud architecture from a single VPS
  to multiple AWS services.
- Simplified backend development by architecting a live migration from SQL to
  MongoDB.
- Enhanced candidate profiling by integrating AI sentiment analysis (back in
  2015!).

#exp([=== Web Developer], [2007], [2014])

Auckland, New Zealand

- Developed a number of small business e-commerce websites.
- Founded an online farmer's market enabling \~20 local vendors to sell their
  products online.
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

#align(center + bottom)[
  #set text(
    size: 10pt,
  )

  #link("https://github.com/dansalias/iamdan.me/blob/trunk/resume/resume.typ")[
    VIEW SOURCE ON GITHUB
  ]
]
