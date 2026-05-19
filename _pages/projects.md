---
layout: page
title: projects
permalink: /projects/
description: 
nav: true
horizontal: false
---

<!-- pages/projects.md -->
<div class="projects">
  {%- assign sorted_projects = site.projects | where_exp: "item", "item.title == 'PriXAI' or item.title == 'NetAudit' or item.title == 'SIG-AI-ACT'" | sort: "importance" -%}
  {% if page.horizontal -%}
  <div class="container">
    <div class="row row-cols-2">
    {%- for project in sorted_projects -%}
      {% include projects_horizontal.html %}
    {%- endfor %}
    </div>
  </div>
  {%- else -%}
  <div class="grid">
    {%- for project in sorted_projects -%}
      {% include projects.html %}
    {%- endfor %}
  </div>
  {%- endif -%}
</div>
