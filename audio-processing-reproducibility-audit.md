# Audio Processing Reproducibility Audit

## Purpose

Independently reproduce audio-processing results, verify reported measurements, identify discrepancies, and document the minimum corrections necessary to make an analytical workflow reproducible.

This workflow applies to bioacoustic research, field recordings, soundscape analysis, audio extraction, and other scientific or creative signal-processing applications.

## Tools

- **Terminal:** File integrity checks, command execution, software version documentation, and automated measurement
- **FFmpeg / FFprobe:** Audio processing and technical inspection
- **Audacity:** Independent waveform, spectrogram, and excerpt comparison
- **Firefox or another browser:** Source documentation, processing methods, and reference measurements

## Workflow

### 1. Establish the reference

Identify the source recording, processing instructions, and expected outputs.

Document:

- Source location, identifier, and applicable license
- Original recording and relevant metadata
- Published or previously recorded processing commands
- Expected excerpt boundaries, duration, sample rate, channels, and encoding
- Any reported acoustic measurements or analytical results

Distinguish explicit processing parameters from undocumented assumptions.

### 2. Verify source integrity

Generate a SHA-256 checksum of the original audio file:

```bash
shasum -a 256 recording.wav
```

Inspect its technical properties:

```bash
ffprobe -v error \
  -show_entries format=filename,format_name,duration,size \
  -show_entries stream=codec_name,sample_rate,channels,bits_per_raw_sample \
  -of json recording.wav
```

Record the checksum, file properties, source identifier, and software environment.

```bash
ffmpeg -version
ffprobe -version
```

The checksum identifies the exact file used in the audit. Compare it with a trusted reference checksum when one is available.

### 3. Reproduce the processing operation

Execute the documented processing commands without modifying them initially.

For example, an excerpt extraction might use:

```bash
ffmpeg -ss 00:12:30 \
  -i recording.wav \
  -t 30 \
  -map 0:a:0 \
  -c:a pcm_s24le \
  reproduced_excerpt.wav
```

**Example only:** Replace the timestamps, input filename, stream selection, and encoding with the actual documented parameters. The 24-bit PCM encoding shown is appropriate only when that output format is intended.

Record the exact command, software versions, processing messages, and output location.

If the original instructions cannot be executed, document the failure before introducing corrections.

### 4. Verify the reproduced output

Inspect the output using FFprobe:

```bash
ffprobe -v error \
  -show_entries format=duration,size \
  -show_entries stream=codec_name,sample_rate,channels,bits_per_raw_sample \
  -of json reproduced_excerpt.wav
```

Compare the reproduced result against the reference:

| Property | Reference | Reproduced | Discrepancy |
|---|---|---|---|
| Duration | | | |
| Start/end timestamps | | | |
| Sample rate | | | |
| Channel count | | | |
| Encoding / bit depth | | | |
| File checksum | | | |
| Reported acoustic measurements | | | |

When appropriate, inspect both recordings in Audacity to compare waveform alignment, signal boundaries, amplitude, spectrogram characteristics, and possible artifacts.

A matching duration or file format alone does not establish that the audio content is identical.

For quantitative measurements, use consistent definitions, units, software settings, and measurement intervals.

### 5. Classify discrepancies

For each discrepancy, identify its likely cause and supporting evidence.

Possible categories include:

- Incorrect or ambiguous timestamps
- Missing processing parameters
- Unspecified audio encoding or channel selection
- Software-version differences
- Unintended resampling or signal modification
- Incomplete provenance or source-file identification
- Differences in measurement definitions or analytical settings
- Undocumented manual editing

Distinguish confirmed causes from hypotheses requiring additional testing.

### 6. Develop minimum reproducibility corrections

Identify the smallest changes needed to reproduce the intended result reliably.

For each proposed correction, document:

- Original instruction or parameter
- Observed problem
- Proposed correction
- Evidence supporting the correction
- Expected effect
- Verification method

Avoid changing unrelated processing settings or silently improving the audio during a reproducibility audit.

### 7. Rerun and verify

Execute the corrected workflow.

Reinspect the output and compare it against the expected properties and measurements.

Document whether each discrepancy was resolved, remains unexplained, or requires additional information.

## Corrected Command Manifest

Maintain a record of the validated processing commands and environment.

```text
Source file:
Source SHA-256:
Source URL / identifier:
Applicable license:

FFmpeg version:
FFprobe version:
Operating environment:

Processing command:
Output filename:
Output SHA-256:

Expected measurements:
Observed measurements:
Remaining discrepancies:
```

## Verification Checklist

- [ ] Source provenance and reuse permissions documented
- [ ] Original file checksum recorded
- [ ] Input audio properties verified
- [ ] Processing software versions documented
- [ ] Original commands executed or execution failure recorded
- [ ] Output properties independently inspected
- [ ] Reported measurements compared using consistent methods
- [ ] Discrepancies and uncertainties documented
- [ ] Corrections justified by evidence
- [ ] Corrected workflow rerun successfully
- [ ] Remaining limitations explicitly identified

## Outputs

A reproducibility audit documenting source integrity, processing parameters, comparison results, identified discrepancies, minimum justified corrections, and a validated command manifest.

The resulting documentation should enable another analyst to repeat the processing operation and independently assess whether the reported results are reproducible.
