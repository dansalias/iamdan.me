interface Experience {
  title: string
  company: string
  location: string
  startDate: Date
  endDate: Date
  details: {
    summary: string
    bullets?: string[]
  }
}

interface Qualification {
  title: string
  institution: string
  date: string
}

interface Link {
  url: string
  display: string
}

interface Resume {
  name: string
  blurb: string
  experience: Experience[]
  qualifications: Qualification[]
  links: Link[]
}

export const resume: Resume = {
  name: 'Daniel Young',
  blurb: `
    Full Stack Software Engineer currently based in London.

    8 years experience building SaaS with a focus on AWS, TypeScript, and Vue.
  `,
  experience: [
    {
      title: 'Senior Frontend Engineer',
      company: 'LoveToKnow Media',
      location: 'Barcelona, Spain',
      startDate: new Date(2019, 4),
      endDate: new Date(2023, 3),
      details: {
        summary: 'Frontend Engineer for a number of consumer websites built with Vue and Nuxt.',
        bullets: [
          'Built news and reference products serving 100 million pageviews/month.',
          'Managed a cross-product digital advertising solution responsible for $1million/month revenue.',
          'Created dashboards and data pipelines using Google Data Studio and BigQuery for A/B testing and optimising web performance.',
        ],
      },
    },
    {
      title: 'Frontend Engineer',
      company: 'Freelance',
      location: 'Auckland, New Zealand',
      startDate: new Date(2016, 1),
      endDate: new Date(2019, 4),
      details: {
        summary: 'Freelance developer for a number of web projects.',
        bullets: [
          'Contributed to the YourDrive NZ peer-to-peer car rental app (discontinued).',
          'Built a new website for [Bachcare](https://bachcare.co.nz/) and the client dashboard for [Quicksense Education](https://quicksense.org/) using React.',
          'Led frontend development of the [PrimePanels](https://primepanels.co.nz) website, the user dashboard for [MyBallance](https://ballance.co.nz/myballance), and the [movieXchange](https://moviexchange.com) site.',
        ],
      },
    },
    {
      title: 'Backend Engineer',
      company: 'Weirdly',
      location: 'Auckland, New Zealand',
      startDate: new Date(2015, 0),
      endDate: new Date(2016, 0),
      details: {
        summary: 'Lead backend developer of the [Weirdly](https://getweirdly.com) SaaS application, creating culture-fit quizzes for multinational companies and thousands of candidates.',
        bullets: [
          'Architected and led a live migration from SQL to MongoDB.',
          'Built a recurring billing system.',
          'Created integrations for job boards and applicant tracking systems.',
          'Integrated AI sentiment analysis using IBM Watson.',
        ],
      },
    },
  ],
  qualifications: [
    {
      title: 'Bachelor of Engineering (Mechanical)',
      institution: 'The University of Auckland',
      date: 'Graduated 2016',
    },
  ],
  links: [
    {
      url: 'https://www.linkedin.com/in/dansalias/',
      display: 'linkedin.com/in/dansalias',
    },
    {
      url: 'https://iamdan.me',
      display: 'iamdan.me',
    },
    {
      url: 'https://github.com/dansalias',
      display: 'github.com/dansalias',
    },
  ],
}
