# XAKIAN Provenance

Public, minimal provenance records for selected XAKIAN releases.

The source repositories may remain private. Each record publishes the exact Git
commit and tree identifiers, a SHA-256 fingerprint of a deterministic Git
archive, the recorded dates, and the public deployment URLs. This creates a
dated public trail without publishing the source code itself.

## Records

- [Function Morphing Laboratory v1.0.0](records/function-morphing-laboratory/v1.0.0.json)
- [Cube Pose Boundary Lab v1.0.0](records/cube-pose-boundary-lab/v1.0.0.json)
- [Mapping Geometry Lab v1.0.0](records/mapping-geometry-lab/v1.0.0.json)
- [Cube Face Mapping Lab v1.0.0](records/cube-face-mapping-lab/v1.0.0.json)
- [Three-Variable Equation Fiber Lab v1.0.0](records/three-variable-equation-fiber-lab/v1.0.0.json)
- [Layered Function Mapping v1.0.0](records/layered-function-mapping/v1.0.0.json)
- [Dimensional Mapping Visualizer v1.0.0](records/dimensional-mapping-visualizer/v1.0.0.json)
- [XAKIAN homepage 2026.08.05.1](records/xakian-homepage/2026.08.05.1.json)
- [First Person Math Shooting Experiment v0.13.0](records/first-person-math-shooting-experiment/v0.13.0.json)

The machine-readable list is in [`index.json`](index.json). Record files follow
[`schema/provenance-v1.schema.json`](schema/provenance-v1.schema.json).

## Verify a fingerprint

If you have access to the matching source repository and commit, run:

```powershell
.\verify.ps1 `
  -RepositoryPath "C:\path\to\repository" `
  -Commit "3884e415f04b8b52fb92b26b87a9c025623d05b4" `
  -ExpectedSha256 "9299b646522de4c8e10289b1bf43e1eded982ef9df8e372c6ba86c98f343b9a7"
```

The digest input is the byte stream produced by:

```text
git archive --format=tar <commit>
```

Each release record also identifies its SSH-signed Git tag, signing-key
fingerprint, and GitHub verification time.

## Scope

These records are public evidence that a particular content fingerprint was
published here by a certain date. They complement GitHub history and Vercel
deployment history; they are not a substitute for an independent trusted
timestamp authority.
