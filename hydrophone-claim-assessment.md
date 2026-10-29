# Hydrophone Recording: Scientific Claim and Metadata Assessment

**Domain / Role:** Underwater acoustics / Scientific metadata assessment  
**Goal:** Determine which scientific inferences can be supported by a single hydrophone recording, distinguishing direct acoustic observations from species identification, behavioral interpretation, and population-level conclusions.

**Applications:** Firefox; Terminal.app; Audacity (optional)  
**Starting materials:** One verified hydrophone recording and its associated deployment documentation, to be sourced.  
**Deliverable:** A claim-to-metadata assessment matrix identifying evidence, support levels, uncertainties, missing metadata, and the next information request.

## Step 1 — Establish recording provenance

**Application: Firefox**

1. Identify a scientifically documented hydrophone recording from a credible source.
2. Locate the recording's original metadata and deployment documentation.
3. Record the available information:
   - Source archive and recording identifier
   - Recording date, time, and duration
   - Hydrophone location, coordinates, and depth
   - Instrument model and deployment configuration
   - Sampling specifications
   - Calibration information, if available
   - Species annotations or associated observations, if any
   - Licensing and access conditions
4. Distinguish documented information from assumptions or missing fields.
5. Save direct links to the original documentation.

**Verification:** Each recorded metadata value must be traceable to its source. Do not infer missing deployment details from unrelated recordings or general archive descriptions.

## Step 2 — Inspect the audio file's technical properties

**Application: Terminal.app**

Navigate to the directory containing the verified recording.

```bash
cd ~/hydrophone_assessment
```

Inspect the file using FFprobe:

```bash
ffprobe -v error \
  -show_entries format=filename,format_name,duration,size \
  -show_entries stream=codec_name,sample_rate,channels,bits_per_raw_sample \
  -of json recording.wav
```

Replace `recording.wav` with the actual filename.

Record:

- File format and audio codec
- Sample rate
- Channel count
- Bit depth, if reported
- Recording duration
- File size

Compare these properties against the archive's documentation.

**Verification:** File-level technical properties are not substitutes for deployment metadata. A sample rate, for example, does not establish hydrophone calibration, recording location, or the identity of a sound source.

## Step 3 — Examine observable acoustic characteristics

**Application: Audacity (optional)**

1. Open the recording.
2. Inspect the waveform and spectrogram.
3. Document directly observable features, such as:
   - Acoustic events and their timestamps
   - Frequency ranges and temporal patterns
   - Repeated or overlapping signals
   - Background noise and potential interference
   - Clipping or other apparent recording artifacts
4. Distinguish observed patterns from interpretations of their biological origin.

If acoustic inspection is not performed, explicitly mark observations as **not assessed**.

**Verification:** Do not interpret an unidentified acoustic event as a confirmed species vocalization without supporting evidence.

## Step 4 — Assess four scientific claims

**Application: Markdown table or spreadsheet**

Evaluate the following candidate claims against the available recording and metadata.

| Candidate claim | Evidence needed |
|---|---|
| 1. An acoustic event with identifiable temporal and spectral characteristics occurs in the recording. | Audio inspection, timestamps, file specifications |
| 2. The event was produced by a particular species. | Diagnostic acoustic features, validated annotations, supporting identification evidence |
| 3. The event indicates a particular behavior. | Established behavioral associations, appropriate observational context, supporting research |
| 4. The recording supports conclusions about population abundance or trends. | Sampling design, detection probability, recording effort, spatial and temporal coverage, analytical validation |

For each claim, document:

- **Support level:** Supported / Partially supported / Unsupported / Not assessed
- **Evidence:** Direct observations, technical properties, or documented metadata
- **Uncertainty:** Alternative explanations and limits of inference
- **Missing information:** Minimum additional metadata or evidence required
- **Next request:** Specific information needed to improve the assessment

Treat these as candidate claims to test, not conclusions to affirm.

## Step 5 — Identify the next metadata request

**Applications: Firefox; matrix document**

Review the four assessments and prioritize missing information.

Possible requests include:

- Hydrophone coordinates, depth, and deployment dates
- Instrument sensitivity and calibration records
- Full recording context and original unprocessed audio
- Species annotation methods and validation
- Associated visual observations or environmental measurements
- Sampling effort and detection methodology

Select the request most likely to resolve a meaningful uncertainty in the assessment.

**Verification:** The requested information must address a specific evidence gap rather than simply add descriptive detail.

## Final deliverable

A claim-to-metadata matrix containing:

1. Four candidate scientific claims.
2. Support levels grounded in available evidence.
3. Direct links or references to supporting documentation.
4. Explicit uncertainty and alternative explanations.
5. Minimum missing metadata for each claim.
6. A prioritized next metadata request.

## Quality-control checklist

- [ ] Recording provenance has been verified.
- [ ] File properties were extracted from the actual recording.
- [ ] Deployment metadata and file properties are distinguished.
- [ ] Acoustic observations are separated from biological interpretations.
- [ ] No unsupported species or behavioral claims are presented as facts.
- [ ] Population-level conclusions are not inferred from one recording alone.
- [ ] Each claim has a documented support level and evidence basis.
- [ ] Missing metadata and uncertainties are explicit.
- [ ] The next information request addresses an identifiable evidence gap.

**Workflow status:** Assessment framework documented; source recording and actual claim evaluation pending.
