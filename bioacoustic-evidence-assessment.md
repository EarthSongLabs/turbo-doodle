# Bioacoustic Evidence and Scientific Inference Assessment

## Purpose

Evaluate the scientific conclusions supported by bioacoustic recordings and associated metadata, distinguishing directly observable acoustic features from biological and ecological interpretations.

This workflow provides a reusable framework for assessing evidence quality, identifying uncertainty, evaluating alternative explanations, and determining what additional information is needed to support scientific claims.

## Tools

- **Firefox or another browser:** Source documentation, archive records, and scientific references
- **Terminal / FFprobe:** Audio file properties and technical verification
- **Audacity or equivalent software:** Waveform, spectrogram, and acoustic signal examination
- **Microsoft Excel:** Structured evidence assessment and metadata tracking

## Workflow

### 1. Establish recording provenance

Identify the recording or dataset, its original source, collection methods, licensing, and available metadata.

Record relevant information in the **Source & Metadata** worksheet of the accompanying Excel template.

Distinguish verified documentation from assumptions and missing information.

### 2. Inspect technical characteristics

Use FFprobe or equivalent tools to examine audio format, sample rate, channel configuration, duration, and available bit-depth information.

Example:

```bash
ffprobe -v error \
  -show_entries format=filename,format_name,duration,size \
  -show_entries stream=codec_name,sample_rate,channels,bits_per_raw_sample \
  -of json recording.wav
```

Replace `recording.wav` with the actual file path.

Compare file properties with source documentation. Do not treat file specifications as evidence of instrument calibration or recording quality.

### 3. Characterize acoustic evidence

When appropriate, examine waveforms and spectrograms in Audacity or other analytical software.

Document observable characteristics such as frequency range, timing, signal repetition, amplitude patterns, and potential interference.

Separate acoustic observations from interpretations about species identity, behavior, or ecological significance.

### 4. Evaluate scientific claims

Assess proposed claims at the appropriate level of inference:

- **Acoustic observation:** What measurable signal characteristics are present?
- **Source identification:** What evidence supports attribution to a species or other acoustic source?
- **Behavioral or ecological interpretation:** What context supports conclusions about behavior, communication, or ecological function?
- **Population-level inference:** Does the sampling design support conclusions about abundance, distribution, occupancy, or trends?

Use the **Claim Assessment** worksheet to document supporting evidence, inference level, support status, uncertainty, alternative explanations, and additional evidence requirements.

Suggested support categories:

- Supported
- Partially supported
- Unsupported
- Not assessed

### 5. Identify evidence gaps

Review the assessments for missing metadata, methodological limitations, and unresolved scientific questions.

Use the **Evidence Requests** worksheet to prioritize additional documentation, observations, recordings, or analyses that could meaningfully improve confidence in the conclusions.

### 6. Verify and refine conclusions

Recheck claims against primary documentation, measured acoustic characteristics, and relevant scientific literature.

Update assessments as new evidence becomes available. Preserve traceable references and clearly distinguish established findings from provisional interpretations.

## Excel Assessment Template

**[Download the Bioacoustic Evidence Assessment Template](earth_song_labs_bioacoustic_evidence_template.xlsx)**

The accompanying Excel workbook provides four worksheets:

1. **Claim Assessment** — Evaluate proposed scientific claims, evidence, inference levels, uncertainty, and support status.
2. **Source & Metadata** — Document recording provenance, technical characteristics, licensing, and metadata completeness.
3. **Evidence Requests** — Track missing information and prioritize follow-up investigations.
4. **Guide** — Reference instructions and assessment definitions.

The template can be reused across individual recordings, comparative acoustic studies, and broader ecological research projects.

## Quality-Control Principles

- Separate direct measurements from scientific interpretation.
- Distinguish documented specifications from independently assessed acoustic quality.
- Do not assume that a detected signal establishes species identity or behavior.
- Evaluate population-level conclusions against sampling effort, detection probability, and spatial and temporal representativeness.
- Maintain traceable source references.
- Explicitly document uncertainty and alternative explanations.
- Revisit conclusions when additional evidence becomes available.

## Outputs

A structured, revisable scientific evidence assessment containing documented source metadata, evaluated claims, supporting evidence, uncertainties, and prioritized next steps.
