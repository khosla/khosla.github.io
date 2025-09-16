---
layout: post
title: "Disentangled & Self-Explainable Node Embeddings (DiSeNE): a quick tour"
date: 2025-09-16
tags: [graph learning, interpretability, disentanglement, GNN]
# image: /assets/images/hero-2400.jpg   # (optional thumbnail if you want)
---

TL;DR. Instead of learning black-box node vectors and bolting on post-hoc explainers, DiSeNE learns unsupervised embeddings whose dimensions are interpretable by design: each dimension maps to a concrete mesoscale substructure (e.g., an anchor/community) in the graph. You get dimension-wise explanations, competitive utility, and a clean way to tease apart structure from node features.
<!--more-->

##What is the problem with “explain the GNN after the fact”

End-to-end GNNs mix structure and features during message passing: many different combinations of neighborhoods and attributes can yield the same prediction, so post-hoc attributions lead to multiple plausible explanations. DiSeNE sidesteps this by separating concerns: it learns structural factors first—one per dimension—so you can study what the graph alone contributes before adding metadata.

## Key Idea
DiSeNE jointly optimizes three goals: connectivity preservation (a random-walk/skip-gram objective), dimensional interpretability (each dimension “explains” edges via a subgraph), and structural disentanglement (dimensions capture distinct structures). A light entropy regularizer prevents empty/degenerate dimensions. Crucially, a node’s coordinate on a dimension grows with its proximity to that dimension’s explanation subgraph—so the magnitude itself is meaningful.

**Why this matters. Each coordinate now has a reason (“close to subgraph Sₖ”), not just a number that happens to work in a downstream task. That makes the embedding space auditable and easy to discuss with domain experts


## Measuring interpretability (not just accuracy)
The paper proposes new task-agnostic metrics for self-explainable embeddings, including Topological Alignment (do per-dimension explanation masks align with human-interpretable structures like communities?), Overlap Consistency (do overlaps between explanation subgraphs match correlations between dimensions?), and Positional Coherence (do higher coordinate values mean closer to the subgraph?).


<!-- ## How it works (intuitively)
- Train an unsupervised encoder (skip-gram/random-walk style) for embeddings.  
- Jointly learn a mapping **dimension → subgraph (anchor set)** and regularize for sparsity/distinctness so dimensions don’t collapse or overlap.  
- Explanations are **mesoscale**: beyond tiny local neighborhoods, but still concrete and inspectable.

## Making “explainable” measurable
DiSeNE introduces criteria to score interpretability, including **sparsity & comprehensibility** of dimension subgraphs, **overlap consistency** across dimensions, and **positional coherence** (higher coordinate ↔ closer to the associated subgraph).

## Where this helps
- **Trustworthy analytics:** point to the precise structure/anchors driving predictions.  
- **Auditable features:** treat dimensions as **concept features** in regulated pipelines.  
- **Exploratory mining:** surface cohesive modules or cross-community bridges you can visualize with domain experts. -->

<!-- ## Try it yourself (minimal workflow)
1) Compute DiSeNE embeddings **Z**.  
2) Build three models: **Z only**, **X (attributes) only**, **[X; Z]** combined.  
3) Use an **interpretable-by-design** learner (L1-logistic, EBM/GAM, shallow tree) to read off which **dimensions (structure)** and **attributes (metadata)** matter—and how. -->
