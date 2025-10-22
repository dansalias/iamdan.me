+++
title = "Iso(and Di/Tri)metric Projection in SVGs"
date = 2025-10-21

[extra]
math = true
alpine = true
+++

<script>
  document.addEventListener('alpine:init', () => {
    const xy = (x, y, z) => [
      (x - y) * Math.cos(Math.PI / 6),
      (x + y) * Math.sin(Math.PI / 6) - z,
    ]

    Alpine.data('units', () => {
      const
        u = 24,
        cos = Math.cos(Math.PI / 6),
        sin = Math.sin(Math.PI / 6)

      return {
        u,
        cos,
        sin,
        xu: u * cos,
        yu: u * sin,
      }
    })

    Alpine.data('pyramid', () => ({
      front: [
        [0, 0, 1.4],
        [0.7, 0.7, 0],
        [-0.7, 0.7, 0],
      ].map(xyz => xy(...xyz).map(v => v * 24).join(',')).join(' '),
      right: [
        [0, 0, 1.4],
        [0.7, -0.7, 0],
        [0.7, 0.7, 0],
      ].map(xyz => xy(...xyz).map(v => v * 24).join(',')).join(' '),
    }))

    Alpine.data('viewingAngle', () => {
      const
        azimuth = Math.PI / 12,
        elevation = Math.atan(Math.sin(Math.PI / 6)),
        xy_va = (x, y, z, azimuth, elevation) => [
          (x - y) * Math.cos(Math.PI / 6),
          (x + y) * Math.sin(Math.PI / 6) - z,
        ]

      return {
        matrices: {
          xy: offset => [
            Math.cos(azimuth),
            Math.sin(azimuth) * Math.sin(elevation),
            -Math.sin(azimuth),
            Math.cos(azimuth) * Math.sin(elevation),
            0,
            -Math.cos(elevation) * offset,
          ],
          xz: offset => [
            Math.cos(azimuth),
            Math.sin(azimuth) * Math.sin(elevation),
            0,
            Math.cos(elevation),
            -Math.sin(azimuth) * offset,
            Math.cos(azimuth) * Math.sin(elevation) * offset,
          ],
          yz: offset => [
            Math.sin(azimuth),
            -Math.cos(azimuth) * Math.sin(elevation),
            0,
            Math.cos(elevation),
            Math.cos(azimuth) * offset,
            Math.sin(azimuth) * Math.sin(elevation) * offset,
          ],
          vertical: [
            Math.cos(azimuth + Math.PI / 4),
            Math.sin(azimuth + Math.PI / 4) * Math.sin(elevation),
            0,
            Math.cos(elevation),
            0,
            0,
          ],
        },
      }
    })

    Alpine.data('widget', () => {
      return {
        matrices: (azimuth, elevation) => ({
          xy: offset => [
            Math.cos(azimuth * (Math.PI / 180)),
            Math.sin(azimuth * (Math.PI / 180)) * Math.sin(elevation * (Math.PI / 180)),
            -Math.sin(azimuth * (Math.PI / 180)),
            Math.cos(azimuth * (Math.PI / 180)) * Math.sin(elevation * (Math.PI / 180)),
            0,
            -Math.cos(elevation * (Math.PI / 180)) * offset,
          ],
          xz: offset => [
            Math.cos(azimuth * (Math.PI / 180)),
            Math.sin(azimuth * (Math.PI / 180)) * Math.sin(elevation * (Math.PI / 180)),
            0,
            Math.cos(elevation * (Math.PI / 180)),
            -Math.sin(azimuth * (Math.PI / 180)) * offset,
            Math.cos(azimuth * (Math.PI / 180)) * Math.sin(elevation * (Math.PI / 180)) * offset,
          ],
          yz: offset => [
            Math.sin(azimuth * (Math.PI / 180)),
            -Math.cos(azimuth * (Math.PI / 180)) * Math.sin(elevation * (Math.PI / 180)),
            0,
            Math.cos(elevation * (Math.PI / 180)),
            Math.cos(azimuth * (Math.PI / 180)) * offset,
            Math.sin(azimuth * (Math.PI / 180)) * Math.sin(elevation * (Math.PI / 180)) * offset,
          ],
        }),
      }
    })
  })
</script>

<style>
  svg {
    width: 100%;
    max-width: 25rem;
  }

  line {
    stroke: #000000bb;
    stroke-width: 1;
    stroke-linecap: round;

    &.guideline {
      stroke-width: 0.4;
      stroke-dasharray: 2;
      stroke: #00000022;
    }

    &.extension {
      stroke-width: 0.4;
      stroke: #000000;
    }
  }

  text {
    font: 0.8rem KaTeX_Math, serif;
    text-anchor: middle;
    dominant-baseline: middle;

    &.small {
      font-size: 0.6rem;
    }

    &.x-small {
      font-size: 0.4rem;
    }
  }

  .interactive {
    margin: 2rem auto;
    width: 100%;
    max-width: 25rem;

    display: grid;
    grid-template: auto 2rem / auto 4rem;
    justify-items: center;
    align-items: center;

    svg {
      width: 100%;
    }

    .slider {
      position: relative;

      display: flex;
      justify-content: center;
      align-items: center;

      label {
        position: absolute;
        left: 0;
        top: 1.5rem;

        writing-mode: horizontal-tb;
        direction: ltr;
      }

      &.vertical {
        writing-mode: vertical-lr;
        direction: rtl;

        input[type="range"] {
          appearance: slider-vertical;
          width: 1rem;
        }

        label {
          left: 1.5rem;
        }
      }
    }
  }
</style>

<svg width="0" height="0" viewBox="-64 -46 128 92" x-data>
  <defs>
    <filter id="brightness-60">
      <feComponentTransfer>
        <feFuncR type="linear" slope="0.6"/>
        <feFuncG type="linear" slope="0.6"/>
        <feFuncB type="linear" slope="0.6"/>
      </feComponentTransfer>
    </filter>
    <filter id="brightness-70">
      <feComponentTransfer>
        <feFuncR type="linear" slope="0.7"/>
        <feFuncG type="linear" slope="0.7"/>
        <feFuncB type="linear" slope="0.7"/>
      </feComponentTransfer>
    </filter>
    <filter id="brightness-80">
      <feComponentTransfer>
        <feFuncR type="linear" slope="0.8"/>
        <feFuncG type="linear" slope="0.8"/>
        <feFuncB type="linear" slope="0.8"/>
      </feComponentTransfer>
    </filter>
    <filter id="brightness-90">
      <feComponentTransfer>
        <feFuncR type="linear" slope="0.9"/>
        <feFuncG type="linear" slope="0.9"/>
        <feFuncB type="linear" slope="0.9"/>
      </feComponentTransfer>
    </filter>
    <g>
      <radialGradient id="feather" cx="50%" cy="50%" r="50%">
        <stop offset="0%" stop-color="#ffffff" stop-opacity="1"/>
        <stop offset="70%" stop-color="#ffffff" stop-opacity="1"/>
        <stop offset="100%" stop-color="#ffffff" stop-opacity="0"/>
      </radialGradient>
      <mask id="feather-mask">
        <rect x="-50%" y="-50%" width="100%" height="100%" fill="url(#feather)"/>
      </mask>
    </g>
    <g>
      <pattern id="grid-3d" :width="2 * 24 * Math.cos(Math.PI / 6)" height="24" patternUnits="userSpaceOnUse">
        <line x1=0 y1=0 :x2="2 * 24 * Math.cos(Math.PI / 6)" y2="24" style="stroke: #99999922"/>
        <line x1=0 y1=24 :x2="2 * 24 * Math.cos(Math.PI / 6)" y2="0" style="stroke: #99999922"/>
      </pattern>
      <rect id="bg-3d" x="-50%" y="-50%" width="100%" height="100%" fill="url(#grid-3d)" mask="url(#feather-mask)" />
    </g>
    <g>
      <pattern id="grid-2d" width="24" height="24" patternUnits="userSpaceOnUse">
        <rect x="0" y="0" width="24" height="24" fill="none" stroke="#99999922"/>
      </pattern>
      <rect id="bg-2d" x="-50%" y="-50%" width="100%" height="100%" fill="url(#grid-2d)" mask="url(#feather-mask)"/>
    </g>
    <path
      id="arrow-head"
      d="M 1 1 L 9 5 L 1 9 z"
      stroke="#000000"
      stroke-linecap="round"
      stroke-linejoin="round"
    />
    <marker
      id="arrow"
      viewBox="0 0 10 10"
      refX="8"
      refY="5"
      markerWidth="6"
      markerHeight="6"
      orient="auto-start-reverse"
    >
      <use href="#arrow-head"/>
    </marker>
    <marker
      id="arrow-exact"
      viewBox="0 0 10 10"
      refX="9.8"
      refY="5"
      markerWidth="6"
      markerHeight="6"
      orient="auto-start-reverse"
    >
      <use href="#arrow-head"/>
    </marker>
    <g id="axes-3d">
      <line
        x1="0"
        y1="0"
        :x2="24 * Math.cos(Math.PI / 6)"
        :y2="24 * Math.sin(Math.PI / 6)"
        marker-end="url(#arrow)"
      />
      <line
        x1="0"
        y1="0"
        :x2="-24 * Math.cos(Math.PI / 6)"
        :y2="24 * Math.sin(Math.PI / 6)"
        marker-end="url(#arrow)"
      />
      <line
        x1="0"
        y1="0"
        :x2="0"
        :y2="-24"
        marker-end="url(#arrow)"
      />
    </g>
    <g id="axes-3d-labelled">
      <use href="#axes-3d"/>
      <text :x="32 * Math.cos(Math.PI / 6)" :y="32 * Math.sin(Math.PI / 6)">x</text>
      <text :x="-32 * Math.cos(Math.PI / 6)" :y="32 * Math.sin(Math.PI / 6)">y</text>
      <text :x="0" :y="-32">z</text>
    </g>
    <g id="axes-3d-positive">
      <use href="#axes-3d"/>
      <text :x="34 * Math.cos(Math.PI / 6)" :y="34 * Math.sin(Math.PI / 6)">+x</text>
      <text :x="-34 * Math.cos(Math.PI / 6)" :y="34 * Math.sin(Math.PI / 6)">+y</text>
      <text :x="0" :y="-32">+z</text>
    </g>
    <g id="axes-3d-negative" opacity="0.4">
      <line
        x1="0"
        y1="0"
        :x2="-24 * Math.cos(Math.PI / 6)"
        :y2="-24 * Math.sin(Math.PI / 6)"
        stroke-dasharray="2"
        marker-end="url(#arrow)"
      />
      <text
        :x="-32 * Math.cos(Math.PI / 6)"
        :y="-32 * Math.sin(Math.PI / 6)"
      >-x</text>
      <line
        x1="0"
        y1="0"
        :x2="24 * Math.cos(Math.PI / 6)"
        :y2="-24 * Math.sin(Math.PI / 6)"
        stroke-dasharray="2"
        marker-end="url(#arrow)"
      />
      <text
        :x="32 * Math.cos(Math.PI / 6)"
        :y="-32 * Math.sin(Math.PI / 6)"
      >-y</text>
      <line
        x1="0"
        y1="0"
        :x2="0"
        :y2="24"
        stroke-dasharray="2"
        marker-end="url(#arrow)"
      />
      <text
        :x="0"
        :y="30"
      >-z</text>
    </g>
    <g id="axes-2d">
      <line
        x1="0"
        y1="0"
        :x2="24"
        :y2="0"
        marker-end="url(#arrow)"
      />
      <line
        x1="0"
        y1="0"
        :x2="0"
        :y2="24"
        marker-end="url(#arrow)"
      />
    </g>
    <g id="axes-2d-labelled">
      <use href="#axes-2d"/>
      <text x="32" y="0">x'</text>
      <text x="0" y="32">y'</text>
    </g>
    <mask id="origin-label-mask">
      <rect x="-50%" y="-50%" width="100%" height="100%" fill="#ffffff"/>
      <rect x="-7" y="-3" width="14" height="6" fill="#000000"/>
    </mask>
    <text id="origin-label-3d" x="0" y="0" class="x-small">0,0,0</text>
    <text id="origin-label-2d" x="0" y="0" class="x-small">0,0</text>
  </defs>
</svg>

I recently put together an animated isometric SVG, and in the process learnt
more than any web developer rightly should about axonometric projection.

To save you (or future me) the mental gymnastics of figuring out how to convert
from 3D to 2D coordinates here's the gist of it.

{% aside(inline=true) %}
  (Examples are for SVG but the math can be applied to `<canvas>` or any other
  graphics context.)
{% end %}


## Coordinate System

WebGL and CSS both use right-handed coordinate systems where $+z$ points out
of the screen, but in isometric projection there is no axis perpendicular to
the display.

This is the closest I could find to a standard for isometric views:

<figure>
  <svg
    viewBox="-64 -46 128 92"
    width="400"
  >
    <use href="#bg-3d"/>
    <use href="#axes-3d-labelled"/>
  </svg>
</figure>

SVG generally uses a left-top origin, but this maps clumsily to a 3D space. A
centralised origin is easier to reason with.

<figure>
  <svg
    viewBox="-64 -46 128 92"
    width="400"
  >
    <g mask="url(#origin-label-mask)">
      <use href="#bg-3d"/>
      <use href="#axes-3d-negative"/>
      <use href="#axes-3d-positive"/>
    </g>
    <use href="#origin-label-3d"/>
  </svg>
</figure>

SVG has a 2D coordinate system (henceforth $(x^\prime,y^\prime)$). The
origin can be centralised with _negative min-x/min-y_ viewBox arguments (e.g.
`viewBox="-5 -5 10 10"`).

<figure>
  <svg
    viewBox="-64 -46 128 92"
    width="400"
  >
    <g>
      <use href="#bg-3d"/>
      <use href="#axes-3d-labelled"/>
    </g>
    <g opacity="0.5">
      <use href="#bg-2d"/>
      <use href="#axes-2d-labelled"/>
    </g>
  </svg>
</figure>

## Mapping 3D to 2D

For a given position $(x,y,z)$ in 3D space the projected $(x^\prime,y^\prime)$ can be
determined by considering each axis independently.

In isometric projection all axes are 120° apart. Alternatively the "horizontal"
axes are 30° from screen horizontal.

Thus for the $x$ axis:

<figure>
  <svg
    viewBox="-64 -46 128 92"
    width="400"
    x-data="units"
  >
    <defs>
      <g id="angle-dimension">
        <line
          class="extension"
          :x1="xu + 3" :y1="-yu"
          :x2="xu + 13 + 2 * u * (1 - cos)" :y2="-yu"
        />
        <line
          class="extension"
          :x1="xu + 3 * cos" :y1="yu + 3 * sin"
          :x2="xu + 13 * cos" :y2="yu + 13 * sin"
        />
        <path
          x-data="{r: 2 * u + 10}"
          x-bind:d="`M ${r - xu} ${-yu} A ${r} ${r} 0 0 1 ${r * cos - xu} ${r * sin - yu}`"
          stroke="#000000"
          stroke-width="0.5"
          fill="none"
          marker-start="url(#arrow-exact)"
          marker-end="url(#arrow-exact)"
          :stroke-dasharray="Math.PI * r / 6 - 4"
          stroke-dashoffset="-2"
        />
      </g>
    </defs>
    <use href="#bg-3d"/>
    <g opacity="0.6">
      <use href="#angle-dimension"/>
      <text
        class="x-small"
        x="42"
        y="4"
      >
        30°
      </text>
    </g>
    <g>
      <line
        :x1="-xu" :y1="-yu"
        :x2="xu" :y2="yu"
        marker-end="url(#arrow-exact)"
        :stroke-dasharray="2 * u - 5"
      />
      <text x="-3" y="5">x</text>
      <line
        class="guideline"
        x1="-50%" :y1="yu"
        x2="100%" :y2="yu"
      />
      <line
        class="guideline"
        :x1="xu" y1="-50%"
        :x2="xu" y2="100%"
      />
    </g>
    <g opacity="0.4">
      <line
        :x1="-xu" :y1="-yu"
        :x2="xu" :y2="-yu"
        marker-end="url(#arrow-exact)"
        :stroke-dasharray="2 * xu - 5"
      />
      <text x="2" y="-18">x'</text>
      <line
        :x1="-xu" :y1="-yu"
        :x2="-xu" :y2="yu"
        marker-end="url(#arrow-exact)"
        :stroke-dasharray="2 * yu - 5"
      />
      <text x="-28">y'</text>
    </g>
  </svg>
</figure>

$$
\begin{aligned}
x^\prime(x) &= x \cdot cos(30°) \newline
y^\prime(x) &= x \cdot sin(30°) \newline \newline
\end{aligned}
$$

For the $y$ axis:

<figure>
  <svg
    viewBox="-64 -46 128 92"
    width="400"
    x-data="units"
  >
    <use href="#bg-3d"/>
    <g opacity="0.6">
      <use href="#angle-dimension" transform="scale(-1,1)"/>
      <text
        class="x-small"
        x="-42"
        y="4"
      >
        30°
      </text>
    </g>
    <g>
      <line
        :x1="xu" :y1="-yu"
        :x2="-xu" :y2="yu"
        marker-end="url(#arrow-exact)"
        :stroke-dasharray="2 * u - 5"
      />
      <text x="3" y="5">y</text>
      <line
        class="guideline"
        x1="-50%" :y1="yu"
        x2="100%" :y2="yu"
      />
      <line
        class="guideline"
        :x1="-xu" y1="-50%"
        :x2="-xu" y2="100%"
      />
    </g>
    <g opacity="0.4">
      <line
        :x1="xu" :y1="-yu"
        :x2="-xu" :y2="-yu"
        marker-end="url(#arrow-exact)"
        :stroke-dasharray="2 * xu - 5"
      />
      <text x="2" y="-18">-x'</text>
      <line
        :x1="xu" :y1="-yu"
        :x2="xu" :y2="yu"
        marker-end="url(#arrow-exact)"
        :stroke-dasharray="2 * yu - 5"
      />
      <text x="28" y="-2">y'</text>
    </g>
  </svg>
</figure>

$$
\begin{aligned}
x^\prime(y) &= -y \cdot cos(30°) \newline
y^\prime(y) &= y \cdot sin(30°) \newline \newline
\end{aligned}
$$

And for the $z$ axis:

<figure>
  <svg
    viewBox="-64 -46 128 92"
    width="400"
    x-data="units"
  >
    <use href="#bg-3d"/>
    <g>
      <line
        :x1="0" :y1="2 * yu"
        :x2="0" :y2="-2 * yu"
        marker-end="url(#arrow-exact)"
        :stroke-dasharray="2 * u - 5"
      />
      <text x="6">z</text>
      <line
        class="guideline"
        x1="-50%" :y1="2 * yu"
        x2="100%" :y2="2 * yu"
      />
      <line
        class="guideline"
        x1="-50%" :y1="-2 * yu"
        x2="100%" :y2="-2 * yu"
      />
    </g>
    <g opacity="0.4">
      <line
        :x1="-12" :y1="2 * yu"
        :x2="-12" :y2="-2 * yu"
        marker-end="url(#arrow-exact)"
        :stroke-dasharray="2 * u - 5"
      />
      <text x="-24">-y'</text>
    </g>
  </svg>
</figure>

$$
\begin{aligned}
x^\prime(z) &= 0 \newline
y^\prime(z) &= -z
\end{aligned}
$$

All together:

$$
\begin{bmatrix}
x^\prime \newline
y^\prime
\end{bmatrix}
= f(x,y,z) =
\begin{bmatrix}
(x - y) \cdot \cos(30°) \newline
(x + y) \cdot \sin(30°) - z
\end{bmatrix}
$$

In TypeScript:

```ts
// 30° = π / 6 in radians

const xy = (
  x: number,
  y: number,
  z: number,
): [number, number] => [
  (x - y) * Math.cos(Math.PI / 6),
  (x + y) * Math.sin(Math.PI / 6) - z,
]
```


## Planes

Each axis has a corresponding normal plane.

<figure>
  <svg
    viewBox="-64 -46 128 92"
    width="400"
    x-data="units"
  >
    <use href="#bg-3d"/>
    <g
      opacity="0.5"
      :transform="`matrix(${cos}, ${sin}, ${-cos}, ${sin}, 0, 0)`"
    >
      <rect
        :x="-1.5 * u" :y="-1.5 * u" :width="3* u" :height="3 * u" fill="#ffffff" stroke="#00000099"
      />
      <text opacity="0.5" x="-2" :y="-1 * u">XY</text>
      <line
        x1="0" y1="0"
        :x2="u" y1="0"
        marker-end="url(#arrow)"
      />
      <text class="small" :x="u / 2" y="-10">x<tspan font-size="0.4rem" dy="4">XY</tspan></text>
      <line
        x1="0" y1="0"
        x2="0" :y2="u"
        marker-end="url(#arrow)"
      />
      <text class="small" x="-10" y="7">y<tspan font-size="0.4rem" dy="4">XY</tspan></text>
    </g>
    <line
      :x1="0" :y1="0"
      :x2="0" :y2="-2 * yu"
      marker-end="url(#arrow)"
    />
    <text x="-6" :y="-yu">z</text>
  </svg>
  <figcaption>
    $XY$ plane perpendicular to $z$ axis
  </figcaption>
</figure>

To project onto a plane we can use SVG's [matrix transform function](https://developer.mozilla.org/en-US/docs/Web/SVG/Reference/Attribute/transform#matrix).

```html
<g transform="matrix(a, b, c, d, e, f)"></g>
```

Ignoring `e` and `f` for now:

$$
\begin{bmatrix}
x^\prime \newline
y^\prime
\end{bmatrix} =
\begin{bmatrix}
x^\prime(x) + x^\prime(y) \newline
y^\prime(x) + y^\prime(y)
\end{bmatrix} =
\begin{bmatrix}
a & c \newline
b & d
\end{bmatrix}
\begin{bmatrix}
x \newline
y
\end{bmatrix} =
\begin{bmatrix}
ax + cy \newline
bx + dy
\end{bmatrix}
$$

For the $XY$ plane, $x_{XY}$ projects onto $+x$ in 3D space, and $y_{XY}$
projects onto $+y$. Substituting the 3D-to-2D equations from above:

$$
\begin{bmatrix}
x^\prime \newline
y^\prime
\end{bmatrix} =
\begin{bmatrix}
x^\prime(x) + x^\prime(y) \newline
y^\prime(x) + y^\prime(y)
\end{bmatrix} =
\begin{bmatrix}
cos(30°) & -cos(30°) \newline
sin(30°) & sin(30°)
\end{bmatrix}
\begin{bmatrix}
x \newline
y
\end{bmatrix}
$$
$$
\begin{bmatrix}
a & c \newline
b & d
\end{bmatrix} =
\begin{bmatrix}
cos(30°) & -cos(30°) \newline
sin(30°) & sin(30°)
\end{bmatrix}
$$

Thus to project 2D content onto the $XY$ plane:

```tsx
<svg viewBox="-6 -6 12 12">
  <!--
    cos(30°) ≈ 0.866
    sin(30°) = 0.5
  -->
  <g transform="matrix(0.866, 0.5, -0.866, 0.5, 0, 0)">
    <text
      text-anchor="middle"
      dominant-baseline="middle"
      y="-2"
    >
      Hello World
    </text>
    <circle cx="-2" cy="2" r="1"/>
    <rect x="1" y="1" width="2" height="2"/>
  </g>
</svg>
```

<figure>
  <svg
    viewBox="-64 -46 128 92"
    width="400"
    x-data="units"
  >
    <use href="#bg-3d"/>
    <g :transform="`matrix(${cos}, ${sin}, -${cos}, ${sin}, 0, 0)`">
      <text :y="-u / 2">Hello World</text>
      <circle :cx="-u / 2" :cy="u / 2" :r="u / 4"/>
      <rect :x="u  / 4" :y="u / 4" :width="u / 2" :height="u / 2"/>
    </g>
  </svg>
  <figcaption>
    Content projected onto the $XY$ plane
  </figcaption>
</figure>

Revisiting `e` & `f` the $XY$ plane can also be translated along its normal
($z_{XY}$) axis (which projects to $z$ for the $XY$ plane).

$$
\begin{bmatrix}
x^\prime \newline
y^\prime \newline
1
\end{bmatrix} =
\begin{bmatrix}
a & c & e \newline
b & d & f \newline
0 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
x \newline
y \newline
z
\end{bmatrix} =
\begin{bmatrix}
ax + cy + ez \newline
bx + dy + fz \newline
z
\end{bmatrix} =
\begin{bmatrix}
x^\prime(x) + x^\prime(y) + x^\prime(z) \newline
y^\prime(x) + y^\prime(y) + y^\prime(z) \newline
z
\end{bmatrix}
$$
$$
\begin{aligned}
x^\prime(z) &= 0 \newline
y^\prime(z) &= -z
\end{aligned}
$$
$$
\begin{bmatrix}
a & c & e \newline
b & d & f
\end{bmatrix} =
\begin{bmatrix}
cos(30°) & -cos(30°) & 0 \newline
sin(30°) & sin(30°) & -1
\end{bmatrix}
$$

Shifting by one unit in the $-z$ direction is projected as a unit shift in the
$+y^\prime$ direction.

Here the purple plane is shifted in the $+z$ direction ($f = -1$) and the orange
plane is shifted in the $-z$ direction ($f = 1$):

```tsx
<svg viewBox="-1 -1 2 2">
  <g transform="matrix(0.866, 0.5, -0.866, 0.5, 0, 1)">
    <rect x="-1" y="-1" width="2" height="2" fill="orange"/>
  </g>
  <g transform="matrix(0.866, 0.5, -0.866, 0.5, 0, 0)">
    <rect x="-1" y="-1" width="2" height="2" fill="seagreen"/>
  </g>
  <g transform="matrix(0.866, 0.5, -0.866, 0.5, 0, -1)">
    <rect x="-1" y="-1" width="2" height="2" fill="rebeccapurple"/>
  </g>
</svg>
```

<figure>
  <svg
    viewBox="-64 -46 128 92"
    width="400"
    x-data="units"
  >
    <use href="#bg-3d"/>
    <g :transform="`matrix(${cos}, ${sin}, -${cos}, ${sin}, 0, ${0.6 * u})`">
      <rect :x="-u" :y="-u" :width="2 * u" :height="2 * u" fill="orange" opacity="0.9"/>
      <text class="x-small" :x="-0.6 * u" :y="0.8 * u" transform="rotate(-90)">f = 1</text>
    </g>
    <g :transform="`matrix(${cos}, ${sin}, -${cos}, ${sin}, 0, 0)`">
      <rect :x="-u" :y="-u" :width="2 * u" :height="2 * u" fill="seagreen" opacity="0.9"/>
      <text class="x-small" :x="-0.6 * u" :y="0.8 * u" transform="rotate(-90)">f = 0</text>
    </g>
    <g :transform="`matrix(${cos}, ${sin}, -${cos}, ${sin}, 0, ${-0.6 * u})`">
      <rect :x="-u" :y="-u" :width="2 * u" :height="2 * u" fill="rebeccapurple" opacity="0.9"/>
      <text class="x-small" style="fill: #ffffff" :x="-0.6 * u" :y="0.8 * u" transform="rotate(-90)">f = -1</text>
    </g>
  </svg>
</figure>

By considering axes directions transformation matrices can be intuitively
determined for the $XZ$ and $YZ$ planes as well.

<figure>
  <svg
    viewBox="-64 -66 128 132"
    width="400"
    x-data="units"
  >
    <use href="#bg-3d"/>
    <g
      opacity="0.5"
      :transform="`matrix(${cos}, ${sin}, 0, 1, 0, 0)`"
    >
      <rect
        :x="-1.5 * u" :y="-1.5 * u" :width="3* u" :height="3 * u" fill="#ffffff" stroke="#00000099"
      />
      <text opacity="0.5" x="-2" :y="-1 * u">XZ</text>
      <line
        x1="0" y1="0"
        :x2="u" y1="0"
        marker-end="url(#arrow)"
      />
      <text class="small" x="20" y="-10">x<tspan font-size="0.4rem" dy="3">XZ</tspan></text>
      <line
        x1="0" y1="0"
        x2="0" :y2="u"
        marker-end="url(#arrow)"
      />
      <text class="small" x="12" y="14">y<tspan font-size="0.4rem" dy="4">XZ</tspan></text>
    </g>
    <line
      :x1="0" :y1="0"
      :x2="-xu" :y2="yu"
      marker-end="url(#arrow)"
    />
    <text x="-16" y="0">y</text>
  </svg>
  <figcaption>
    $XZ$ plane perpendicular to $y$ axis
  </figcaption>
</figure>

$$
\begin{aligned}
x_{XZ} \rightarrow +x \newline
y_{XZ} \rightarrow -z \newline
z_{XZ} \rightarrow +y
\end{aligned}
$$
$$
\begin{bmatrix}
a & c & e \newline
b & d & f
\end{bmatrix} =
\begin{bmatrix}
cos(30°) & 0 & -cos(30°) \newline
sin(30°) & 1 & sin(30°)
\end{bmatrix}
$$

```ts
transform_xz = `matrix(
  0.866,
  0.5,
  0,
  1,
  ${-0.866 * offset},
  ${0.5 * offset}
)`
```

<figure>
  <svg
    viewBox="-64 -66 128 132"
    width="400"
    x-data="units"
  >
    <use href="#bg-3d"/>
    <g
      opacity="0.5"
      :transform="`matrix(${cos}, ${-sin}, 0, 1, 0, 0)`"
    >
      <rect
        :x="-1.5 * u" :y="-1.5 * u" :width="3* u" :height="3 * u" fill="#ffffff" stroke="#00000099"
      />
      <text opacity="0.5" x="-2" :y="-1 * u">YZ</text>
      <line
        x1="0" y1="0"
        :x2="u" y1="0"
        marker-end="url(#arrow)"
      />
      <text class="small" x="20" y="-10">x<tspan font-size="0.4rem" dy="3">YZ</tspan></text>
      <line
        x1="0" y1="0"
        x2="0" :y2="u"
        marker-end="url(#arrow)"
      />
      <text class="small" x="-12" y="14">y<tspan font-size="0.4rem" dy="4">YZ</tspan></text>
    </g>
    <line
      :x1="0" :y1="0"
      :x2="xu" :y2="yu"
      marker-end="url(#arrow)"
    />
    <text x="18" y="2">x</text>
  </svg>
  <figcaption>
    $YZ$ plane perpendicular to $x$ axis
  </figcaption>
</figure>

$$
\begin{aligned}
x_{YZ} \rightarrow -y \newline
y_{YZ} \rightarrow -z \newline
z_{YZ} \rightarrow +x
\end{aligned}
$$
$$
\begin{bmatrix}
a & c & e \newline
b & d & f
\end{bmatrix} =
\begin{bmatrix}
cos(30°) & 0 & cos(30°) \newline
-sin(30°) & 1 & sin(30°)
\end{bmatrix}
$$

```ts
transform_yz = `matrix(
  0.866,
  -0.5,
  0,
  1,
  ${0.866 * offset},
  ${0.5 * offset})`
```

Planes can be packaged as a component with an `offset` prop in your framework
of choice:

```tsx
function XYPlane({ children, offset }) {
  const transform = `matrix(
    0.866,
    0.5,
    -0.866,
    0.5,
    0,
    ${offset}
  )`

  return (
    <g
      transform={matrix}
    >
      {children}
    </g>
  )
}
```

```html
<XYPlane offset="1">
  <!-- content to project onto XY plane -->
</XYPlane>
```

## Cuboids

A cuboid can be rendered by combining 3 rectangles rendered on each of the
normal planes.

```html
<XYPlane>
  <rect
    x="0" y="0" width="2" height="1"
    fill="orange"
  />
</XYPlane>
<XZPlane offset="1">
  <rect
    x="0" y="0" width="2" height="1"
    fill="orange"
    style="filter: brightness(0.9)"
  />
</XZPlane>
<YZPlane offset="2">
  <rect
    x="-1" y="0" width="1" height="1"
    fill="orange"
    style="filter: brightness(0.8)"
  />
</YZPlane>
```

<figure>
  <svg
    viewBox="-64 -46 128 92"
    width="400"
    x-data="units"
  >
    <use href="#bg-3d"/>
    <g :transform="`matrix(${cos}, ${sin}, -${cos}, ${sin}, 0, ${-0.6 * u})`">
      <rect :x="-u" :y="-u / 2" :width="2 * u" :height="u" fill="orange"/>
    </g>
    <g :transform="`matrix(${cos}, ${sin}, 0, 1, ${-cos * u / 2}, ${sin * u / 2})`">
      <rect
        :x="-u"
        :y="-0.6 * u"
        :width="2 * u"
        :height="u"
        fill="orange"
        filter="url(#brightness-90)"
      />
    </g>
    <g :transform="`matrix(${cos}, ${-sin}, 0, 1, ${cos * u}, ${sin * u})`">
      <rect
        :x="-u / 2"
        :y="-0.6 * u"
        :width="u"
        :height="u"
        fill="orange"
        filter="url(#brightness-80)"
      />
    </g>
  </svg>
</figure>

This can also be packaged as a component with _x/y/z_ and _width/height/depth_
props, which define the cuboid's size along the $x$, $y$, and $z$ axes
respectively.

```tsx
<Cuboid
  x={0} y={0} z={0}
  w={2} h={1} d={1}
/>
```

<!-- right, front, top -->


## Other Solids

By considering geometry in $(x,y,z)$ coordinates and using the `xy(x,y,z)`
function more complex solids can also be rendered.

<!-- The `xy(x,y,z)` function enables rendering more complex solids as well. -->

```tsx
const
  front = [
    [0, 0, 2]
    [1, 1, 0],
    [-1, 1, 0],
  ].map(xyz => xy(...xyz).join(',')).join(' '),
  right = [
    [0, 0, 2],
    [1, -1, 0],
    [1, 1, 0],
  ].map(xyz => xy(...xyz).join(',')).join(' ')

<polygon points={front}/>
<polygon points={right} style="filter: brightness(0.9)"/>
```

<figure>
  <svg
    viewBox="-64 -66 128 112"
    width="400"
    x-data="units"
  >
    <use href="#bg-3d"/>
    <g x-data="pyramid">
      <polygon fill="orange" :points="front"/>
      <polygon fill="orange" :points="right" filter="url(#brightness-90)"/>
    </g>
  </svg>
</figure>


## Other Projection Angles

From a viewing angle normal to the face of a cube, rotating $45°$ about the
vertical axis and $\arctan(\frac{1}{\sqrt{2}}) \approx 35.264°$ from the
horizontal axis places the subject in isometric projection.

<figure>
  <svg
    viewBox="-54 -46 128 92"
    width="400"
    x-data="units"
  >
    <g x-data="viewingAngle">
      <g :transform="`matrix(${matrices.xy(0)})`">
        <use href="#bg-2d"/>
      </g>
      <g
        :transform="`matrix(${matrices.xy(0)})`"
      >
        <line class="guideline" x1="0" x2="0" :y1="1.1 * u" :y2="3 * u"/>
        <line class="guideline" x1="0" y1="0" :x2="3 * u * Math.cos(Math.PI / 4)" :y2="3 * u * Math.sin(Math.PI / 4)"/>
        <path
          x-data="{r: 2.8 * u}"
          marker-start="url(#arrow-exact)"
          marker-end="url(#arrow-exact)"
          fill="none"
          stroke="#000000"
          :d="`M 0 ${r} A ${r} ${r} 0 0 0 ${r * Math.cos(Math.PI / 4)} ${r * Math.sin(Math.PI / 4)}`"
        />
        <text :x="1.3 * u" :y="3 * u">45°</text>
      </g>
      <g
        id="bottom"
        opacity="0.4"
        :transform="`matrix(${matrices.xy(0)})`"
        filter="url(#brightness-60)"
      >
        <rect x="0" y="0" :width="u" :height="u" fill="orange"/>
      </g>
      <g
        id="back"
        opacity="0.4"
        :transform="`matrix(${matrices.xz(0)})`"
        filter="url(#brightness-70)"
      >
        <rect
          x="0"
          :y="-u"
          :width="u"
          :height="u"
          fill="orange"
          filter="url(#brightness-90)"
        />
      </g>
      <g
        id="left"
        opacity="0.4"
        :transform="`matrix(${matrices.yz(0)})`"
      >
        <rect
          :x="-u"
          :y="-u"
          :width="u"
          :height="u"
          fill="orange"
          filter="url(#brightness-80)"
        />
      </g>
      <g
        id="top"
        opacity="0.8"
        :transform="`matrix(${matrices.xy(u)})`"
      >
        <rect x="0" y="0" :width="u" :height="u" fill="orange"/>
      </g>
      <g
        id="right"
        opacity="0.8"
        :transform="`matrix(${matrices.yz(u)})`"
      >
        <rect
          :x="-u"
          :y="-u"
          :width="u"
          :height="u"
          fill="orange"
          filter="url(#brightness-80)"
        />
      </g>
      <g
        :transform="`matrix(${matrices.vertical})`"
      >
        <line class="extension" x1="0" y1="0" :x2="2.4 * u * Math.SQRT2" :y2="-2.4 * u"/>
        <path
          x-data="{r: 2.8 * u}"
          marker-start="url(#arrow-exact)"
          marker-end="url(#arrow-exact)"
          fill="none"
          stroke="#000000"
          :d="`M ${r} 0 A ${r} ${r} 0 0 0 ${r * Math.cos(Math.atan(Math.SQRT1_2))} ${-r * Math.sin(Math.atan(Math.SQRT1_2))}`"
        />
        <text :x="3.8 * u" :y="-u">35.264°</text>
      </g>
      <g
        id="front"
        opacity="0.8"
        :transform="`matrix(${matrices.xz(u)})`"
      >
        <rect
          x="0"
          :y="-u"
          :width="u"
          :height="u"
          fill="orange"
          filter="url(#brightness-90)"
        />
      </g>
    </g>
  </svg>
</figure>

Rather than hardcoding the 120°/30° isometric angle, the transformation matrices can
be updated to be a function of the viewing angle:

```ts
const
  azimuth = Math.PI / 4,               // 45°
  elevation = Math.atan(Math.SQRT1_2), // ≈ 35.264°
  matXY = offset => [
    Math.cos(azimuth),
    Math.sin(azimuth) * Math.sin(elevation),
    -Math.sin(azimuth),
    Math.cos(azimuth) * Math.sin(elevation),
    0,
    -Math.cos(elevation) * offset,
  ],
  matXZ = offset => [
    Math.cos(azimuth),
    Math.sin(azimuth) * Math.sin(elevation),
    0,
    Math.cos(elevation),
    -Math.sin(azimuth) * offset,
    Math.cos(azimuth) * Math.sin(elevation) * offset,
  ],
  matYZ = offset => [
    Math.sin(azimuth),
    -Math.cos(azimuth) * Math.sin(elevation),
    0,
    Math.cos(elevation),
    Math.cos(azimuth) * offset,
    Math.sin(azimuth) * Math.sin(elevation) * offset,
  ]
```

The intuition for each value is, given a unit movement in the $x$
or $y$ direction on an untransformed plane, how does that project to
$(x^\prime,y^\prime)$ for a given azimuth (viewing angle around the vertical
axis) and elevation (viewing angle around the horizontal axis), relative to a
starting angle normal to the $\text{YZ}$ plane.

<!--
For example, for $b_{XY} = \sin(\text{azimuth}) \cdot \sin(\text{elevation})$:

$$
b_{XY} = y^\prime_{XY}(x)
$$
-->

The `xy(x,y,z)` function can also be updated:

<!-- verify... -->

```ts
const xy = (
  x: number,
  y: number,
  z: number,
  azimuth: number = Math.PI / 4,
  elevation: number = Math.atan(Math.SQRT1_2),
): [number, number] => [
  y * Math.cos(azimuth) - x * Math.sin(azimuth),
  z * Math.cos(elevation)
    - x * Math.cos(azimuth) * Math.sin(elevation)
    - y * Math.sin(azimuth) * Math.sin(elevation),
]
```


Now alternative (di/tri)metric projections can be achieved by adjusting the
viewing angle:

<figure class="interactive" x-data="{ azimuth: 45, elevation: 45 }">
  <svg
    viewBox="-48 -36 96 72"
    x-data="units"
  >
    <g x-data="widget">
      <g :transform="`matrix(${matrices(azimuth, elevation).xy(-u / 2)})`">
        <use href="#bg-2d"/>
      </g>
      <g
        id="bottom"
        opacity="0.4"
        :transform="`matrix(${matrices(azimuth, elevation).xy(-u / 2)})`"
      >
        <rect
          :x="-u / 2"
          :y="-u / 2"
          :width="u"
          :height="u"
          fill="orange"
          filter="url(#brightness-60)"
        />
      </g>
      <g
        id="back"
        opacity="0.4"
        :transform="`matrix(${matrices(azimuth, elevation).xz(-u / 2)})`"
        filter="url(#brightness-70)"
      >
        <rect
          :x="-u / 2"
          :y="-u / 2"
          :width="u"
          :height="u"
          fill="orange"
          filter="url(#brightness-90)"
        />
      </g>
      <g
        id="left"
        opacity="0.4"
        :transform="`matrix(${matrices(azimuth, elevation).yz(-u / 2)})`"
      >
        <rect
          :x="-u / 2"
          :y="-u / 2"
          :width="u"
          :height="u"
          fill="orange"
          filter="url(#brightness-80)"
        />
      </g>
      <g
        id="top"
        opacity="0.8"
        :transform="`matrix(${matrices(azimuth, elevation).xy(u / 2)})`"
      >
        <rect :x="-u / 2" :y="-u / 2" :width="u" :height="u" fill="orange"/>
      </g>
      <g
        id="front"
        opacity="0.8"
        :transform="`matrix(${matrices(azimuth, elevation).xz(u / 2)})`"
      >
        <rect
          :x="-u / 2"
          :y="-u / 2"
          :width="u"
          :height="u"
          fill="orange"
          filter="url(#brightness-90)"
        />
      </g>
      <g
        id="right"
        opacity="0.8"
        :transform="`matrix(${matrices(azimuth, elevation).yz(u / 2)})`"
      >
        <rect
          :x="-u / 2"
          :y="-u / 2"
          :width="u"
          :height="u"
          fill="orange"
          filter="url(#brightness-80)"
        />
      </g>
    </g>
  </svg>
  <div class="slider vertical">
    <input type="range" min="0" max="90" step="5"
      class="vertical"
      x-model="elevation"
    />
    <label
      :style="{ top: `${112 * (90 - elevation) / 90}px` }"
      x-text="`${elevation}°`"
    ></label>
  </div>
  <div class="slider">
    <input type="range" min="0" max="90" step="5"
      x-model="azimuth"
    />
    <label
      :style="{ left: `${112 * azimuth / 90}px` }"
      x-text="`${azimuth}°`"
    ></label>
  </div>
</figure>


## Closing Notes

Attempting to render complex scenes quickly comes up against some hurdles,
notably:

- Elements later in the DOM are rendered "in-front" of earlier elements
  regardless of their $(x,y,z)$ position.
- To make things appear 3D shadows have to be manually created.

For more advanced rendering a 3D library such as [Three.js](//threejs.org) may
be more appropriate.

But for simple diagramming—with the added benefit of being able to create
self-contained SVGs—the above approach may well be sufficient.
