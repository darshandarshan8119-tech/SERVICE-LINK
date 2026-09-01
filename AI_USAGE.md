# 🤖 AI Usage in the Development of ServiceLink

[![Antigravity](https://img.shields.io/badge/platform-Antigravity-6f42c1.svg?style=flat)](#)
[![Gemini](https://img.shields.io/badge/frontend-Gemini-4285F4.svg?style=flat&logo=googlegemini&logoColor=white)](https://deepmind.google/technologies/gemini/)
[![GPT](https://img.shields.io/badge/backend-GPT-10a37f.svg?style=flat&logo=openai&logoColor=white)](https://openai.com/)
[![Claude](https://img.shields.io/badge/backend-Claude-d97757.svg?style=flat&logo=claude&logoColor=white)](https://www.anthropic.com/claude)
[![React](https://img.shields.io/badge/react-%2320232a.svg?style=flat&logo=react&logoColor=%2361DAFB)](https://reactjs.org/)
[![Django](https://img.shields.io/badge/django-%23092E20.svg?style=flat&logo=django&logoColor=white)](https://www.djangoproject.com/)
![Human Reviewed](https://img.shields.io/badge/human--reviewed-100%25-brightgreen.svg?style=flat)

This document explains how AI models were used to design, build, and refine **ServiceLink** — a dual-sided marketplace platform connecting skilled blue-collar workers and tool renters with customers. It is provided for transparency and to demonstrate a responsible, well-documented approach to AI-assisted software development.

---

## 📋 Table of Contents

- [Overview](#1-overview)
- [Why Different Models for Different Layers](#2-why-different-models-for-different-layers)
- [How AI Was Used in Practice](#3-how-ai-was-used-in-practice)
- [Human Oversight and Responsible Use](#4-human-oversight-and-responsible-use)
- [What AI Was Not Used For](#5-what-ai-was-not-used-for)
- [Summary](#6-summary)

---

## 1. Overview

ServiceLink was built using **Antigravity**, a multi-model agentic development environment that allows different AI models to be used for different parts of the stack, based on their individual strengths. Rather than relying on a single model for the entire codebase, the project deliberately split responsibilities across models suited to each layer of the application.

| Layer | Tech Stack | AI Models Used |
|---|---|---|
| 🎨 Frontend | React (Vite), Tailwind CSS, React Router, Leaflet | ✨ Gemini models |
| ⚙️ Backend | Django REST Framework, JWT (SimpleJWT), MySQL | 🧠 GPT and Claude models |
| 🏗️ Architecture, debugging & review | — | Combination of all available models within Antigravity |

---

## 2. Why Different Models for Different Layers

- **Gemini models** were used for the frontend (component structure, UI logic, styling with Tailwind, and client-side routing), where their strength in rapidly iterating on visual/UI code was most useful.
- **GPT and Claude models** were used for the backend (Django apps for accounts, workers, tools, and bookings; REST API design; authentication; database models), where structured reasoning, API design consistency, and careful handling of business logic were priorities.
- Using multiple models allowed each part of the stack to be built with the model best suited to that kind of task, rather than forcing one model to handle everything equally well.

---

## 3. How AI Was Used in Practice

AI assistance was used across the following areas of the build:

- **Scaffolding and boilerplate** – generating initial Django app structures (`accounts`, `workers`, `tools`, `bookings`), REST serializers/views, and React component skeletons.
- **API design** – drafting and refining REST endpoints (e.g. `/api/auth/register`, `/api/auth/login`, `/api/workers`, `/api/bookings`) and their permission logic.
- **Debugging** – diagnosing errors during integration between the React frontend and Django backend, and resolving issues in local environment setup (MySQL configuration, JWT auth flow).
- **Code review** – reviewing AI-suggested code before committing it, checking for correctness, security gaps, and alignment with the intended data model.
- **Documentation** – assisting in writing structured project documentation, including the main README and setup instructions.

---

## 4. ✅ Human Oversight and Responsible Use

AI-generated output was **not committed as-is**. Every suggestion went through:

1. **Manual review** of generated code for correctness and security (e.g. verifying JWT handling, permission checks on booking endpoints, and that worker/tool listing endpoints were correctly scoped as public vs. restricted).
2. **Local testing** of each feature (authentication flow, booking creation/locking logic, API responses) before integration.
3. **Manual edits** to align AI output with the actual database schema and business rules of the project, rather than accepting generated logic blindly.
4. **Understanding before acceptance** — the goal was to use AI to accelerate implementation of a design that was already understood, not to generate an application the developer could not explain or defend.

---

## 5. 🚫 What AI Was Not Used For

- Final architectural decisions (choice of Django + MySQL for the backend, React + Vite for the frontend, JWT for auth) were made independently and then implemented with AI assistance.
- Grading-relevant academic explanations, project synopsis, and conceptual understanding (e.g. entity relationships, normalization decisions) were the developer's own work, with AI used only to assist in validating and documenting them.

---

## 6. 🏁 Summary

ServiceLink was built as a collaboration between deliberate human design decisions and targeted AI assistance — using Gemini models for frontend development and GPT/Claude models for backend development within the Antigravity environment, with every AI contribution reviewed, tested, and understood before being included in the final codebase.

<p align="center">Built with 🧠 human judgment + 🤖 AI assistance</p>
