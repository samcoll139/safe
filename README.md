# SafeGuard 3D AI - Women Safety Ecosystem (தமிழ் & English)

SafeGuard is a comprehensive women's safety ecosystem combining **7 Autonomous AI Agents**, a **Dedicated Counseling AI Model (Sakhi AI)**, a curated **Ladies Safety Products & Hardware Section**, and an **Immutable Blockchain Evidence Vault** (Polygon / IPFS).

---

## 🛍️ Ladies Safety Products & Hardware Section (பெண்கள் பாதுகாப்பு உபகரணங்கள்)

Directly paired with SafeGuard AI agents and fully compliant under Indian Law (**Section 96–106 IPC / Section 34–44 BNS: Right of Private Defence**):

| Product | Specifications & Features | Legal & AI Agent Integration |
|---|---|---|
| **🌶️ Tactical Cobra Pepper Spray (10% OC)** | 12-ft stream range, causes involuntary eye closure & intense coughing for 30–45 mins. | **100% Legal in India**. Safe Route Agent prompts user to keep it handy when walking in dark corridors. |
| **🔊 130dB Personal Panic Keychain Alarm** | 200m acoustic radius siren with high-intensity LED strobe. Pull-pin activation. | Airport & Metro security compliant. High-decibel siren automatically triggers Threat Agent's audio spike listener. |
| **💍 SafeGuard Bluetooth Smart SOS Ring** | Jewelry-grade waterproof ring with covert tactile panic button under the bezel. | Direct hardware trigger. Two clicks secretly dispatch SOS and commit blockchain proof without taking out the phone. |
| **👁️ RF Hidden Camera & Bug Detector Wand** | Infrared optical viewfinder reveals pinhole camera reflections in trial rooms & hotels. | Anti-voyeurism defense. Exposes hidden cameras to immediately file FIR under BNS Section 77. |
| **🚪 Portable Heavy-Duty Door Jammer Lock** | Steel wedge withstands 350+ lbs brute force. Slides under door in 5 seconds. | Solo female traveler hardware. Prevents unauthorized entry in hostels & hotels even with master keys. |

---

## 🤖 Dedicated Counseling AI Model: "Sakhi AI" (சகி AI)

A specialized trauma-informed mental health and legal defense companion tailored for women:
- **Trauma-Informed Protocol**: De-escalates panic, fear, and stalking anxiety with empathetic bilingual communication (Tamil, English, Tanglish).
- **Crisis Triaging**: Detects high-risk distress phrases (*"bayama iruku"*, *"following me"*, *"kaapathunga"*) and triggers the emergency SOS dispatch protocol.
- **Indian Legal Awareness Engine**:
  - **Zero FIR** rights under BNSS Section 173(1).
  - Protection against arrest/interrogation between sunset and sunrise.
  - Victim identity confidentiality under Section 72 BNS / 228A IPC.
  - Right of private self-defense (IPC 96–106).
- **Backend Architecture**: Specialized inference engine with optional Google Gemini API key passthrough (`GEMINI_API_KEY`).

---

## 📁 Repository Structure

```
women_safety_app/
├── backend/
│   ├── main.py                     # FastAPI server with /api/counseling-chat & /api/safety-products
│   └── agents/
│       ├── threat_agent.py         # Multi-sensor & voice keyword threat detector
│       └── counseling_agent.py     # Specialized Trauma-Informed Sakhi AI model
├── flutter_app/                    # Complete Flutter Project
│   ├── pubspec.yaml
│   └── lib/
│       ├── main.dart               # 9-Screen navigation shell
│       ├── services/
│       │   ├── localization_service.dart # Tamil & English translation engine
│       │   ├── blockchain_service.dart   # SHA-256 Merkle proofs & IPFS CID generator
│       │   └── agent_engine.dart         # Multi-agent orchestrator
│       └── screens/
│           ├── dashboard_screen.dart     # 3D Tactile SOS sphere & live risk gauge
│           ├── safety_products_screen.dart # Ladies safety gear catalog & legal specs
│           ├── counseling_screen.dart    # Sakhi AI specialized model interface
│           ├── user_manual_screen.dart   # 5-step easy user guide & speed dial
│           ├── threat_screen.dart        # Real-time accelerometer & voice simulation
│           ├── safe_route_screen.dart    # AI corridor recommendations & safe havens
│           ├── blockchain_vault_screen.dart # Tamper-proof evidence ledger & verifier
│           ├── case_management_screen.dart # BNS FIR generator with ZK anonymity
│           └── audit_screen.dart         # Police SLA watchdog & auto-escalation
├── frontend/
│   └── index.html                  # Full 3D Interactive Web App (Open in any browser!)
└── contracts/
    └── WomenSafetyVault.sol        # Solidity smart contract with SLA escalations
```

---

## 🚀 How to Run & Test
1. **Interactive 3D Web App**: Double-click `frontend/index.html` in Chrome/Edge. Test the 3D SOS button, talk to Sakhi AI, explore the Ladies Safety Products section, and toggle between Tamil and English.
2. **Flutter App**: `cd flutter_app && flutter run` (when Flutter SDK is configured).
3. **Python Backend**: `cd backend && pip install fastapi uvicorn && python main.py`.
