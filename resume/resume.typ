#set page(
  margin: (
    x: 24pt,
    top: 24pt,
    bottom: 20pt,
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
  above: 18pt,
)

#show heading.where(level: 2): set text(
  size: 13pt,
  ligatures: false,
)

#show heading.where(level: 2): s => {
  s
  v(-14pt)
  line(length: 100%, stroke: 0.8pt + black)
}

#show heading.where(level: 2): smallcaps

#set par(
  leading: 7pt,
)

#show link: set text(fill: rgb("#4287f5"))

#let delim = "\u{2B29}"

#let strong(s) = text(weight: "medium", size: 1.1em, s)

#let exp(title, company, location, start, end, content) = block(
  below: 18pt,
  [
    #grid(
      columns: (7fr, 3fr),
      align: (left, right),
      inset: (bottom: -4pt),
      [
        #strong[#title]
        #if company != none [ #delim #company ]
        #if location != none [ #delim #location ]
      ],
      [
        #set text(
          style: "italic",
        )
        #start–#end
      ],
    )
    #content
  ]
)

#let proj(name, url, description) = [
  #strong[#link(url)[#name]] — #description
]

#align(center)[
  = Daniel Young

  Full-stack software engineer. 10+ years building web applications and
  distributed systems at scale.

  #link("https://www.linkedin.com/in/dansalias/")[linkedin.com/in/dansalias] #delim
  #link("https://github.com/dansalias")[github.com/dansalias] #delim
  #link("https://iamdan.me")[iamdan.me]
]

== Experience

#exp(
  [#strike(stroke: 0.75pt, extent: 1.2pt, offset: -3.4pt)[Unemployed] Sabbatical],
  none, none,
  [April 2023],
  [present],
  [
    Failed at 2 startup attempts. Travelled to 9 new countries. Currently
    learning the full ML stack from warps to ops.
  ]
)


#exp(
  "Senior Software Engineer",
  "LoveToKnowMedia",
  "Barcelona, Spain",
  [May 2019],
  [April 2023],
  [
    Developed cross-product libraries and systems to improve engineering
    productivity across websites and applications serving 200million+
    pageviews/month.

    - Enabled product teams to focus on feature development by consolidating 5
      discrete ad-tech implementations into a single monetisation stack managing
      monthly revenue of \$1million+.
    - Ensured organisation-wide GDPR compliance by creating shared analytics and
      consent libraries.
    - Accelerated product development by creating a centralised design system.
    - Further empowered product teams by introducing platform engineering and
      IaC via the AWS CDK.
  ],
)

#exp(
  "Software Engineer",
  "Freelance",
  "Auckland, New Zealand",
  [February 2016],
  [May 2019],
  [
    Led frontend development of several web applications and sites in
    partnership with local digital agencies, specialising in building SPAs with
    React and Vue:

    - PrimePanels, creating a new website with interactive collection
      management.
    - YourDrive, a peer-to-peer car rental app (discontinued).
    - Quicksense Education dashboard, helping students master I/GCSE
      mathematics.
    - MyBalance, allowing thousands of farmers to interactively optimise soil
      nutrients.
    - movieXchange, streamlining media distribution and ticketing for cinemas
      worldwide.
  ],
)


#exp(
  "Software Engineer",
  "Weirdly",
  "Auckland, New Zealand",
  [January 2015],
  [January 2016],
  [
    Built the Weirdly SaaS application, creating culture-fit quizzes for
    multinational companies and 100,000+ candidates.

    - Administered the Linux server and databases, including a live migration
      from SQL to MongoDB.
    - Scaled from dozens to thousands of users by re-architecting from a single
      VPS to multiple AWS services.
    - Greatly improved developer experience by introducing Docker and CI/CD.
    - Improved API performance by modernising a PHP monolith and replacing key
      endpoints with Node.js microservices.
    - Enhanced candidate profiling by integrating AI sentiment analysis (back in
      2015!).
  ],
)

#exp(
  "Web Developer",
  none,
  "Auckland, New Zealand",
  [2007],
  [2014],
  [
    - Created a number of small business e-commerce websites.
    - Founded an online farmer's market enabling \~20 local vendors to sell
      their products online.
    - Launched a web hosting company while in high school.
  ],
)

== Projects

#proj(
  "784.ai",
  "https://784.ai",
  [
    Browser-based MNIST neural network demo using TypeScript + Svelte and
    trained in Rust.
  ],
)
#proj(
  "numble.cc",
  "https://numble.cc",
  "Wordle-inspired number game for ~500 daily players.",
)

== Qualifications

#grid(
  columns: (7fr, 3fr),
  align: (left, right),
  inset: (bottom: -4pt),
  [#strong[Bachelor of Engineering (Mechanical)]],
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
