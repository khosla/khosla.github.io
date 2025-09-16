---
layout: post
title: "Disentangled & Self-Explainable Node Embeddings (DiSeNE): a quick tour"
date: 2025-09-16
tags: [graph learning, interpretability, disentanglement, GNN]
# image: /assets/images/hero-2400.jpg   # (optional thumbnail if you want)
---

TL;DR. Instead of learning black-box node vectors and bolting on post-hoc explainers, DiSeNE learns unsupervised embeddings whose dimensions are interpretable by design: each dimension maps to a concrete mesoscale substructure (e.g., an anchor/community) in the graph. You get dimension-wise explanations, competitive utility, and a clean way to tease apart structure from node features.
<!--more-->

## What’s the big idea?
DiSeNE bakes three goals into training: (1) **structural faithfulness** (capturing graph connectivity), (2) **dimensional interpretability** (each dimension ↔ a concrete subgraph), and (3) **structural disentanglement** (dimensions capture distinct structures). The magnitude of a node’s coordinate on a given dimension then has a clear reason: proximity/membership to that dimension’s subgraph.

## Structure vs. attributes: teasing them apart
A major perk of DiSeNE is that it lets you analyze the role of **structure** independently from **node metadata/features**. Because every embedding dimension maps to a specific subgraph, you can run three complementary experiments:

1) **Structure-only**: use **DiSeNE dimensions** as features to quantify the predictive power of topology alone.  
2) **Attributes-only**: use **node features** to measure the metadata signal.  
3) **Combined**: concatenate features + DiSeNE to measure **incremental lift** and interactions.

This avoids a common pitfall with end-to-end GNNs: message passing **entangles** structure and attributes, so many mixtures of neighborhoods and features can yield the **same prediction**, making post-hoc attributions non-identifiable. DiSeNE’s dimension→subgraph mapping gives you identifiable, human-readable **structural factors**, so you can say *which* parts of the graph matter—separately from metadata.

> **Practical tip:** feed **(features ⊕ DiSeNE dimensions)** into an **interpretable-by-design model**—e.g., sparse logistic regression/LASSO, a **generalized additive model** (EBM/GAM), a shallow decision tree, or a rule list. You’ll get global, stable explanations (coefficients/shape plots/rules) for both **structure** and **attributes**.

## How it works (intuitively)
- Train an unsupervised encoder (skip-gram/random-walk style) for embeddings.  
- Jointly learn a mapping **dimension → subgraph (anchor set)** and regularize for sparsity/distinctness so dimensions don’t collapse or overlap.  
- Explanations are **mesoscale**: beyond tiny local neighborhoods, but still concrete and inspectable.

## Making “explainable” measurable
DiSeNE introduces criteria to score interpretability, including **sparsity & comprehensibility** of dimension subgraphs, **overlap consistency** across dimensions, and **positional coherence** (higher coordinate ↔ closer to the associated subgraph).

## Where this helps
- **Trustworthy analytics:** point to the precise structure/anchors driving predictions.  
- **Auditable features:** treat dimensions as **concept features** in regulated pipelines.  
- **Exploratory mining:** surface cohesive modules or cross-community bridges you can visualize with domain experts.

<!-- ## Try it yourself (minimal workflow)
1) Compute DiSeNE embeddings **Z**.  
2) Build three models: **Z only**, **X (attributes) only**, **[X; Z]** combined.  
3) Use an **interpretable-by-design** learner (L1-logistic, EBM/GAM, shallow tree) to read off which **dimensions (structure)** and **attributes (metadata)** matter—and how. -->
