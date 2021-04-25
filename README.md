# Uni-LaTeX

This projects contains LaTeX-class files used to layout documents for different university lectures.

## Usage
This repository is intended to be included as a submodule into other repositories/projects. The intended file system structure is
- `new-project`: repository folder
    - `main.tex`: main LaTeX file of `new-project`
    - `uni-latex`: submodule folder
        - _containing provided files of `uni-latex`_

## Provided Functionality

### `uni-sheet.cls`
This file provides a LaTeX-class for layouting (solutions to) exercise sheets.

### `uni-def.cls`
This file provides a LaTeX-class for layouting lecture summaries.

### `preamble.sty`
This file loads a few packages which the author uses regularly.

### `math-shorthand.sty`
This file provides shorthand definitions for regularly used math expressions.

### folder `examples`
In this folder one can find examples using the provided LaTeX classes. Note that the examples load the classes expecting the file system described above. Therefore the examples need to be copied to the parent folder of this repository to be compiled.
