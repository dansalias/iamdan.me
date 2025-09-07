+++
title = "In-Browser Inference Four Different Ways"
date = 2025-09-07

[extra]
hn = 12345678
+++

{% include "./demo.html" %}

I've been experimenting with browser-based neural networks over the past 12
months.

Here's a summary of my **JS → WASM → WebGPU → WebNN** journey to help accelerate
anyone else's webdev-turned-ml-engineer path.

## JS

This is likely the starting point for first building
forward-propagation/inference if you come from a web development background.

It's often good enough for small models.

```ts
```

## WASM

[WebAssembly](https://developer.mozilla.org/en-US/docs/WebAssembly) allows for
near-native performance on the CPU.

I've recently added Rust to my toolbox, but any language that compiles to web
assembly can be used. [AssemblyScript](http://assemblyscript.org/) provides the
lowest learning curve coming from TypeScript.

```rust
```

## WebGPU

[WebGPU](https://developer.mozilla.org/en-US/docs/Web/API/WebGPU_API) provides
browser APIs for running on the user's GPU (if present).

```ts
```

## WebNN

[WebNN](https://www.w3.org/TR/webnn/) is an emerging API which defers to the
system to run on the best hardware (e.g. a dedicated TPU/NPU) available.

```ts
```

## Notes

Native/WASM code can also interact with the system's GPU. I've skipped an
example in favour of demoing the available browser APIs for the benefit of
engineers such as myself coming from a web development background.

The JS APIs come with the added benefit of deferring the flavour of GPU
instructions (e.g. CUDA, Metal) to the browser.

Once [browser support](#) catches up WebNN will usually be the best choice.
