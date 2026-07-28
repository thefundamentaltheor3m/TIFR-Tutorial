# TIFR-Tutorial

This repository is for tutorials to be conducted at TIFR on 3 and 4 August 2026 by Sidharth Hariharan.

## Installing Lean

Follow the instructions at [lean-lang.org/install](https://lean-lang.org/install/) to install Lean via `elan`, the recommended method for most platforms. See the [manual installation guide](https://lean-lang.org/install/manual/) if you need it.

## Getting started

Fork or clone the repo, then fetch the prebuilt cache so you don't have to build Mathlib from scratch:

```bash
git clone https://github.com/thefundamentaltheor3m/TIFR-Tutorial.git
cd TIFR-Tutorial
lake exe cache get
```

Then open the folder in VS Code (with the Lean 4 extension) and you're ready to go. Spot a problem with the repo? Pull requests are welcome!

## GitHub configuration

To set up your new GitHub repository, follow these steps:

* Under your repository name, click **Settings**.
* In the **Actions** section of the sidebar, click "General".
* Check the box **Allow GitHub Actions to create and approve pull requests**.
* Click the **Pages** section of the settings sidebar.
* In the **Source** dropdown menu, select "GitHub Actions".

After following the steps above, you can remove this section from the README file.
