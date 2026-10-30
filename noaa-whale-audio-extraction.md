# NOAA Whale Audio: Reproducible Extraction Workflow

## Purpose

Find a documented NOAA passive acoustic recording containing candidate whale vocalizations, select an interval, and extract a reproducible audio excerpt for close listening or subsequent bioacoustic analysis. This is a **targeted extraction**, not a representative soundscape survey or a behavioral analysis.

### Interactive option (recommended)

Download the companion script **`noaa-whale-audio-extraction.sh`** and run it in Terminal:

```bash
bash noaa-whale-audio-extraction.sh
```

The script works in two stages: **(1) retrieve the original and inspect its checksum, codec, channels, sample rate, and duration; (2) pause for listening/spectrogram review in Audacity, then ask for the selected start/end times and extract the excerpt.** It confirms before downloading and before extracting, preserves existing files, and writes a manifest with checksums and software version. It cannot establish the recording's license or biological identity; verify those from NOAA metadata and acoustic evidence.

The steps below remain a manual reference for the same process.

## 1. Select and verify a source

Use the [NOAA Passive Acoustic Data Archive](https://www.ncei.noaa.gov/products/passive-acoustic-data) or the relevant NOAA project portal to identify a recording with suitable whale acoustic content. Before retrieval, document its **collection/site, recording date and location, original filename, and reuse permissions**. Verify the license for the *applicable collection*; NOAA hosting alone does not establish CC0 status. Treat species labels as source annotations to be evaluated, not independent proof of identity.

- [SanctSound data-products metadata](https://www.fisheries.noaa.gov/inport/item/80343/full-list) (example of a NOAA collection with a documented CC0 1.0 designation)

## 2. Set the source for this recording

Replace the uppercase placeholders with the recording's verified source address and your local destination. Do not select timestamps yet.

```bash
SOURCE_URI='gs://BUCKET/PREFIX/ORIGINAL_FILENAME.wav'
SOURCE_FILE='raw/ORIGINAL_FILENAME.wav'
```

## 3. Retrieve and inspect

```bash
mkdir -p raw excerpts
gcloud storage cp "$SOURCE_URI" "$SOURCE_FILE"
shasum -a 256 "$SOURCE_FILE"
ffprobe -v error -show_entries format=duration:stream=codec_name,sample_rate,channels,bits_per_sample -of default=noprint_wrappers=1 "$SOURCE_FILE"
```

The `gcloud` command applies only to collections with a verified `gs://` object. For a verified HTTPS download, use the collection's documented method instead (for example, `curl -fL "$SOURCE_URI" -o "$SOURCE_FILE"` with an HTTPS URL).

## 4. Examine the original and select an interval

Open `"$SOURCE_FILE"` in Audacity. Listen and inspect the waveform or spectrogram; select an interval containing the acoustic event of interest. Document why its start and end boundaries were chosen. **Only now** fill in the extraction values:

```bash
START_SECONDS='START_TIME_IN_SECONDS'
DURATION_SECONDS='DURATION_IN_SECONDS'
OUTPUT_FILE='excerpts/EXCERPT_NAME.wav'
OUTPUT_CODEC='pcm_s24le'
```

`pcm_s24le` produces uncompressed signed 24-bit PCM. Choose a different codec if the source or analytical objective requires it. Without an explicit `-ar`, FFmpeg normally retains the input sample rate.

## 5. Extract and verify

```bash
ffmpeg -i "$SOURCE_FILE" -ss "$START_SECONDS" -t "$DURATION_SECONDS" -c:a "$OUTPUT_CODEC" "$OUTPUT_FILE"
ffprobe -v error -show_entries format=duration:stream=codec_name,sample_rate,channels,bits_per_sample -of default=noprint_wrappers=1 "$OUTPUT_FILE"
shasum -a 256 "$OUTPUT_FILE"
```

Open the excerpt in Audacity. Listen and inspect the waveform/spectrogram for complete boundaries, clipping, unexpected silence, or artifacts.

## 6. Record the result

- **Source:** NOAA collection/site, filename, URI, date/location, and license evidence
- **Selection:** start, end, duration, and acoustic rationale
- **Processing:** exact command, FFmpeg version, intentional format conversions
- **Verification:** source/output checksums, codec, sample rate, channels, duration, listening/visual findings

**Interpretation limit:** A labeled or acoustically distinct sound does not, by itself, establish an individual animal's identity or behavior.
