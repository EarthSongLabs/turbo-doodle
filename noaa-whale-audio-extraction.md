# NOAA Passive Acoustic Recording Selection and Extraction

**Purpose:** Identify a suitable marine mammal vocalization in a publicly accessible NOAA passive acoustic recording, extract an uncompressed audio excerpt, and document the selection process for reproducibility.

**Output:** One uncompressed WAV excerpt, accompanied by source metadata and selection notes.

This workflow is reusable across recordings. Dataset locations, filenames, timestamps, and output encoding must be determined for each extraction.

## 1. Firefox — Identify the source dataset and verify licensing

Consult:

- [NOAA SanctSound metadata](https://www.fisheries.noaa.gov/inport/item/80343/full-list)
- [NOAA passive acoustic data archive](https://www.ncei.noaa.gov/products/passive-acoustic-data)

Identify an appropriate recording collection based on geographic location, recording period, documented biological activity, and available acoustic metadata.

For each candidate dataset:

1. Identify the original data provider and archive.
2. Verify the license or public-domain status of the **specific dataset and recording**. If CC0 1.0 is required, confirm that designation explicitly.
3. Identify the download method and actual file location.
4. Review the hydrophone location, sampling rate, number of channels, recording duration, and available instrument specifications.
5. Look for deployment notes, acoustic annotations, or other information indicating likely marine mammal activity.

Do not assume that all NOAA-hosted recordings share the same license.

**Record:** Dataset title, source URL, license evidence, location, recording date, and selected filename.

## 2. Firefox — Find a promising recording

Before downloading large files, investigate where useful vocalizations are most likely to occur.

Search available recording catalogs, deployment descriptions, annotations, or acoustic summaries for relevant species and periods of activity.

Consider:

- Documented or expected marine mammal presence
- Seasonal migration or vocal activity
- Hydrophone frequency response and sampling rate
- Available recording dates and durations
- Existing acoustic detections or annotations
- File size and practical download requirements

Select one promising recording to inspect.

If the archive provides preview audio, spectrograms, or annotated intervals, use those to narrow the search.

**Record:** Why this recording was selected and any known candidate intervals.

Do not describe an interval as a confirmed whale vocalization unless the available evidence supports that identification.

## 3. Terminal.app — Prepare the workspace and download

Create the working directories:

```bash
mkdir -p ~/whale_acoustics/{raw,excerpts,metadata}
cd ~/whale_acoustics
```

Check installed tools:

```bash
gcloud --version
ffmpeg -version
ffprobe -version
```

Install missing tools as needed. Google Cloud CLI is only necessary if the selected archive uses a compatible Google Cloud Storage access method.

### Download the selected recording

Use the archive's verified download method.

**If the recording is available through Google Cloud Storage:**

```bash
# List objects at the verified dataset location
gcloud storage ls "gs://VERIFIED_BUCKET/VERIFIED_PREFIX/"

# Download the selected recording
gcloud storage cp \
  "gs://VERIFIED_BUCKET/VERIFIED_PREFIX/recording.wav" \
  raw/recording.wav
```

These are placeholders. Replace the bucket, object path, and filename with verified values.

If the archive instead supplies HTTPS downloads or another access method, follow its documented instructions.

Preserve the original recording format and filename whenever practical.

### Inspect the downloaded audio

For a WAV recording:

```bash
ffprobe -v error \
  -show_entries format=duration:stream=codec_name,sample_rate,channels,bits_per_raw_sample,bits_per_sample \
  -of default=noprint_wrappers=1 \
  raw/recording.wav
```

Replace the filename if the downloaded recording is FLAC or another supported format.

Record the original encoding, sample rate, channel count, and duration.

## 4. Audacity — Inspect the recording and select an interval

Open the downloaded recording in Audacity.

Switch to **Spectrogram** view and configure the display for the frequency range of interest.

Examine the recording for candidate marine mammal vocalizations.

Evaluate:

- Distinct, biologically plausible acoustic features
- Discernible temporal and spectral structure
- Adequate signal-to-noise ratio
- Minimal interference from vessels, other calls, or environmental noise
- A complete call or meaningful call sequence
- Absence of clipping or major recording artifacts

Use the waveform alongside the spectrogram to evaluate signal amplitude and timing.

When useful, zoom into promising intervals and listen to the recording at its original playback rate.

**Select an interval** containing the desired vocalization, including enough context to preserve its beginning and ending.

Record:

- Start timestamp
- End timestamp
- Duration
- Acoustic characteristics
- Selection rationale
- Species identification, if supported
- Identification confidence and uncertainties

Do not infer species identity from a spectrogram alone without adequate supporting evidence.

### Example

Suppose a promising vocalization occurs between 12:30 and 13:00.

These timestamps are illustrative, not an identified recording.

## 5. Terminal.app — Extract the selected interval

Use FFmpeg to extract the selected interval directly from the original audio file.

**Example for a 24-bit PCM source:**

```bash
ffmpeg -ss 00:12:30 \
  -i raw/recording.wav \
  -t 30 \
  -map 0:a:0 \
  -c:a pcm_s24le \
  excerpts/whale_call_01.wav
```

Replace the timestamps, input filename, and output filename with the actual values.

Select an output codec appropriate to the source:

| Original audio encoding | Suggested WAV output |
|---|---|
| 16-bit integer
