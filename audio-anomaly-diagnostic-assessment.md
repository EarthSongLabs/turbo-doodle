# Audio Anomaly Diagnostic Assessment

## Purpose

Investigate unexpected or potentially problematic acoustic features in recordings, distinguish plausible signal sources from recording or processing artifacts, and determine whether affected audio should be retained, reprocessed, or excluded from further analysis.

This workflow supports bioacoustic research, field recording, soundscape analysis, and experimental audio production.

## Tools

- **Audacity:** Waveform and spectrogram inspection, comparative listening, and evidence capture
- **FFprobe / FFmpeg:** Optional technical verification and controlled audio comparisons
- **PDF export tool:** Word, Pages, or another application capable of producing a report with embedded figures

## Workflow

### 1. Establish recording context

Identify the source recording and relevant acquisition information:

- Recording date, location, and source
- Sample rate, channel configuration, and encoding
- Recording equipment and available calibration information
- Known processing history
- Relevant environmental or acoustic context

Document missing information rather than assuming it.

### 2. Identify and isolate the anomaly

Open the recording in Audacity.

Locate the unusual feature and record its precise start and end timestamps.

Inspect the waveform and spectrogram, noting:

- Frequency distribution and bandwidth
- Duration and temporal structure
- Amplitude characteristics
- Harmonic or periodic patterns
- Background noise
- Abrupt discontinuities or clipping
- Relationship to surrounding acoustic events

Preserve the original recording. Use copies for any destructive processing.

### 3. Develop competing explanations

Consider plausible interpretations of the observed feature, including:

- Biological or environmental acoustic event
- Mechanical or electronic interference
- Instrument or recording-system artifact
- Clipping, distortion, or overload
- Processing or encoding artifact
- Unidentified source

Evaluate each explanation against the observed evidence.

Avoid assigning a biological source without sufficient supporting evidence.

### 4. Conduct targeted diagnostic comparisons

Select tests appropriate to the anomaly.

Possible approaches include:

- Compare the anomaly with adjacent unaffected audio.
- Inspect different spectrogram frequency ranges and resolutions.
- Examine individual channels for channel-specific artifacts.
- Compare original and processed versions when available.
- Check for clipping, discontinuities, or unusual spectral concentrations.
- Review available recording-system and environmental metadata.

Where useful, inspect technical properties using FFprobe:

```bash
ffprobe -v error \
  -show_entries format=duration,format_name \
  -show_entries stream=codec_name,sample_rate,channels \
  -of json recording.wav
```

Record test settings and observations so that diagnostic comparisons can be repeated.

### 5. Evaluate analytical suitability

Determine whether the anomaly affects the intended analysis.

Consider:

- Whether the affected frequency or time interval overlaps the signal of interest
- Whether measurements could be biased by the anomaly
- Whether the anomaly can be isolated without compromising relevant information
- Whether corrective processing would introduce additional uncertainty
- Whether unaffected portions remain suitable for analysis

Distinguish acoustic suitability for scientific measurement from suitability for creative use.

### 6. Make a justified recommendation

Choose one primary disposition:

**Keep:** The recording or affected segment remains suitable for the intended analysis, with documented limitations.

**Reprocess:** A specific, justified processing operation may address the problem without unacceptable loss or alteration of relevant information.

**Exclude:** The affected segment cannot reliably support the intended analysis, or its uncertainty is unacceptable.

Document the evidence supporting the decision, alternative explanations, and remaining uncertainties.

A recommendation may apply only to a specific analytical purpose or time interval rather than the entire recording.

## Diagnostic Report

Prepare a concise PDF report containing:

### Recording identification
Source, relevant metadata, file specifications, and processing history.

### Anomaly description
Start/end timestamps and directly observed acoustic characteristics.

### Visual evidence
Timestamped waveform and spectrogram screenshots, including relevant frequency scales, display settings, and contextual audio where useful.

### Diagnostic interpretation
Competing explanations, supporting and conflicting observations, and unresolved uncertainty.

### Analytical implications
Potential effects on measurements, biological interpretation, or downstream processing.

### Recommendation
Keep, reprocess, or exclude, with a concise scientific justification and any required follow-up actions.

## Verification Checklist

- [ ] Original audio preserved
- [ ] Anomaly timestamps recorded
- [ ] Waveform and spectrogram evidence captured
- [ ] Relevant display and analysis settings documented
- [ ] At least two plausible explanations considered when supported by the evidence
- [ ] Observations distinguished from interpretations
- [ ] Impact on intended analysis evaluated
- [ ] Limitations and uncertainty identified
- [ ] Recommendation justified by diagnostic evidence
- [ ] PDF report reviewed for traceability and clarity

## Outputs

A documented audio diagnostic assessment containing timestamped acoustic evidence, competing explanations, analytical limitations, and a justified keep/reprocess/exclude recommendation.

The framework can be repeated across recordings and adapted to different research or creative objectives.
