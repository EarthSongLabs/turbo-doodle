# Spectrogram Parameter Selection for Bioacoustic Analysis

## Purpose

Select and justify spectrogram parameters appropriate to the acoustic characteristics and analytical objectives of a target vocalization.

This workflow supports bioacoustic research, acoustic ecology, field recording analysis, and other applications requiring interpretable time-frequency representations.

## Method

### 1. Establish recording context

Identify the source recording, sample rate, channel configuration, recording provenance, and target acoustic event.

Define the analytical objective, such as resolving:

- Fine frequency structure or closely spaced harmonics
- Rapid frequency modulation
- Short pulses or call onset and offset
- Temporal spacing between vocalizations
- Weak signals against background noise

### 2. Identify relevant parameters

Consider the effects of:

| Parameter | Analytical consideration |
|---|---|
| FFT/window length | Tradeoff between frequency resolution and temporal localization |
| Window function | Spectral leakage, sidelobe suppression, and effective frequency resolution |
| Window overlap / hop size | Density of time samples and visual continuity |
| Frequency range and scale | Visibility and interpretability of target frequency structure |
| Dynamic range and display limits | Visibility of weak signals relative to background noise |
| Amplitude scaling | Consistency and comparability of displayed signal intensity |

Distinguish changes in the underlying analysis from changes in display settings.

### 3. Compare candidate configurations

Select two or three configurations that represent meaningful analytical tradeoffs.

Analyze the same recording interval with consistent frequency bounds, amplitude scaling, and display conditions wherever possible.

Compare:

- Frequency separation and harmonic visibility
- Temporal smearing of rapid features
- Signal contrast and background noise
- Spectral leakage
- Potentially misleading visual effects

Record the complete settings for each configuration.

### 4. Evaluate suitability

Assess which configuration best supports the defined analytical question.

Consider whether improved frequency discrimination obscures timing, whether short windows obscure narrowband structure, and whether display settings suppress relevant weak features.

Where different questions require different settings, retain more than one configuration rather than claiming a universal optimum.

### 5. Document the decision

Prepare a concise parameter-selection record containing:

- Recording identifier and analytical objective
- Target interval and relevant acoustic characteristics
- Candidate parameter configurations
- Comparative spectrogram figures
- Observed strengths and limitations
- Recommended configuration and rationale
- Remaining uncertainty

## Quality Control

- Verify recording provenance and technical properties.
- Compare the same acoustic interval across configurations.
- Document window type, FFT/window length, overlap, frequency range, and display settings.
- Maintain consistent comparison conditions or explicitly identify differences.
- Distinguish apparent visual detail from actual resolving power.
- Avoid interpreting display artifacts as biological features.
- Select parameters for the analytical objective rather than visual attractiveness.
- Preserve original audio and reproducible settings.

## Output

A documented, reproducible parameter-selection decision supported by comparative spectrograms, explicit analytical tradeoffs, and a justified recommendation.
