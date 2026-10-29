# NOAA Passive Acoustic Recording Selection and Extraction

## Purpose

Access, select, extract, and verify passive acoustic recordings from NOAA archives for marine bioacoustic research and creative sound investigation.

This workflow documents NOAA-specific data access, metadata verification, and extraction procedures. Individual recordings, timestamps, and analytical objectives are selected for each use.

## Reference Sources

- [NOAA Passive Acoustic Data Archive](https://www.ncei.noaa.gov/products/passive-acoustic-data)
- [NOAA SanctSound Metadata](https://www.fisheries.noaa.gov/inport/item/80343/full-list)

Different NOAA collections may use different storage systems, download interfaces, and metadata structures. Verify the access method for the selected collection rather than assuming a universal NOAA download command.

## 1. Identify the Dataset

Review the relevant NOAA archive or collection documentation.

Establish:

- Dataset and collection identifier
- Original data provider
- Recording location and deployment period
- Hydrophone and acquisition specifications
- Available annotations and biological context
- Data access method
- Applicable licensing and reuse restrictions

Verify permissions at the dataset or recording level. NOAA hosting does not automatically establish CC0 status or unrestricted reuse.

## 2. Locate and Retrieve Recordings

Use the access procedure documented for the selected NOAA collection.

### Google Cloud Storage

Where a collection provides verified Google Cloud Storage paths:

```bash
gcloud storage ls "gs://VERIFIED_BUCKET/VERIFIED_PREFIX/"
```

Download a selected file:

```bash
gcloud storage cp \
  "gs://VERIFIED_BUCKET/VERIFIED_PREFIX/recording.wav" \
  raw/recording.wav
```

The bucket and object paths above are placeholders, not confirmed NOAA storage locations.

### HTTPS or Other Archive Access

Where NOAA provides direct HTTPS downloads, archive interfaces, or another retrieval mechanism, use the documented method and preserve the original filename and format when practical.

Record the actual retrieval command or procedure for future reuse.

## 3. Verify the Download

Preserve the original recording.

Generate a file checksum:

```bash
shasum -a 256 raw/recording.wav
```

Inspect technical properties:

```bash
ffprobe -v error \
  -show_entries format=duration,format_name,size \
  -show_entries stream=codec_name,sample_rate,channels,bits_per_sample,bits_per_raw_sample \
  -of json raw/recording.wav
```

Compare the results with the collection metadata.

Where NOAA provides an authoritative checksum, compare it with the downloaded file.

Document any discrepancies between the file properties and archive documentation.

## 4. Identify Acoustic Intervals

Use recording annotations, waveform inspection, spectrogram analysis, and listening to locate relevant acoustic events.

Evaluate:

- Signal frequency range and temporal structure
- Signal-to-noise ratio
- Interference and recording artifacts
- Completeness of calls or acoustic sequences
- Suitability for the intended analysis
- Confidence in biological identification

Record precise interval boundaries and selection rationale.

Do not infer species identity or behavior from acoustic appearance alone without sufficient supporting evidence.

## 5. Extract Audio

Extract the selected interval directly from the original recording.

Example using FFmpeg:

```bash
ffmpeg -ss 00:12:30 \
  -i raw/recording.wav \
  -t 30 \
  -map 0:a:0 \
  -c:a pcm_s24le \
  excerpts/selected_call.wav
```

The timestamps, filenames, and 24-bit PCM encoding are illustrative.

Choose output encoding appropriate to the original recording and intended analysis. Avoid unnecessary resampling, lossy conversion, or channel modification.

Document all processing parameters and intentional transformations.

## 6. Verify the Excerpt

Inspect the output:

```bash
ffprobe -v error \
  -show_entries format=duration,format_name \
  -show_entries stream=codec_name,sample_rate,channels,bits_per_sample,bits_per_raw_sample \
  -of json excerpts/selected_call.wav
```

Verify:

- Correct start and end boundaries
- Expected duration
- Intended acoustic content
- Sample rate, channel configuration, and encoding
- Absence of unintended truncation or processing artifacts

Reopen the excerpt in an audio analysis application when visual or auditory verification is needed.

## 7. Document Provenance and Reproducibility

Maintain a record of:

- NOAA collection and recording identifiers
- Original source URL and permissions evidence
- Recording date, location, and instrument metadata
- Original filename and checksum
- Retrieval procedure
- Selected interval and rationale
- Extraction command and software versions
- Output properties and checksum
- Unresolved metadata or identification uncertainty

## Quality Control

- Verify collection-specific access procedures.
- Confirm recording-level reuse permissions.
- Preserve original files and source metadata.
- Distinguish documented technical specifications from independently assessed audio quality.
- Avoid unsupported biological identification.
- Minimize unnecessary audio transformations.
- Independently verify extracted outputs.
- Preserve reproducible commands and processing parameters.

## Output

A verified acoustic excerpt with traceable NOAA source metadata, documented retrieval and extraction procedures, and reproducible processing parameters.
