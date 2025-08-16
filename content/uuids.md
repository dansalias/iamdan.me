---
title: You Probably Don't Need UUIDs
date: 2021-10-10
---

{% aside() %}
  ### What's a UUID?

  A UUID is a 128-bit 'universally unique identifier', typically represented as a
  36-character hyphenated hex string (e.g. `01234567-89ab-cdef-0123-456789abcdef`).
  [&raquo; Wikipedia](https://en.wikipedia.org/wiki/Universally_unique_identifier)
{% end %}

UUIDs are great. There are packages to generate them in every major language and
generating 1 million (v4) every second it will take ~83,000 years until there's
a 1% chance of two being equal. This makes them great for defending against
dictionary attacks (where guessing a UUID would be a security threat).

But in most instances UUIDs are overkill. They add unnecessary parsing and
storage overhead[^1], they lead to unwieldy URLs, and they're impractical to
share over the phone. Often a much shorter id string is more fit for purpose.

Here's a TypeScript snippet for generating n-character alphanumeric (only
lowercase) pseudo-random strings. Sticking to lowercase makes verbal
communication much easier.

```ts
const createAlphanumericId = (length: number): string => {
  return Array.from({ length }, () =>
    Math.floor(
      Math.random() * 36
    ).toString(36)
  ).join('')
}
```

[^1]: Though they can be compressed to 16 bytes, more often than not UUIDs are stored in their 36-byte encoded string form.
