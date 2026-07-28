# TIFR Lean Tutorial

This repository is for a Lean tutorial at the [Tata Institute for Fundamental Research](https://www.tifr.res.in), Mumbai, on 3 and 4 August 2026.

## Installing Lean

Follow the instructions at [lean-lang.org/install](https://lean-lang.org/install/) to install Lean via `elan`, the recommended method for most platforms. See the [manual installation guide](https://lean-lang.org/install/manual/) if you need it.

## Getting started

Fork or clone the repo, then fetch the prebuilt cache so you don't have to build Mathlib from scratch.

First, clone the repo:

```bash
git clone https://github.com/thefundamentaltheor3m/TIFR-Tutorial.git
```

If you've forked the repo, then replace the URL in the above command with the URL of your fork.

Next, enter the cloned project folder.

```bash
cd TIFR-Tutorial
```

Run the following command to install Mathlib cache.

```bash
lake exe cache get
```

Then open the project folder in VS Code (with the Lean 4 extension) and you're ready to go!

To build the project locally, run

```bash
lake build
```

The warnings and errors there will tell you what Lean thinks about your code.

There are many more things you can do with `lake`, but I won't get into them here. Feel free to ask me if you have questions!

Spot a problem with the repo? Pull requests are welcome!