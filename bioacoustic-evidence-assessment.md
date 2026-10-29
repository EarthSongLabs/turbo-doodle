# Bioacoustic Evidence and Scientific Inference Assessment

## Purpose

Evaluate the scientific conclusions supported by bioacoustic recordings and associated metadata, distinguishing directly observable acoustic features from increasingly complex biological and ecological interpretations.

This workflow provides a reusable framework for assessing evidence quality, identifying uncertainty, evaluating alternative explanations, and determining what additional information is required to support specific scientific claims.

## General workflow

1. **Establish provenance:** Identify the recording or dataset, original source, collection methods, licensing, and available metadata.

2. **Inspect technical characteristics:** Use FFprobe or equivalent tools to examine audio format, sampling parameters, channel configuration, duration, and other relevant properties. Distinguish file properties from instrument calibration and deployment information.

3. **Characterize acoustic evidence:** When appropriate, use Audacity or analytical software to document observable frequency, timing, amplitude, and signal-pattern characteristics without prematurely assigning biological meaning.

4. **Evaluate levels of inference:**
   - **Acoustic observation:** What measurable sound characteristics are present?
   - **Source identification:** What evidence supports attribution to a species or other source?
   - **Behavioral or ecological interpretation:** What additional context supports conclusions about behavior, communication, or ecological function?
   - **Population-level inference:** Does the sampling design support conclusions about abundance, distribution, occupancy, or trends?

5. **Construct an evidence matrix:** For each proposed claim, record its evidence, support level, alternative explanations, limitations, missing metadata, and supporting references.

6. **Identify next analytical steps:** Determine which additional metadata, observations, recordings, or analyses would most meaningfully reduce uncertainty.

## Evidence matrix template

| Proposed claim | Supporting evidence | Support level | Uncertainty / alternatives | Additional evidence needed |
|---|---|---|---|---|
| | | | | |

Suggested support levels: **Supported, Partially supported, Unsupported, or Not assessed.**

## Quality-control principles

- Separate direct measurements from interpretation.
- Distinguish documented specifications from independently assessed recording quality.
- Do not assume that a detected sound establishes species identity or behavior.
- Evaluate population-level claims against sampling effort, detection probability, spatial coverage, and temporal representativeness.
- Preserve source references and document unresolved uncertainties.
- Treat conclusions as revisable when new evidence becomes available.

## Applications

Firefox or another browser for source documentation; Terminal and FFprobe for technical inspection; Audacity or other acoustic-analysis software for signal examination; Markdown or a spreadsheet for evidence tracking.
