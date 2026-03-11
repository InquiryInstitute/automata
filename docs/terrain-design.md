# Castalia terrAIn

## Embodied AI Robotics Sandbox

**An open research platform for embodied intelligence.**

terrAIn is a physical robotics environment where autonomous construction vehicles learn to interact with real terrain — in a raised bed of soil, sand, or gravel.

Inspired by robotics research labs, construction automation, and the practical scale of garden and greenhouse beds, terrAIn brings embodied AI experimentation into homes, schools, and research environments.

The platform combines:

- **AI**
- **robotics**
- **simulation**
- **perception**
- **real terrain interaction**

to create a closed-loop learning system between simulation and reality.

---

## Vision

Most AI today is **disembodied**.

Large language models reason in text but have no physical understanding of the world.

Yet intelligence evolved through interaction with matter.

*Digging. Moving. Building. Shaping terrain.*

terrAIn explores a fundamental question:

**What happens when AI learns by shaping the physical world?**

---

## Core Concept

A **4×8 ft** robotics terrain bed — the same footprint as a standard raised garden or greenhouse bed — containing soil, sand, or gravel where autonomous miniature construction vehicles operate.

Robots perform tasks such as:

- digging
- grading
- trenching
- hauling
- terrain leveling

while AI models learn physics-aware planning. The bed can double as a real garden: prepare soil, run experiments, add irrigation or planting, and let robots work alongside growing things.

---

## System Overview

terrAIn integrates five layers:

1. **Physical Terrain Environment**
2. **Autonomous Robots**
3. **Perception System**
4. **AI Planning Stack**
5. **Simulation (Isaac Sim)**

---

## Physical Environment

### Terrain Bed

**Standard size: 4 ft × 8 ft**

This matches common greenhouse and garden bed sizes.

| parameter | value    |
|-----------|----------|
| length    | 8 ft     |
| width     | 4 ft     |
| depth     | 12–18 in |
| material  | wood or steel frame |
| fill      | soil / sand / gravel |

### Terrain Materials

The system can operate with:

- construction sand
- soil
- gravel
- compost
- mixed substrates

Each material produces different AI learning conditions.

### Gardening & scale

The 4×8 ft bed matches common **raised garden** and **greenhouse** dimensions. terrAIn can sit in a backyard, on a patio, or inside a greenhouse; robots work the same soil you might plant in. Optional irrigation and moisture sensors support both robotics experiments and real planting — terrain prep and growing in one footprint.

### Bed Features

The bed includes:

- vehicle ramp entry
- soil storage zone
- fiducial markers
- calibration grid

**Optional (gardening & growth):**

- irrigation system
- moisture sensors
- plant growth experiments (e.g. starts or seed beds in one zone while robots work another)
- greenhouse or covered placement for year-round use

---

## Robots

The platform uses **Huina** RC construction vehicles as the reference platform. All terrAIn vehicle kits are based on Huina chassis; we assume Huina dimensions and scale for beds, simulation, and documentation.

**Reference base models (Huina):**

- Huina 1550 excavator
- Huina 1580 excavator
- Huina dump truck
- Huina bulldozer
- Huina loader (where applicable)

### Robot Dimensions

Example excavator (Huina 1550):

| parameter | value   |
|-----------|---------|
| length    | 25 cm   |
| width     | 16 cm   |
| height    | 16 cm   |
| scale     | 1:14    |

This size works well inside a 4×8 terrain bed. The bed length fits approximately **10 excavator lengths**.

### Robot Hardware Architecture

Each robot is upgraded to become an AI robotics node.

**Core compute: ESP32-S3**

Functions:

- motor control
- sensor interface
- wireless communication

### Robot Electronics

| component    | details |
|-------------|---------|
| **Core board** | ESP32-S3 — WiFi, BLE, vector instructions, sufficient compute for edge control |
| **Motor drivers** | H-bridge drivers, PWM control |

### Sensors

Each robot may include:

| sensor       | purpose           |
|-------------|-------------------|
| IMU         | orientation       |
| encoders    | motion tracking   |
| depth camera| terrain perception|
| ToF sensor  | obstacle detection|

### Depth Perception

**Example module:** Sipeed MaixSense A010 RGBD ToF camera  
**Approx cost:** $30  

Features:

- depth sensing
- onboard RISC-V processor
- USB / UART interface
- ROS compatibility

### Communication

Robots communicate with the main system via **WiFi**.

**Protocol:** ROS2 DDS  

Edge nodes run **micro-ROS**.

### Controllers: Atlas DS / Tricorder

terrAIn uses **Atlas DS** and **Tricorder** as the controller platform. The **dual-screen (DS) layout is the best fit**: bottom screen = **bed view** (overhead terrain map from the gantry), top screen = **vehicle view** (live camera feed from the selected robot).

- **Bottom screen — bed view:** Overhead map of the 4×8 bed, robot positions, terrain height or task overlay. Plan and supervise from above.
- **Top screen — vehicle view:** First-person or chase camera from the Huina vehicle. Drive, aim the bucket, or monitor autonomy.

One handheld gives you both the big picture and the driver’s seat; manual override, teleop, and field configuration in a single workflow. Same stack across terrAIn Home and Research.

**Docs and firmware:** [atlas.inquiry.institute](https://atlas.inquiry.institute)

---

## ROS2 Architecture

The system uses ROS2 for coordination.

```
terrAIn Server (ROS2)
 ├ perception
 ├ terrain mapping
 ├ planning
 ├ robot coordination
 └ simulation bridge
      │
      │ DDS
      │
 Robots (micro-ROS)
```

### Central Compute

terrAIn requires a central robotics server.

**Recommended:** NVIDIA Jetson Orin Nano  

Capabilities:

- GPU acceleration
- ROS2
- Isaac ROS
- CV pipelines

**Alternative:** mini PC.

---

## Perception System

terrAIn includes an **overhead perception gantry**.

**Purpose:**

- track robots
- map terrain
- generate ground truth data

### Sensors

| sensor           | role                |
|------------------|---------------------|
| RGB camera       | tracking            |
| depth camera     | terrain mapping     |
| LIDAR            | optional            |
| AprilTag detection | robot localization |

### Terrain Mapping

The system constructs **3D terrain height maps**.

Used for:

- planning
- reinforcement learning
- simulation calibration

---

## Simulation

The system integrates with **NVIDIA Isaac Sim**.

This allows:

- simulation training
- policy development
- transfer learning

### Sim-to-Real Loop

```
Isaac Sim
   │
   │ train policies
   │
   ▼
ROS2 deployment
   │
   │ real terrain experiments
   │
   ▼
data feedback
   │
   │ improve policies
   │
   ▼
Isaac Sim
```

---

## Research Applications

terrAIn enables experiments in:

- **Embodied AI** — How intelligence emerges through physical interaction.
- **Terrain manipulation** — Robots learn to modify terrain structures.
- **Multi-agent coordination** — e.g. excavator loads truck, truck transports soil, dozer levels terrain.
- **Reinforcement learning** — Tasks: digging trenches, leveling surfaces, constructing shapes.
- **Construction robotics** — Similar research: Caterpillar, Built Robotics, MIT CSAIL.

---

## Remote Lab

terrAIn can be exposed as a **remote robotics lab**.

Students access robots through a **web interface**.

They submit:

- programs
- AI models
- experiments

The lab executes them physically.

### Remote Lab Architecture

```
User
 │
Web interface
 │
Cloud scheduler
 │
ROS2 server
 │
terrAIn robots
```

---

## Certification Programs

terrAIn supports certification tracks.

### terrAIn Level 1 — Robotics Foundations

Topics: robot kinematics, sensors, microcontrollers, ROS basics.

### terrAIn Level 2 — Embodied AI

Topics: reinforcement learning, terrain perception, planning.

### terrAIn Level 3 — Autonomous Construction

Topics: multi-robot coordination, excavation planning, terrain modeling.

### Educational Value

Students learn **robotics**, **AI**, **physics**, and **systems engineering** through physical experimentation.

---

## Estimated Costs

### Robots

| component           | cost     |
|--------------------|----------|
| RC excavator base  | $25      |
| ESP32 board        | $5       |
| motor drivers       | $6       |
| sensors            | $20–30   |

**Robot total:** $50–70

### Terrain bed

| item       | cost  |
|------------|-------|
| wood frame | $150  |
| soil       | $50   |
| ramp       | $30   |

**Bed total:** ~$250

### Perception system

| item         | cost  |
|--------------|-------|
| RGB camera   | $50   |
| depth sensor | $150  |
| mount        | $80   |

### Compute

**Jetson Orin Nano:** $500

### Example System Cost

| item           | cost   |
|----------------|--------|
| robots (3)     | $200   |
| bed            | $250   |
| sensors        | $200   |
| compute        | $500   |

**Total ≈ $1,150**

---

## Product Line

Individual robots and the base station. All vehicles run ESP32-S3 and micro-ROS; the base station runs ROS2, perception, and coordination.

### Robotic construction vehicles

| Product       | Huina reference | Description | Price (kit) |
|---------------|-----------------|-------------|-------------|
| **Excavator** | 1550 / 1580     | Tracked excavator, arm + bucket. Dig, trench, load. 1:14 scale. | $65 – $85 |
| **Dump truck** | Huina dump truck | Haul soil, gravel. Articulated dump bed. Pairs with excavator. | $55 – $75 |
| **Bulldozer** | Huina bulldozer  | Tracked dozer, blade. Grade, level, push. Terrain shaping. | $60 – $80 |
| **Loader**    | Huina loader     | Front loader / wheel loader. Load, carry, place material. | $55 – $75 |

Each vehicle kit includes: Huina RC base, ESP32-S3 board, motor drivers, optional IMU/depth. Add sensors and ToF as needed.

### Jetson base station

| Product | Description | Price |
|---------|-------------|--------|
| **terrAIn Base Station** | NVIDIA Jetson Orin Nano. ROS2, perception stack, terrain mapping, multi-robot coordination. Optional overhead gantry + RGB/depth kit. | $499 – $599 |

One base station runs the whole fleet; add vehicles and optional gantry to scale.

---

## Product Strategy

Two product tiers.

### terrAIn Home

**Price target:** $599–$899  

Includes: bed kit, one robot (excavator or dump truck), base station or single-node setup, sensors, software.

### terrAIn Research

**Price target:** $2,000–$4,000  

Includes: Jetson base station, multiple robots (excavator, truck, dozer, loader), perception gantry, full ROS2 stack, Isaac Sim integration.

### Open Research Platform

terrAIn is intended to be:

- open source
- extensible
- modular

Researchers can add new vehicles, new tasks, and new AI models.

---

## Why This Matters

AI must eventually understand **matter**, **physics**, **force**, and **terrain**.

Language alone is insufficient.

terrAIn allows AI to learn **how the world pushes back**.

---

## Tagline

**terrAIn: Where AI Learns to Move Earth.**
