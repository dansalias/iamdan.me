<template>
  <h1>{{ resume.name }}</h1>
  <div v-md="resume.blurb"></div>
  <h2>Experience</h2>
  <ul>
    <li v-for="experience in resume.experience" class="mt-4 mb-8">
      <div class="grid grid-cols-2 mb-2">
        <div>
          <h3>{{ experience.title }}</h3>
          <div>{{ formatDate(experience.startDate) }} - {{ formatDate(experience.endDate) }}</div>
        </div>
        <div class="text-right">
          <div>{{ experience.company }}</div>
          <div>{{ experience.location }}</div>
        </div>
      </div>
      <p v-md.inline="experience.details.summary"/>
      <ul class="my-2 ml-6 list-disc" v-if="experience.details.bullets?.length">
        <li
          v-for="bullet in experience.details.bullets"
          v-md.inline="bullet"
        />
      </ul>
    </li>
  </ul>
  <h2>Qualifications</h2>
  <ul>
    <li v-for="qualification in resume.qualifications" class="mt-4 mb-8">
      <div class="grid grid-cols-2">
        <div>
          <h3>{{ qualification.title }}</h3>
          <div>{{ qualification.date }}</div>
        </div>
        <div class="text-right">
          <div>{{ qualification.institution }}</div>
        </div>
      </div>
    </li>
  </ul>
  <footer>
    <ul class="mt-12 flex w-full justify-center gap-8">
      <li v-for="link in resume.links">
        <a :href="link.url">{{ link.display }}</a>
      </li>
    </ul>
  </footer>
</template>

<script lang="ts" setup>
  import type { Directive } from 'vue'
  import { marked } from 'marked'
  import { resume } from './data'

  marked.use({
    hooks: {
      preprocess: md => md.trim().replace(/[^\S\r\n]{2,}/g, ''),
      postprocess: md => md,
    },
  })

  const vMd: Directive = {
    mounted: (element, binding) => {
      element.innerHTML = binding.modifiers.inline ?
        marked.parseInline(binding.value) :
        marked.parse(binding.value)
    },
  }

  const formatDate = (date: Date) => date.toLocaleString('en-US', {
    month: 'short',
    year: 'numeric',
  })
</script>
