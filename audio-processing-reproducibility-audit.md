# Audio Processing Reproducibility Audit

## Purpose

Independently reproduce audio-processing operations, verify analytical results, identify discrepancies, and establish the minimum corrections required for reproducibility.

Applicable to bioacoustic research, field recordings, soundscape analysis, signal processing, and experimental audio development.

## Method

### 1. Establish the reference

Identify the original recording, processing procedure, expected output, and reported measurements.

Document source provenance, applicable permissions, processing parameters, software environment, and any missing methodological information.

### 2. Verify source integrity

Preserve the original recording and record its checksum:

```bash
shasum -a 256 recording.wav
```

Inspect technical properties:

```bash
ffprobe -v error \
  -show_entries format=filename,format_name,duration,size \
  -show_entries stream=codec_name,sample_rate,channels,bits_per_raw_sample \
  -of json recording.wav
```

Document software versions:

```bash
ffmpeg -version
ffprobe -version
```

A checksum confirms file identity when compared against a trusted reference; it does not independently establish recording authenticity.

### 3. Reproduce the original processing

Execute the documented procedure without modification wherever possible.

Example excerpt extraction:

```bash
ffmpeg -ss 00:12:30 \
  -i recording.wav \
  -t 30 \
  -map 0:a:0 \
  -c:a pcm_s24le \
  reproduced_excerpt.wav
```

The timestamps, filename, and encoding are illustrative.

Record the exact commands, parameters, software versions, and execution results.

Document any failure before introducing corrections.

### 4. Compare outputs and measurements

Inspect the reproduced output:

```bash
ffprobe -v error \
  -show_entries format=duration,size \
  -show_entries stream=codec_name,sample_rate,channels,bits_per_raw_sample \
  -of json reproduced_excerpt.wav
```

Compare relevant properties:

- Duration and temporal boundaries
- Sample rate and channel configuration
- Encoding and bit depth
- File checksums
- Waveform and spectrogram characteristics
- Reported acoustic measurements
- Processing artifacts or unexpected transformations

Use consistent measurement definitions, settings, units, and analysis intervals.

Matching file properties do not necessarily establish identical acoustic content.

### 5. Diagnose discrepancies

Investigate possible causes, including:

- Incorrect timestamps or ambiguous interval definitions
- Missing processing parameters
- Software-version differences
- Unintended resampling or channel modification
- Encoding or precision differences
- Inconsistent measurement methods
- Undocumented processing
- Source-file mismatches

Distinguish confirmed causes from unresolved hypotheses.

### 6. Apply minimum justified corrections

For each proposed correction, record:

- Original procedure
- Observed discrepancy
- Proposed change
- Supporting evidence
- Expected effect
- Verification method

Avoid unrelated modifications or undocumented improvements.

### 7. Reproduce and verify again

Rerun the corrected procedure.

Compare results against the reference and document resolved discrepancies, remaining differences, and methodological limitations.

For evolving algorithms, compare results across software and parameter versions while preserving the original experimental configuration.

## Reproducibility Manifest

Maintain a record of the validated environment and processing procedure:

```text
Source identifier:
Source URL:
Source SHA-256:
Applicable permissions:

Software and versions:
Operating environment:
Processing parameters:
Processing command:

Output filename:
Output SHA-256:
Expected measurements:
Observed measurements:
Remaining discrepancies:
```

## Quality Control

- Preserve original recordings.
- Record source identifiers and file checksums.
- Document processing parameters and software versions.
- Compare outputs using consistent measurement methods.
- Distinguish reproducibility from scientific validity.
- Justify corrections with evidence.
- Preserve original and corrected procedures.
- Document unresolved discrepancies and uncertainty.

## Output

A traceable reproducibility assessment with verified processing commands, comparison results, justified corrections, and documented limitations.
