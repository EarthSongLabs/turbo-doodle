# Audio Anomaly Diagnostic Assessment

## Purpose

Investigate unexpected acoustic features, distinguish plausible sound sources from recording or processing artifacts, and determine whether affected audio is suitable for further analysis.

Applicable to bioacoustic research, field recordings, soundscape analysis, and experimental audio production.

## Method

### 1. Establish recording context

Document the source recording, acquisition conditions, technical specifications, processing history, and available environmental metadata.

Identify missing or uncertain information that could affect interpretation.

### 2. Characterize the anomaly

Locate the feature and record its precise timestamps.

Examine:

- Frequency distribution, bandwidth, and spectral structure
- Duration, timing, and periodicity
- Amplitude and dynamic characteristics
- Background noise and neighboring events
- Harmonic patterns, discontinuities, and clipping
- Differences between channels or recording versions

Preserve the original recording and distinguish direct observations from interpretation.

### 3. Develop competing explanations

Evaluate plausible hypotheses, including:

- Biological or environmental sound
- Mechanical or electronic interference
- Recording-system artifact
- Clipping, overload, or distortion
- Processing or encoding artifact
- Unidentified acoustic source

Assess each explanation against the available evidence without assuming biological origin.

### 4. Conduct targeted diagnostic tests

Select comparisons that can distinguish between competing hypotheses.

Possible tests include:

- Adjacent or unaffected audio comparison
- Alternative spectrogram settings
- Channel-specific analysis
- Original versus processed recording comparison
- Clipping and discontinuity inspection
- Review of acquisition and environmental metadata

For technical verification, FFprobe may be used:

```bash
ffprobe -v error \
  -show_entries format=duration,format_name \
  -show_entries stream=codec_name,sample_rate,channels \
  -of json recording.wav
```

Record diagnostic settings, observations, and relevant limitations.

### 5. Assess analytical suitability

Determine whether the anomaly affects the intended analysis.

Consider:

- Overlap with relevant acoustic signals
- Potential bias in measured properties
- Whether affected intervals can be isolated
- Risks introduced by corrective processing
- Suitability of unaffected recording segments

Distinguish scientific measurement suitability from creative audio suitability.

### 6. Determine disposition

Select a justified recommendation for the affected interval and intended application.

**Keep:** Retain the audio because the anomaly does not invalidate the intended analysis, subject to documented limitations.

**Reprocess:** Apply a specified corrective operation when its expected benefits and potential distortions can be evaluated.

**Exclude:** Remove the affected interval from the intended analysis when its reliability is insufficient.

A disposition may apply to a particular measurement, frequency range, or time interval rather than the entire recording.

### 7. Document and verify

Maintain a diagnostic record containing:

- Recording provenance and technical context
- Anomaly timestamps
- Waveform and spectrogram evidence
- Diagnostic settings and comparisons
- Competing hypotheses
- Supporting and conflicting observations
- Analytical implications
- Recommendation and justification
- Remaining uncertainty and follow-up needs

Preserve traceability between evidence and conclusions.

## Quality Control

- Preserve original audio.
- Record precise anomaly boundaries.
- Include timestamped acoustic evidence.
- Document relevant analysis settings.
- Consider plausible alternative explanations.
- Separate observations from causal interpretations.
- Evaluate suitability for a defined analytical purpose.
- Justify corrective processing before applying it.
- Identify unresolved uncertainty.

## Output

A reproducible diagnostic assessment documenting acoustic evidence, competing explanations, analytical limitations, and a justified Keep / Reprocess / Exclude recommendation.
